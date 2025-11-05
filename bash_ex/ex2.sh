data="$(grep -v "^#" data.csv)"

grep -e "s/, //g" <<< $data >> data.txt
