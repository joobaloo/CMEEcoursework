#!/usr/bin/env python3

""" This program takes two sequences from two fasta files given as arguments, compares alignments of the sequences 
    and prints the alignment that gives the most base matches to a new file called best_match.txt"""

__appname__ = 'align_seqs_fasta.py'
__author__ = 'Elliott Parnell (EJP122@ic.ac.uk), Jooyoung Ser (jooyoung.ser19@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (l.feng22@imperial.ac.uk)'
__version__ = '0.0.1'

## IMPORTS ##
import sys #This module interfaces our program with the operating system.
import os #This is used for moving the file created to results
import csv #used to read from CSV
#import re #Provides regular expression matching opperations


############ COMMENTS ##########
# Will need to update all the comments 


## CONSTANTS ##
my_best_align = None
my_best_score = -1

## FUNCTIONS ##
def read_seq_fasta(fasta1, fasta2):
    """ Function used to import and process DNA sequences from two fasta files"""
    files = [fasta1, fasta2]
    seq_data_return = []
    for fastafile in files:
        seq_data = []
        try:
            with open(fastafile, "r") as ff:
                for line in ff:
                    line =line.strip() # remove trailing newline characters
                    if line.startswith(">"):
                        next
                    else:
                        seq_data.append(line)
                seq_data_return.append("".join(seq_data))
        except AttributeError:
            raise
    return(seq_data_return)


def longer_seq(seq1, seq2):
    """This function takes two strings as input and sets the longer of the two as s1 and the shorter as s2"""
    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths
    return s1, s2, l1, l2

def calculate_score(s1, s2, l1, l2, startpoint):
    """ A function that calcuates the number of matching bases of a particular alignment of two DNA sequences """
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*" #add a star to the string
                score = score + 1 #add 1 to the score
            else: #this section adds a hypen to indicate it's not a match
                matched = matched + "-"

    return score

def best_alignment(s1, s2, l1, l2, my_best_score, my_best_align):
    """ This function works out the alignment for the two sequences that gives the most base matches """
    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 
            my_best_score = z 
    return my_best_align, my_best_score
    
## MAIN FUNCTION ###
def main(argv):
    """ Main function to be called for the script"""
    if len(sys.argv) == 3:
        fasta1 = argv[1]
        fasta2 = argv[2]
    else:
        print("Running script using default fasta files")
        fasta1 = "../data/fasta/407228326.fasta"
        fasta2 = "../data/fasta/407228412.fasta"
    
    two_seq = read_seq_fasta(fasta1, fasta2)
    seq1 = two_seq[0]
    seq2 = two_seq[1]
        
    s1, s2, l1, l2 = longer_seq(seq1, seq2)
   
    final_align, final_score = best_alignment(s1, s2, l1, l2, my_best_score, my_best_align)
    
    #Creates a list to write to file
    output_list = [final_align , s1 , f"Best Score: {final_score}"]

    #Using os and path, opens a file in the results directory to write the output list into 
    cur_path = os.path.dirname(__file__)
    new_path = os.path.relpath('../results/best_match_fasta.txt', cur_path)
    
    with open(new_path, 'w') as f:
        for eachline in output_list:
            f.write(eachline)
            f.write("\n")
    
if __name__ == "__main__":
    """ Makes sure the "main" function is called from command line """
    status = main(sys.argv)
    sys.exit(status)
