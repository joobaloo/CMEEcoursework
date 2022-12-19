#!/bin/sh

#PBS -lwalltime=00:02:00
#PBS -lselect=1:ncpus=1:mem=1gb

module load anaconda3/personal

echo "R is about to run"

R --vanilla < $HOME/zs519_HPC_2022_cluster.R

mv zs519_results* $HOME/output_files

echo "R has finished running"

