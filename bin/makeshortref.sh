#!/bin/sh
#
cd `dirname $0`
export BASEDIR=`pwd`
. ${BASEDIR}/makebase.sh

cleanup

${PDFLATEX} FGShortRef.tex
${PDFLATEX} FGShortRef.tex
rm FGShortRef.dvi
${HTLATEX} FGShortRef %1 %2 %3 %4

#rm FGShortRef.dvi *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in *.ind \
#*.*.lg log *.out *.tid *.tmp *.toc *.xref
