#!/usr/bin/env python3

""" Runs the fmr.R script using python"""

__appname__ = 'run_fmr_R.py'
__author__ = 'Jooyoung Ser (zs519@ic.ac.uk)'
__version__ = '0.0.1'

#importing module
import subprocess

p = subprocess.Popen("Rscript --verbose fmr.R > ../results/fmr.Rout 2> ../results/fmr_errFile.Rout", shell=True).wait()