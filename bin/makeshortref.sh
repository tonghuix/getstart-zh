#!/bin/sh
#
cd `dirname $0`
SRCDIR=`pwd`/../source; export SRCDIR
# BE CAREFUL WITH THIS ONE !!!
rm -r ${HOME}/getmp && cp -pr ${SRCDIR} ${HOME}/getmp

cd ${HOME}/getmp && rm -f *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in \
*.ind *.lg *.FGShortRef.css *.log *.out *.tid *.tmp *.toc *.xref

pdflatex FGShortRef.tex
pdflatex FGShortRef.tex
rm FGShortRef.dvi
htlatex.sh FGShortRef %1 %2 %3 %4

rm FGShortRef.dvi *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in *.ind \
*.*.lg log *.out *.tid *.tmp *.toc *.xref
