#!/bin/sh
# Shell script for building FlightGear getting Started manual.
# Supposes a working TeX system including LaTeX and pdflatex
# plus TeX4HT (http://www.cis.ohio-state.edu/~gurari/TeX4ht/mn.html)
#
# PDF first. Cleanup everything that is consideret not to be present here.
#
rm -vf *.pdf *.html *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in *.ind \
*.lg *.log *.out getstart.css *.tid *.tmp *.toc *.xref *.gif

# Now we have to run 'pdflatex' several times - I'll figure out why (some
# time ....).
#
pdflatex getstart
pdflatex getstart
pdflatex getstart
makeindex getstart
pdflatex getstart

# PDF generation is done now. I consider this as the most valuable because I
# like reading printed manuals  ;-)

# We're going to see that happens next.
exit 0

# Now deal with HTML generation for our nice web site. Start with Cleanup.
# 
rm *.aux getstart.css *.idx *.ind *.ilg *.log *.toc
call htlatex getstart "html,2,info,next,sections+" %1 %2 %3 %4
call htlatex getstart "html,2,info,next,sections+" %1 %2 %3 %4
call htlatex getstart "html,2,info,next,sections+" %1 %2 %3 %4
tex \def\filename{{getstart}{ind}{idx}{in}{out}} \input idxmake.4ht
makeindex -o getstart.out getstart.in
call htlatex getstart "html,2,info,next,sections+" %1 %2 %3 %4
rm getstart.dvi *.4ct *.4tc *.aux *.bak *.idv *.idx *.ilg *.in *.ind *.lg *.log *.out *.tid *.tmp *.toc *.xref


