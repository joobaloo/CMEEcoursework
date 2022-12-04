#!/bin/bash
#Author: Jooyoung Ser zs519@ic.ac.uk
#Script: run_miniproject.sh
#Description: Running all miniproject scripts
#Date: Decemeber 2022

#Data preparation
echo "Running data preparation"
Rscript dataprep.R
echo "Data preparation complete"

#Fitting data
echo "Fitting models"
Rscript modelfitting.R
echo "Fitting models complete"

#Model selection and plotting 
echo "Running model selection and plotting"
Rscript modelselection.R
echo "Model selection and plotting complete"

#compiling write up
echo "Compiling latex document"
pdflatex miniproject_writeup.tex
bibtex miniproject_writeup.aux
pdflatex miniproject_writeup.tex
pdflatex miniproject_writeup.tex

mv miniproject_writeup.pdf ../results/

echo "Latex document saved as miniproject_writeup.pdf in results folder"
echo "Miniproject complete!"
