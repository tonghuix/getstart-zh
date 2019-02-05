#!/bin/sh

BUILD_DIR=$1
CACHE_DIR=$2
ENV_DIR=$3
MAGICK_DIR="$BUILD_DIR/.magick"
VENDOR_DIR="$BUILD_DIR/vendor"
INSTALL_DIR="$VENDOR_DIR/imagemagick"
CACHE_FILE="$CACHE_DIR/imagemagick.tar.gz"

export_env_dir() {
  env_dir=$1
  whitelist_regex=${2:-'MAGICK_POLICY_OVERRIDE'}
  blacklist_regex=${3:-'^(PATH|GIT_DIR|CPATH|CPPATH|LD_PRELOAD|LIBRARY_PATH)$'}

  echo "-----> Exporting env directory for ImageMagick policy buildpack"
  if [ -d "$env_dir" ]; then
    for e in $(ls $env_dir); do
      echo "$e" | grep -E "$whitelist_regex" | grep -qvE "$blacklist_regex" &&
      export "$e=$(cat $env_dir/$e)"
      :
    done
  fi
}

export_env_dir $ENV_DIR
echo "       ImageMagick override: $MAGICK_POLICY_OVERRIDE"

if [ -f $MAGICK_DIR/policy.xml -a -z "$MAGICK_POLICY_OVERRIDE" ]; then
  echo "-----> Skipping as .magick/policy.xml already exists and no override was requested"
  export MAGICK_CONFIGURE_PATH="$MAGICK_DIR"
elif [ -f $MAGICK_DIR/policy.xml -a -n "$MAGICK_POLICY_OVERRIDE" ]; then
  echo "-----> Replacing ImageMagick policy file"
  rm $MAGICK_DIR/policy.xml
  cat > $MAGICK_DIR/policy.xml <<EOF
  <policymap>
  <policy domain="resource" name="memory" value="1GiB"/>
  <policy domain="resource" name="map" value="2GiB"/>
  <policy domain="resource" name="width" value="25KP"/>
  <policy domain="resource" name="height" value="25KP"/>
  <policy domain="resource" name="area" value="128MB"/>
  <policy domain="resource" name="disk" value="4GiB"/>
  <policy domain="delegate" rights="none" pattern="URL" />
  <policy domain="delegate" rights="none" pattern="HTTPS" />
  <policy domain="delegate" rights="none" pattern="HTTP" />
  <policy domain="path" rights="none" pattern="@*" />
  <policy domain="cache" name="shared-secret" value="passphrase" stealth="true"/>
  </policymap>
EOF
  export MAGICK_CONFIGURE_PATH="$MAGICK_DIR"
elif [ -n "$MAGICK_POLICY_OVERRIDE" ]; then
  echo "-----> Writing ImageMagick policy file"
  mkdir -p $MAGICK_DIR
  cat > $MAGICK_DIR/policy.xml <<EOF
  <policymap>
  <policy domain="resource" name="memory" value="1GiB"/>
  <policy domain="resource" name="map" value="2GiB"/>
  <policy domain="resource" name="width" value="25KP"/>
  <policy domain="resource" name="height" value="25KP"/>
  <policy domain="resource" name="area" value="128MB"/>
  <policy domain="resource" name="disk" value="4GiB"/>
  <policy domain="delegate" rights="none" pattern="URL" />
  <policy domain="delegate" rights="none" pattern="HTTPS" />
  <policy domain="delegate" rights="none" pattern="HTTP" />
  <policy domain="path" rights="none" pattern="@*" />
  <policy domain="cache" name="shared-secret" value="passphrase" stealth="true"/>
  </policymap>
EOF
  export MAGICK_CONFIGURE_PATH="$MAGICK_DIR"
else
  echo "-----> Skipping and using default policy.xml"
fi


echo "-----> Install ImageMagick"
if [ ! -f $CACHE_FILE ]; then
  # install imagemagick
  IMAGE_MAGICK_VERSION="6.9.10-24"
  IMAGE_MAGICK_FILE="ImageMagick-$IMAGE_MAGICK_VERSION.tar.gz"
  IMAGE_MAGICK_DIR="ImageMagick-$IMAGE_MAGICK_VERSION"
  IMAGE_MAGICK_URL="https://imagemagick.org/download/$IMAGE_MAGICK_FILE"

  echo "-----> Downloading ImageMagick from $IMAGE_MAGICK_URL"
  curl -L --silent $IMAGE_MAGICK_URL | tar xz

  echo "-----> Building ImageMagick"
  cd $IMAGE_MAGICK_DIR
  export CPPFLAGS="-I$INSTALL_DIR/include"
  export LDFLAGS="-L$INSTALL_DIR/lib"
  ./configure --prefix=$INSTALL_DIR
  make && make install
  cd ..
  rm -rf $IMAGE_MAGICK_DIR

  # cache for future deploys
  echo "-----> Caching ImageMagick installation"
  cd $VENDOR_DIR
  REL_INSTALL_DIR="imagemagick"
  tar czf $REL_INSTALL_DIR.tar.gz $REL_INSTALL_DIR
  mv $REL_INSTALL_DIR.tar.gz $CACHE_FILE
else
  # cache exists, extract it
  echo "-----> Extracting ImageMagick $CACHE_FILE => $VENDOR_DIR"
  tar xzf $CACHE_FILE -C $VENDOR_DIR
fi

# update PATH and LD_LIBRARY_PATH
echo "-----> Updating environment variables"
PROFILE_PATH="$BUILD_DIR/.profile.d/imagemagick.sh"
ACTUAL_INSTALL_PATH="$HOME/vendor/imagemagick"
mkdir -p $(dirname $PROFILE_PATH)
echo "export PATH=$ACTUAL_INSTALL_PATH/bin:\$PATH" >> $PROFILE_PATH
echo "export LD_LIBRARY_PATH=$ACTUAL_INSTALL_PATH/lib:\$LD_LIBRARY_PATH" >> $PROFILE_PATH
