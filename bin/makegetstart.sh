#!/bin/sh
# Shell script for building FlightGear getting Started manual.
# Supposes a working TeX system including LaTeX and pdflatex
# plus TeX4HT (http://www.cis.ohio-state.edu/~gurari/TeX4ht/mn.html)
#
cd `dirname $0`
export BASEDIR=`pwd`
. ${BASEDIR}/makebase.sh

cleanup

for i in *.eps; do convert -scale 800x600 $i `echo $i | sed -e 's/.eps\$/.jpg/g'`; done

# Now we have to run 'pdflatex' several times - I'll figure out why (some
# time ....).
#
${PDFLATEX} getstart.tex
${PDFLATEX} getstart.tex
makeindex getstart
${PDFLATEX} getstart.tex
# Run the packaging script _now_ !

# PDF generation is done now. I consider this as the most valuable because I
# like reading printed manuals  ;-)
# Now deal with HTML generation for our nice web site. Start with Cleanup.
# 
rm *.aux getstart.css *.idx *.ind *.ilg *.log *.toc

${HTLATEX} getstart "html,2,info,next,sections+" %1 %2 %3 %4
${HTLATEX} getstart "html,2,info,next,sections+" %1 %2 %3 %4
makeindex -o getstart.out getstart.in
${HTLATEX} getstart "html,2,info,next,sections+" %1 %2 %3 %4
# Run the packaging script _now_ !
#
cleanup
