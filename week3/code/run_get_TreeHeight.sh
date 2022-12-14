#!/bin/sh
# Author: Elliott Parnell (elliott.parnell22@imperial.ac.uk), Jooyoung Ser (jooyoung.ser19@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (L.feng22@imperial.ac.uk)
# Script: run_get_TreeHeight.sh
# Desc: A Unix shell script that tests get_TreeHeight.R and get_TreeHeight.py using a default input or an input file
# Arguments: Optional input file
# Date: Nov 2022


echo -e "trees.csv will be tested as an example:\n"

# run R vsersion
echo -e "Testing get_TreeHeight.R...\n"
Rscript get_TreeHeight.R ../data/trees.csv
echo -e "Done! Find output file in results directory\n"


# run python version
echo -e "Testing get_TreeHeight.py... \n"
python3 get_TreeHeight.py ../data/trees.csv
echo -e "Done! Find output file in results directory\n"

