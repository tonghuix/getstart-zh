#!/bin/sh
#
mkdir -p installguide/html
mkdir installguide/pdf
mkdir installguide/source

mv -vf *.html installguide/html
mv -vf FGShortRef.html installguide/html
mv -vf *.gif installguide/html
mv -vf *.css installguide/html
mv -vf *.pdf installguide/pdf
cp -vf *.tex installguide/source
cp -vf *.eps installguide/source
cp -vf *.jpg installguide/source
cp -vf makegetstart.sh installguide/source
cp -vf makeshortref.sh installguide/source
cp -vf packing.sh installguide/source

cd installguide
zip ../fgfs-manual-0.8.zip -ry *
cd ..; rm -rv installguide


