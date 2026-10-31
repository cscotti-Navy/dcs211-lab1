#!/bin/bash
# reorganize.sh

for file in Chapter*.sav
do
    k=$(echo "$file" | cut -d' ' -f2)
    j=$(echo "$file" | cut -d' ' -f5 | cut -d'.' -f1)
    mkdir -p "Chapter$k"
    cp "$file" "Chapter$k/DataSet$j.sav"
done
