#!/bin/bash

#1
grep ',A$' CSP102.txt | cut -d',' -f1 > new_CSP102.txt
grep ',B$' CSP101.txt | cut -d',' -f1 > new_CSP101.txt
echo "Roll numbers who obtained an A in CSP102.txt but a B in CSP101.txt are:"
grep -Fxf new_CSP101.txt new_CSP102.txt
rm new_CSP102.txt new_CSP101.txt
#2
F_CSP100=$(grep -c ',F$' CSP100.txt)
F_CSP101=$(grep -c ',F$' CSP101.txt)
F_CSP102=$(grep -c ',F$' CSP102.txt)

if (( F_CSP100 > F_CSP101 && F_CSP100 > F_CSP102 )); then
    echo "CSP100 has the maximum number of F grades"
elif (( F_CSP101 > F_CSP100 && F_CSP101 > F_CSP102 )); then
    echo "CSP101 has the maximum number of F grades"
else
    echo "CSP102 has the maximum number of F grades"
fi
#3
echo "Roll numbers with E grade in any course:"
grep ',E$' CSP100.txt CSP101.txt CSP102.txt | cut -d',' -f1

E_CSP100=$(grep -c ',E$' CSP100.txt)
E_CSP101=$(grep -c ',E$' CSP101.txt)
E_CSP102=$(grep -c ',E$' CSP102.txt)


if (( E_CSP100 >= E_CSP101 && E_CSP100 >= E_CSP102 )); then
    sed -i 's/,E$/,C/' CSP100.txt
    echo "Replaced E grades with C in CSP100"
elif (( E_CSP101 >= E_CSP100 && E_CSP101 >= E_CSP102 )); then
    sed -i 's/,E$/,C/' CSP101.txt
    echo "Replaced E grades with C in CSP101"
else
    sed -i 's/,E$/,C/' CSP102.txt
    echo "Replaced E grades with C in CSP102"
fi


