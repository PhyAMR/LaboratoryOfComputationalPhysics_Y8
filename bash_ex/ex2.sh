#!/bin/bash

# a) Remove metadata (lines starting with '#') and replace commas with spaces
# - grep -v "^#" : grep searches lines matching a pattern; -v inverts the match so it outputs lines that DO NOT match '^#' (i.e., non-comment lines)
# - sed 's/,/ /g' : sed performs a substitution; 's/old/new/g' replaces all commas with a single space on each line; 'g' flag means global (all matches in the line)
# The result is redirected (>) to data.txt, overwriting any existing file
cd bash_ex
grep -v "^#" data.csv | sed 's/,/ /g' > data.txt

# b) Count even numbers
# Approach: extract all integer sequences, keep only those whose last digit is even, and count them
# - grep -oE '[0-9]+' : -o prints only the matching part of a line (not the whole line); -E enables extended regular expressions; '[0-9]+' matches one or more digits
# - grep -E '[02468]$' : keep only matches that end with an even digit (0,2,4,6,8); '$' anchors the pattern to end of line
# - wc -l : count the number of lines (each match is on its own line so this equals the number of even integers)
even_count=$(grep -oE '[0-9]+' data.txt | awk '$1 % 2 == 0' | wc -l)
# Print the result to stdout
echo "Even numbers: $even_count"

# c) Classify entries by r = sqrt(x^2 + y^2 + z^2)

awk '{d=sqrt($1*$1+$2*$2+$3*$3)} d>86.6{over++} d<=86.6{below++} END{print over, below}' data.txt
# d)
n=$1
for i in $(seq 1 $n); do
  awk -v d=$i '{print $1/d,$2/d,$3/d}' data.txt > data_$i.txt
done
