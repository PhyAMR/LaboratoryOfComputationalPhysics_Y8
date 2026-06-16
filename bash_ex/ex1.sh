# a
cd $HOME # We move to the home directory

mkdir -p students # We create the students directory if it does not exist

cd students # We move into the students directory

if [ ! -f "LCP_22-23_students.csv" ]; then
    wget https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv # We download the file
fi


# b

touch PoD_students.csv Physics_students.csv # We create the output files

grep "PoD" LCP_22-23_students.csv >> PoD_students.csv # We extract the PoD students
grep "Physics" LCP_22-23_students.csv >> Physics_students.csv # We extract the Physics students

# c
for letter in {A..Z}; do
  counts="$(grep -c "^$letter" "LCP_22-23_students.csv")"
  echo "For the letter $letter there are $counts matches"
done
# We count how many students' last names start with each letter. This works because the last names are the first entries in each line.
# d
max_c=0
max_l=0
for letter in {A..Z}; do

  cou="$(grep -c "^$letter" "LCP_22-23_students.csv")"
  if [ $cou -gt $max_c ]; then 
    max_c=$cou 
    max_l=$letter 
  fi
done
# We count how many students' last names start with each letter and keep track of the maximum count and corresponding letter.
echo "The most common letter with $max_c matches is the letter $max_l"


# e

for i in {1..18}; do

  awk "NR % 18 == $i % 18" LCP_22-23_students.csv > group_$i.csv

done
