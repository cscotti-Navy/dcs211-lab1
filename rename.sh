#!/bin/bash

today=$(date +%d%b%Y)

rename_file()
{
    folder=$1
    file=$2
    k=$(echo "$folder" | cut -c8-)
    j=$(echo "$file" | cut -c8- | cut -d'.' -f1)
    mv "$folder/$file" "$folder/CH${k}_DS${j}_$today.sav"
}

for folder in Chapter[0-9]*
do
    for file in $(ls "$folder")
    do
        rename_file "$folder" "$file"
    done
done
