#!/bin/sh
mkdir installguide
cd installguide
mkdir html
mkdir pdf
mkdir source

cd..
copy *.html installguide\html
copy FGShortRef.html installguide\html
copy *.gif installguide\html
copy *.css installguide\html
copy *.pdf installguide\pdf
copy *.tex installguide\source
copy *.eps installguide\source
copy *.jpg installguide\source
copy makedoku.bat installguide\source
copy makeshortref.bat installguide\source
copy packing.bat installguide\source

cd installguide
zip fgfs-manual-0.8.zip -r *.*
copy fgfs-manual-0.8.zip ..
del fgfs-manual-0.8.zip

cd html
del *.gif
del *.html
del *.css
cd ..
cd pdf
del *.pdf
cd ..
cd source
del *.tex
del *.eps
del *.jpg
del makedoku.bat
del makeshortref.bat
del packing.bat
cd ..

rmdir html
rmdir pdf
rmdir source
cd..
rmdir installguide


