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

#for i in *.eps; do
#  convert -resize 480x480 $i `echo $i | sed -e 's/.eps\$/.jpg/g'`
#done

buildpdf

# PDF generation is done now. I consider this as the most valuable because I
# like reading printed manuals  ;-)
# Now deal with HTML generation for our nice web site. Start with Cleanup.
# 
#cleanup

#${HTLATEX} getstart "html,2,info,next,sections+" %1 %2 %3 %4
#${HTLATEX} getstart "html,2,info,next,sections+" %1 %2 %3 %4
#makeindex -o getstart.out getstart.in
#${HTLATEX} getstart "html,2,info,next,sections+" %1 %2 %3 %4
# Run the packaging script _now_ !
