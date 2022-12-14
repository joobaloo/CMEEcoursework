#!/usr/bin/env python3

""" Demonstrates running R from python """

__appname__ = 'TestR.py'
__author__ = 'Jooyoung Ser (zs519@ic.ac.uk)'
__version__ = '0.0.1'

#importing module
import subprocess

p = subprocess.Popen("Rscript --verbose TestR.R > ../results/TestR.Rout 2> ../results/TestR_errFile.Rout", shell=True).wait()