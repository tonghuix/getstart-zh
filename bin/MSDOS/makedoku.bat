rem Batch file for building FlightGear documentation
rem Supposes a working TeX system including LaTeX and pdflatex
rem plus TeX4HT (http://www.cis.ohio-state.edu/~gurari/TeX4ht/mn.html)
del getstart.pdf
del getstart.html
del *.4ct
del *.4tc
del *.aux
del *.bak
del *.idv
del *.idx
del *.ilg
del *.in
del *.ind
del *.lg
del *.log
del *.out
del getstart.css
del *.tid
del *.tmp
del *.toc
del *.xref
del *.gif
pdflatex getstart
pdflatex getstart
pdflatex getstart
makeindex getstart
pdflatex getstart
del *.aux
del getstart.css
del *.idx
del *.ind
del *.ilg
del *.log
del *.toc
call htlatex getstart "html,2,info,next,sections+" %1 %2 %3 %4
call htlatex getstart "html,2,info,next,sections+" %1 %2 %3 %4
call htlatex getstart "html,2,info,next,sections+" %1 %2 %3 %4
tex \def\filename{{getstart}{ind}{idx}{in}{out}} \input idxmake.4ht
makeindex -o getstart.out getstart.in
call htlatex getstart "html,2,info,next,sections+" %1 %2 %3 %4
del getstart.dvi
del *.4ct
del *.4tc
del *.aux
del *.bak
del *.idv
del *.idx
del *.ilg
del *.in
del *.ind
del *.lg
del *.log
del *.out
del *.tid
del *.tmp
del *.toc
del *.xref


