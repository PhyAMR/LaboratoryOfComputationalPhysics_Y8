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
even_count=$(grep -oE '[0-9]+' data.txt | grep -E '[02468]$' | wc -l)
# Print the result to stdout
echo "Even numbers: $even_count"

# c) Classify entries by r = sqrt(x^2 + y^2 + z^2)
# - The threshold thr is computed with bc -l (the -l option loads the math library for sqrt and provides floating point precision)
# - We read the first three fields from each data line as x, y, z (the data file now has space-separated numbers)
# - For each line we compute r via bc and compare r and thr using bc; bc returns 1 for true comparisons
# Note: using a while-read loop to process lines safely with whitespace
thr=$((100*100*3/4))  #$(echo "scale=10; 100*sqrt(3)/2" | bc -l)
# Initialize counters
gt=0  # number of entries with r > threshold
lt=0  # number of entries with r <= threshold
while read -r x y z rest; do
  # compute r using bc; scale sets the number of decimal digits

  r=$(($x*$x + $y*$y + $z*$z))
  #echo "r: $r thr: $thr"
  # compare r > thr using bc; bc prints 1 if true, 0 if false
  #is_gt=$(echo "$r > $thr" | bc -l)
  if [ $r -gt $thr ]; then
    gt=$((gt+1))
  else
    lt=$((lt+1))
  fi
# redirect the input of the loop from data.txt so each line is processed
done < data.txt
# Print classification counts
echo "Classification based on (x,y,z):"
echo "Greater: $gt"
echo "Smaller_or_equal: $lt"


gt2=0  # number of entries with r > threshold
lt2=0  # number of entries with r <= threshold
while read -r x y z xp yp zp; do
  # compute r using bc; scale sets the number of decimal digits

  r=$(($xp*$xp + $yp*$yp + $zp*$zp))
  #echo "r: $r thr: $thr"
  # compare r > thr using bc; bc prints 1 if true, 0 if false
  #is_gt=$(echo "$r > $thr" | bc -l)
  if [ $r -gt $thr ]; then
    gt2=$((gt2+1))
  else
    lt2=$((lt2+1))
  fi
# redirect the input of the loop from data.txt so each line is processed
done < data.txt
# Print classification counts
echo "Classification based on (x',y',z'):"
echo "Greater: $gt2"
echo "Smaller_or_equal: $lt2"
# d) Create n copies of data.txt where the i-th copy has all numbers divided by i (1 <= i <= n)
# - n=${1:-1} : parameter expansion; use first script argument as n, default to 1 if not provided
# - seq 1 "$n" : generates the sequence 1 2 ... n; seq is a simple way to iterate numeric ranges
# - For each line we split fields using the shell 'set -- $line' which sets positional parameters to the fields in the line
# - bc -l is used to perform floating-point division; scale controls precision
n=${1:-1}
for i in $(seq 1 "$n"); do
  outfile="data_${i}.txt"
  # truncate/create the output file
  > "$outfile"
  while read -r x y z xp yp zp; do
    # set positional parameters ($1 $2 ...) to the fields of the current line
    out="$(($x / $i)) $(($y / $i)) $(($z / $i)) $(($xp / $i)) $(($yp / $i)) $(($zp / $i))"
    # append the processed line to the output file
    echo "$out" >> "$outfile"
  done < data.txt
done
