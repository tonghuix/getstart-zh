#!/bin/sh
#

rm -vf *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in *.ind *.lg \
*.FGShortRef.css *.log *.out *.tid *.tmp *.toc *.xref

pdflatex FGShortRef.tex
pdflatex FGShortRef.tex
rm -vf FGShortRef.dvi
htlatex.sh FGShortRef %1 %2 %3 %4

rm -vf FGShortRef.dvi *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in *.ind \
*.*.lg log *.out *.tid *.tmp *.toc *.xref
