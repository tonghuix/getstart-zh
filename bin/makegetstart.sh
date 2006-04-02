#!/bin/sh
# Shell script for building FlightGear getting Started manual.
# Supposes a working TeX system including LaTeX and pdflatex
# plus TeX4HT (http://www.cis.ohio-state.edu/~gurari/TeX4ht/mn.html)
#
cd `dirname $0`
export BASEDIR=`pwd`
. ${BASEDIR}/common.sh
SOURCE=getstart

cleanup

for FILENAME in *.eps; do
  NAMEBASE=`echo ${FILENAME} | cut -f 1 -d \.`
  RESOLUTION=`identify ${FILENAME} | awk '{print $3}'`
  XRES=`echo "${RESOLUTION}" | awk -F x '{print $1}'`
  YRES=`echo "${RESOLUTION}" | awk -F x '{print $2}'`
  # Never scale the image if the smaller edge is already below 480 dots
  if [ ${XRES} -lt 480 -o ${YRES} -lt 480 ]; then
    echo "leave image unchanged"
    RESIZE=""
  else
    # Determine the small edge of the image
    echo "change image size"
    if [ ${XRES} -lt ${YRES} ]; then
      SMALL=${XRES}
      LARGE=${YRES}
    else
      SMALL=${YRES}
      LARGE=${XRES}
    fi
    # Determine scaling factor - rough, but working as expected;
    # scale the image so that the smaller edge is in the proximity but
    # never below 480 dots
    DIVISOR=`expr ${SMALL} / 480`
    SIZE=`expr ${LARGE} / ${DIVISOR}`
    RESIZE="-resize ${SIZE}x${SIZE}"
  fi
  convert -depth 16 -normalize ${RESIZE} ${FILENAME} ${NAMEBASE}\.jpg
done

buildpdf

# PDF generation is done now. I consider this as the most valuable because I
# like reading printed manuals  ;-)
# Now deal with HTML generation for our nice web site. Start with Cleanup.
# 
#cleanup

${HTLATEX} getstart "html,2,info,next,sections+" getstart.lg getstart.lg getstart.lg getstart.lg
${HTLATEX} getstart "html,2,info,next,sections+" getstart.lg getstart.lg getstart.lg getstart.lg
#makeindex -o getstart.out getstart.in
${HTLATEX} getstart "html,2,info,next,sections+" getstart.lg getstart.lg getstart.lg getstart.lg
# Run the packaging script _now_ !
