#!/bin/bash
# grade.sh
# Auto-grades each student's DCS 211 Lab 1 submission.
# Writes a grading file dcs211_lab1_ID.txt per student.
# Run from the autograde folder.

# array of student IDs (edit for a different class)
students=(areed2 ckenny eamini fmiele jjiang jroelofs
jtapiamarte lbaron lchikh lhrinda lpaynter mcory
mdonaghy mlogan mnijjer mshimizu myoung2 nzuze
oenkhorgil oputnambagley rgleason shughes2 smaquera
srice tleamon tshapiro zali)

for id in "${students[@]}"
do
    gradefile="dcs211_lab1_$id.txt"

    # write the header into the grading file
    echo "DCS 211: Lab 1" > "$gradefile"
    echo "Name: STUDENT_NAME" >> "$gradefile"
    echo "Score: STUDENT_SCORE" >> "$gradefile"

    # look up the name and flip to "last, first"
    line=$(grep "^$id " students.txt)
    name=$(echo $line | cut -d' ' -f2-)
    lastfirst=$(echo "$name" | sed 's/\(.*\) \(.*\)/\2, \1/')
    sed -i '' "s/STUDENT_NAME/$lastfirst/" "$gradefile"

    # copy submission, comment out print and main
    cp "$id"/*.py temp.py
    sed -i '' 's/^print/#print/' temp.py
    sed -i '' 's/^main()/#main()/' temp.py

    # append grading code, run it, save the output
    cat GRADING/APPEND.py >> temp.py
    python3 temp.py >> "$gradefile"

    # grab the score and put it in the header
    total=$(grep "Total tests passed" "$gradefile")
    score=$(echo "$total" | cut -d' ' -f4-6)
    sed -i '' "s|STUDENT_SCORE|$score|" "$gradefile"
done

# remove the temporary file
rm temp.py
