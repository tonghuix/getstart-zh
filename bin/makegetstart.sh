#!/bin/sh
# Shell script for building FlightGear getting Started manual.
# Supposes a working TeX system including LaTeX and pdflatex
# plus TeX4HT (http://www.cis.ohio-state.edu/~gurari/TeX4ht/mn.html)
#
cd `dirname $0`
SRCDIR=`pwd`/../source; export SRCDIR
BUILDDIR=/usr/local/src/getstart; export BUILDDIR
# BE CAREFUL WITH THIS ONE !!!
rm -r ${BUILDDIR} && cp -pr ${SRCDIR} ${BUILDDIR}
cd ${BUILDDIR} || exit 1

# PDF first. Cleanup everything that is consideret not to be present here.
#
rm -f *.pdf *.html *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in *.ind \
*.lg *.log *.out getstart.css *.tid *.tmp *.toc *.xref *.gif

for i in *.eps; do convert -scale 800x600 $i `echo $i | sed -e 's/.eps\$/.jpg/g'`; done

# Now we have to run 'pdflatex' several times - I'll figure out why (some
# time ....).
#
pdflatex getstart.tex
pdflatex getstart.tex
makeindex getstart
pdflatex getstart.tex
# Run the packaging script _now_ !
rm -rf ${BASEDIR}/build

# PDF generation is done now. I consider this as the most valuable because I
# like reading printed manuals  ;-)
# Now deal with HTML generation for our nice web site. Start with Cleanup.
# 
rm *.aux getstart.css *.idx *.ind *.ilg *.log *.toc

htlatex getstart "html,2,info,next,sections+" %1 %2 %3 %4
htlatex getstart "html,2,info,next,sections+" %1 %2 %3 %4
htlatex getstart "html,2,info,next,sections+" %1 %2 %3 %4
makeindex -o getstart.out getstart.in
htlatex getstart "html,2,info,next,sections+" %1 %2 %3 %4
#
rm -f getstart.dvi *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in *.ind \
*.lg *.log *.out *.tid *.tmp *.toc *.xref
