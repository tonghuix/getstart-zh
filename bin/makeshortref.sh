#!/bin/sh
#

rm -vf *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in *.ind *.lg \
*.FGShortRef.css *.log *.out *.tid *.tmp *.toc *.xref

pdflatex FGShortRef
pdflatex FGShortRef
pdflatex FGShortRef
rm -vf FGShortRef.dvi
call htlatex FGShortRef %1 %2 %3 %4

rm -vf FGShortRef.dvi *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in *.ind \
*.*.lg log *.out *.tid *.tmp *.toc *.xref

