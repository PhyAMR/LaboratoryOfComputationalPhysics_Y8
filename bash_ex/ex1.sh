# a

mkdir -p students

cd students 

# wget https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv

text="$(grep -v "master" LCP_22-23_students.csv)"
max_s="$(grep -c -v "master" LCP_22-23_students.csv)"

# b

touch PoD_students.txt Physics_students.txt 

grep "PoD" LCP_22-23_students.csv >> PoD_students.txt
grep "Physics" LCP_22-23_students.csv >> Physics_students.txt

# c
for letter in {A..Z}; do
  counts="$(grep -c "^$letter" <<< "$text")"
  echo "For the letter $letter there are $counts matches"
done

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
