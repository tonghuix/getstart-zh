#!/bin/sh
#
cd `dirname $0`
SRCDIR=`pwd`/../source; export SRCDIR
BUILDDIR=/usr/local/src/getstart export BUILDDIR
# BE CAREFUL WITH THIS ONE !!!
rm -r ${BUILDDIR} && cp -pr ${SRCDIR} ${BUILDDIR}
cd ${BUILDDIR} || exit 1

rm -f *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in *.ind *.lg \
*.FGShortRef.css *.log *.out *.tid *.tmp *.toc *.xref

pdflatex FGShortRef.tex
pdflatex FGShortRef.tex
rm FGShortRef.dvi
htlatex.sh FGShortRef %1 %2 %3 %4

rm FGShortRef.dvi *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in *.ind \
*.*.lg log *.out *.tid *.tmp *.toc *.xref
