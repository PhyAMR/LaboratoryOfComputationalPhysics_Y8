---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.17.2
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
---

The following exercises are meant to be solved by gathering the bash commands incrimentally in two scripts, one for ex 1.* the other for ex 2.* 


### Ex 1


1\.a Make a new directory called `students` in your home. Download a csv file with the list of students of this lab from [here](https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv) (use the `wget` command) and copy that to `students`. First check whether the file is already there


1\.b Make two new files, one containing the students belonging to PoD, the other to Physics.


1\.c For each letter of the alphabet, count the number of students whose surname starts with that letter. 


1\.d Find out which is the letter with most counts.


1\.e Assume an obvious numbering of the students in the file (first line is 1, second line is 2, etc.), group students "modulo 18", i.e. 1,19,37,.. 2,20,38,.. etc. and put each group in a separate file  


### Ex 2


2.a Make a copy of the file `data.csv` removing the metadata and the commas between numbers; call it `data.txt`


2\.b How many even numbers are there?


2\.c Distinguish the entries on the basis of `sqrt(X^2 + Y^2 + Z^2)` is greater or smaller than `100*sqrt(3)/2`. Count the entries of each of the two groups 


2\.d Make `n` copies of data.txt (with `n` an input parameter of the script), where the i-th copy has all the numbers divided by i (with `1<=i<=n`).
