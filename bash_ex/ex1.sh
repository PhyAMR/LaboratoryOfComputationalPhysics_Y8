# a
cd $HOME # We move to the home directory

mkdir -p students # We create the students directory if it does not exist

cd students # We move into the students directory

wget https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv # We download the file

text="$(grep -v "/students" LCP_22-23_students.csv)" # We store the content without the header in a variable1ex1ee
max_s="$(grep -c -v "/students" LCP_22-23_students.csv)" # We count the number of students excluding the header

# b

touch PoD_students.txt Physics_students.txt # We create the output files

grep "PoD" students/LCP_22-23_students.csv >> PoD_students.txt # We extract the PoD students
grep "Physics" students/LCP_22-23_students.csv >> Physics_students.txt # We extract the Physics students

# c
for letter in {A..Z}; do
  counts="$(grep -c "^$letter" <<< "$text")"
  echo "For the letter $letter there are $counts matches"
done
# We count how many students' last names start with each letter. This works because the last names are the first entries in each line.
# d
max_c=0
max_l=0
for letter in {A..Z}; do

  cou="$(grep -c "^$letter" <<< "$text")"
  if [ $cou -gt $max_c ]; then 
    max_c=$cou 
    max_l=$letter 
  fi
done
# We count how many students' last names start with each letter and keep track of the maximum count and corresponding letter.
echo "The most common letter with $max_c matches is the letter $max_l"


# e
n=0
n_groups=$(( max_s / 18 ))

for i in $(seq 1 "$n_groups"); do
  touch "group_${i}.txt"
  while read -r line; do
    ((n++))
    if (( n % 18 == 1 )); then
      echo "$line" >> "group_${i}.txt"
    fi
  done <<< "$text"
done
