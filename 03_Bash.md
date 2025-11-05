---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.17.2
  kernelspec:
    display_name: LaboratoryOfComputationalPhysics_Y8
    language: python
    name: laboratoryofcomputationalphysics_y8
---

## Beyond "clicking", Shell as a necessity for proficent data analysis and computing

"Clicking" is for amatours, so stop doing that. When dealing with advanced computing and analysis tasks, it is needed to operate by means of shell commands and scripting. That is the case for several puroposes: file system managment, low level operations, advanced local and remote configurations, access and management of remote resources, etc.

Several languages exists (all rather similar to each other), we will review BASH, a default interpreter on many GNU/Linux systems. The MacOS application is `Terminal`, which used BASH until Catilina, then ZSH (almost the same).
Something similar must exist for Windows, but I dunno & I dontcare.




## Bash Shell Scripting 

### Bash

The name is an acronym for the ‘Bourne-Again SHell’.From its [wiki page](https://en.wikipedia.org/wiki/Bash_(Unix_shell):
```text
Bash is a command processor that typically runs in a text window where the user types commands that cause actions. Bash can also read and execute commands from a file, called a shell script. Like most Unix shells, it supports filename globbing (wildcard matching), piping, here documents, command substitution, variables, and control structures for condition-testing and iteration.
```

### Shell
Shell is a macro processor which allows for an interactive or non-interactive command execution.

### Scripting
Scripting allows for an automatic commands execution that would otherwise be executed interactively one-by-one.






## About this notebook

In the following we will explore the basic functionalities of bash, scratching the surface of an incredibly rich application. As for python, the web extensively provides documentation for all you'll ever need to do; the same and more do the LLM (e.g. GPT or Claude). 
The command `man` is anyway available for all the commands (most of which has also the `-help` option available).

Note that Jupyter allows execution of bash commands (and scripts) within a python notebook or by means of a dedicated emulator of a Terminal.

The code exposed in the following is however meant to be copied and tried on your computer shell. Scripts are meant to be edited on dedicated files, by means of your preferred text [editor](https://linuxblog.io/50-linux-text-editors/).


## Navigating/exploring the file system


````python
```bash

#this is a comment

# who am I? I.e. which account am I using?
whoami

# Am I a superuser?
sudo -l

# what's the name of the computer
hostname

# where am I?
pwd
# the current directory is aliased as ".", ".." is the one above. pwd returns the content of the global variable $PWD, see later  

# go to a given directory
# go to the directory above
cd .. 
# get back to the previous directory
cd -  
# go to your home directory 
cd $HOME

# make a new directory
mkdir test
cd test
mkdir -p tmp/foo 
# delete that last directory
rm -r tmp/foo #the "-r" option is needed for directories

# check the amount of data in your home
du -h $HOME
# check the memory usage for the main folders
df -h

# check the content of a directory
touch tmp_file #create a file just for the sake of it (see later)
ls -latrh 
# where: -l -> list, -a -> include hidden directories, -t -> time ordered, -r -> reversed, h -> size in Bytes 
```
````

<!-- #region -->
### Anatomy of "ls -l" output

The output presents 7 fields, standing for:

1. Permissions
2. Number of hardlinks
3. File owner
4. File group
5. File size
6. Modification time
7. Filename

The first one can be intepreted as 
`File type - Owner permissions - Group permissions - Everyone permissions`

where permissions are indicated as:


"r" = read permission,
"w" = write permission,
"x" = execute permission,
"-" = no permission


<!-- #endregion -->

## Files managment

Check the related [wiki page](https://en.wikipedia.org/wiki/Chmod) for the syntax of permissions changing


<!-- #region -->
``` bash
# add some text to a file
echo "Add some text to a file" > tmp_file 
more tmp_file 

# Use ">" to replace whatever was there before 
echo "Add some other text to a file" > tmp_file 
more tmp_file 

# Use ">>" to append text to whatever was there before
echo "Append text to a file" >> tmp_file 
more tmp_file 

# change permissions (in this specific case allow "others" to read and write that file
ls -l tmp_file
chmod o+rw tmp_file
ls -l tmp_file

# copy files (absolute path can be specified of course)
cp tmp_file ./tmp_file_copy

# remove files
rm tmp_file_copy

# find a file
# the syntax is: find /path/to/dir -name "filename" 
cd ../
find . -name "tmp_file"
find . -name "tmp*"
cd -

```   
<!-- #endregion -->

## Regular Expressions (RegExp)

Regular expressions are a very powerful tool for string manipulation, text find&replace, etc. Its syntax -although not obvious and complex- is used in several programming languages and is worth learning. This is one of the cases where consulting the manual(s) regularly is rather unavoidable.

In the following will we use regexp with `grep` and `sed`.

Copy the following into a file named data.csv

<!-- #raw -->
# Recorded data from sensor XaB.v2
# Recording started on Oct 29 15:00:00
# Recording ended on Oct 29 15:15:59
# X, Y, Z, X', Y', Z'
55, 14, 48, 62, 78, 41
32, 52, 94, 11, 17, 83
83, 13, 61, 69, 44, 39
77, 34, 34, 2, 93, 24
25, 28, 49, 92, 3, 8
44, 87, 63, 62, 23, 98
90, 20, 6, 79, 32, 30
73, 91, 41, 36, 0, 93
63, 96, 17, 56, 30, 81
37, 56, 35, 90, 69, 35
32, 54, 87, 61, 81, 99
21, 77, 47, 54, 99, 36
93, 7, 85, 12, 67, 16
65, 53, 27, 59, 98, 94
23, 7, 59, 19, 75, 13
47, 68, 79, 83, 81, 86
51, 49, 84, 96, 71, 94
23, 99, 9, 17, 55, 70
49, 79, 62, 51, 6, 96
56, 16, 51, 18, 11, 23
98, 0, 78, 80, 75, 53
77, 30, 58, 41, 86, 17
93, 40, 62, 37, 92, 20
30, 86, 63, 45, 70, 99
2, 63, 89, 41, 95, 84
77, 10, 87, 24, 2, 86
43, 17, 82, 21, 52, 12
33, 65, 98, 38, 19, 10
52, 17, 68, 26, 61, 5
39, 94, 40, 99, 48, 20
58, 79, 79, 69, 71, 64
6, 12, 97, 4, 16, 98
79, 0, 40, 83, 49, 65
51, 13, 29, 84, 62, 29
60, 34, 12, 1, 12, 32
36, 92, 15, 44, 82, 60
6, 10, 72, 22, 62, 62
69, 98, 3, 34, 16, 61
21, 25, 2, 24, 93, 45
82, 18, 2, 79, 51, 73
93, 57, 75, 52, 77, 27
10, 61, 93, 79, 74, 67
6, 45, 94, 67, 68, 63
2, 54, 8, 32, 86, 49
60, 52, 22, 1, 19, 73
78, 70, 87, 87, 39, 86
0, 66, 89, 61, 28, 42
85, 36, 81, 45, 49, 80
96, 31, 82, 32, 88, 15
70, 95, 3, 53, 31, 48
<!-- #endraw -->

<!-- #region -->
``` bash
# get the line with "sensor"
grep "sensor" data.csv

# get the metadata
grep "^#" data.csv 

# get the data payload (all lines w/o "#" at the beginning)
grep -v "^#" data.csv 

# count the number of lines in the data payload
grep -c -v "^#" data.csv 

# look for the sensor by name
grep "X[a-z].v*" data.csv 
# searches are case sensistive:
grep "X[A-Z].v*" data.csv 

# use cut to get part of the line, in this case the starting time
grep "started" data.csv | cut -f7 -d " "

# substitute Oct with Nov
sed -e "s/Oct/Nov/" data.csv

# Add ".0" to all single digit number
sed -e "s/\b[0-9]\{1\}\b/&.0/" data.csv 

```
<!-- #endregion -->

## Variables

variables can be global or local. The latter are set in the usual intuitive manner, the former requires the `export` command. Variable are accessed by preposing the `$` character.
Global variables are used extensively by applications you don't have/don't want to have control of, thus do not mess with them unless you know what you are doing. Global variables typically use capital letters, thus for your own variable is best to use lower case letters.
The command `env` list all the global variables currently set.
An example of global variable is `PATH`, i.e. the list of folders containing the executables you can run without specifying the absolute path.


<!-- #region -->
``` bash
# the whole list of global variables
env

# what is your PATH?
echo $PATH

# set your own global variable?
export MY_GLOBAL_VARIABLE=pippo
echo $MY_GLOBAL_VARIABLE
 
# set your local variable
variable=7
echo $variable

```
<!-- #endregion -->

## Standard output, Standard error

Every time a command is executed, three possible outcomes might happen: 1) the command will produce an expected output 2) the command will generate an error 3)the command produces no output at all.

It happens often that the need is there (e.g. for logging purposes) to store the output in separate files.
The `>` notation is used to redirect stdout to a file whereas `2>` notation is used to redirect stderr and `&>` is used to redirect both stdout and stderr.



<!-- #region -->
```bash

# some stderr
ls -l pippo
ls -l pippo 2> err.txt
more err.txt 
ls -l pippo > err.txt
more err.txt 

# some stdout
ls -l err.txt > log.txt
more log.txt 

# redirect everything
ls -l pippo err.txt &> log.txt
more log.txt 

```
<!-- #endregion -->

## Numeric and string comparison, operations with numbers

The following table summarizes how to compare numbers and strings.

| Description | Numeric Comparison | String Comparison
| ----------- | ----------- | ----------- |
| less then   | -lt  | <  |
| greater equal | -gt  | >  |  
| equal | -e | = |
| not equal | -ne | != |
| less or equal | -le | N.A. |
| greater or equal | -ge | N.A. | 

Funny enough, the result of a comparison is 1 if False and 0 if True.
The following is a trick to access directly the result of the comparison; those are used mainly in conditional statements

<!-- #region -->
``` bash
# setting variables
a=1
b=2

# the comparison (note the square brakets)
[ $a -lt $b ]
# to check the result of the former operation
echo $?

[ $a -gt $b ]; echo $?
[ $a -ne $b ]; echo $?
```
<!-- #endregion -->

Aritmetic operations can be done in several ways. Quite common is the usage of 
Arithmetic Expansion, thanks to its simplicity (trading off though with the complexity of the permitted operations). Other tool are there like `expr` or `let`, we will provide examples with `bc`, which is rather intuitive and powerful.

<!-- #region -->
```bash
# Aritmetic Expansions
echo $(( 10*5 + 15 ))
echo $(( $a + $b*3 ))

# bc
echo '8.5 / 2.3' | bc
sqr=$( echo 'scale=6;sqrt(2)' | bc)
echo $sqr

```
<!-- #endregion -->

## Conditional statements

As in every other language, conditional statements are of paramount importance and exploited exstensively also in bash. They best fit in a script (see later), but can be used also on the command line. The syntax is similar to the other languages



<!-- #region -->
```bash
a=400
b=200

# an inline command
if [ $a -gt $b ]; then echo "$a is greater than $b! "; fi

# the following needs to go in a script
if [ $a -lt $b ]; then
    echo "$a is less than $b! "
else
    echo "$a is greater than $b! "
fi
```
<!-- #endregion -->

## Loops

same considerations as for conditional statements apply for loop cycles. 
There are several ways they can be implemented, we will review a few of them

<!-- #region -->
```bash
# some for loops syntax
for i in 1 2 3; do echo $i; done

for i in {1..10}; do echo $i; done

for i in $(seq 1 2 20); do echo $i; done

for (( i=1; i<=5; i++ )); do echo $i; done

for i in `ls .`; do echo $i; done 

for file in ./*; do if [ "${file}" == "./log.txt" ]; then break; fi; echo $file; done

# while (and until) works too
counter=0                                                                               
while [ $counter -lt 3 ]; do let counter+=1; echo $counter; done

```
<!-- #endregion -->

## Scripting

All the instructions above (and many many more) can be put together into a script. An example follows:

<!-- #region -->
```bash
#!/bin/bash

# checking if the user provided an input
if [ -z $1 ]
then
    echo "this script requires as input the name of the file to be created"
    exit
fi

# check if the file is there
if [ ! -f "./$1" ]
then
    echo "the file ./$1 does not exist! Setting a default value"
    file="newfile.txt"
else
    file=./$1
fi

touch $file

for (( i=1; i<=5; i++ ))
do
    echo "add line $i" >> $file
done
```
<!-- #endregion -->

The initial statement `#!/bin/bash` tell the shell how to interpret the subsequent commands.

You can save those lines on a new file (e.g. `my_script.sh`) and try to run it. First you may want to make it executalbe

<!-- #region -->
```bash
chmod +x my_script.sh

./my_script.sh output.txt
```
<!-- #endregion -->

## Documentation

As mentioned above, there is plenty of documentation available directly via `man` or on the internet. A rather important command is `history` which list the set of commands provided in the current shell. After an intense session of operations on the shell, you may want to run it and pipe its stdout into a log file for later consultation

```python

```
