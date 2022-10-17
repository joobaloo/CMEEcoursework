#!/bin/bash
#script to compile latex with bibtex

pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex
evince $1.pdf &

mv $1.pdf ../results/
## Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg

##to run bash compilelatex.sh firstexample.tex