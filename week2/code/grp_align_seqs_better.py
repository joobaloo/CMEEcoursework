#!/usr/bin/env python3

"""Save the best alignment of two DNA sequences, taking any two fasta sequences to be aligned as input"""

__appname__ = 'align_seqs_better.py'
__author__ = 'Jooyoung Ser (jooyoung.ser19@imperial.ac.uk), Elliott Parnell (elliott.parnell22@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (l.feng22@imperial.ac.uk)'
__version__ = '0.0.1'

# Imports
import sys
import csv

# Functions
def input(fasta1, fasta2):
    """Assign data from two fasta files, rm header&newline character to get two clean sequences"""
    allfiles = []
    with open(fasta1, 'r') as file:
        next(file) # rm header
        seq1 = file.read()
        allfiles.append(seq1)
        seq1 = allfiles[0].replace("\n", "") # rm newline characters

    with open(fasta2, 'r') as file:
        next(file) 
        seq2 = file.read()
        allfiles.append(seq2)
        seq2 = allfiles[1].replace("\n", "")
    return seq1, seq2


def swap_lengths(seq1, seq2): 
    """Longer sequence is assigned to s1, and shorter is to s2"""
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
    """Computes a score by returning the number of matches starting from arbitrary startpoint (chosen by user)"""
    matched = "" # to hold string displaying alignements
    score = 0

    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    return score    

def best_match(s1, s2, l1, l2):
    """ Find the best match (highest score) for the two sequences"""
    my_best_align = None
    my_best_score = -1
    
    for startpoint in range(l1): 
        z = calculate_score(s1, s2, l1, l2, startpoint)
        if z > my_best_score: # higher score replace the former score
            my_best_align = ["." * startpoint + s2]  
            my_best_score = z 
        elif z == my_best_score: # if same scores are found, store by appending
            my_best_align.append("." * startpoint + s2)
        
    # output file to the results repo
    f = open('../results/align_seqs_better.txt', 'w')
    f.write(f"My best alignment is:")
    for i in range(len(my_best_align)): # output each result if there are the same score
        f.write(f" \n{my_best_align[i]} \n{s1}\n")
    f.write(f"\nMy best alignment score is: {my_best_score}")
    f.close()
    print("Find the output file ../results/align_seqs_better.txt")
    return 0

def main(argv):
    """Main entry point of the program"""
    if len(argv) >= 2: # if two or more arguments, use the given files
        try: 
            print(f"Run {argv[1]} and {argv[2]}")
            seq1, seq2 = input(argv[1], argv[2])
            s1, s2, l1, l2 = swap_lengths(seq1, seq2)
            best_match(s1, s2, l1, l2)
        except: #wrong files are given
            print("Check your input files(two right files).")
    else: # no right(two)files given, use files by default
         print("No arguments, input files given by default.")
         seq1, seq2 = input("../data/fasta/407228326.fasta", "../data/fasta/407228412.fasta")
         s1, s2, l1, l2 = swap_lengths(seq1, seq2)
         best_match(s1, s2, l1, l2)
       

if __name__ == "__main__": 
    """Makes sure the main function is called from command line"""  
    status = main(sys.argv)
    sys.exit(status)
