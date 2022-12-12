#!/bin/bash
#Author: Jooyoung Ser zs519@imperial.ac.uk
#Script: compilelatex.sh
#Desc: script to compile latex with bibtex
#Date: 05/10/2022


pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex

mv $1.pdf ../results/

evince ../results/$1.pdf &

## Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg

##to run bash compilelatex.sh firstexample