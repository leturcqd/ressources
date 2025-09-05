#!/bin/sh
cd "/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles"
FILE="/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/germe.tex"
limites=(4 4 5 3 3 9 6 9 3 2 4 4 2 5 3 5 8 5 9 4 5 4 3 9 6 6 3 5 4 4 4 4 4 5 4 7 4 5 3 4 3 4 7 6 4 4 4 4 4 5 6 4 4 4 3 3 3 6 3)
echo "">"/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/germe.tex"
echo "Nombre de sujets ?"
read nombre_sujets
#echo "Numéro des questions séparés par des espaces"
#open -a Preview "Liste_questions.pdf"
liste_questions=$(cat "Numéroschoisis.txt" | tr -s '\n' ' ')
#read liste_questions
for (( j=1; j<=nombre_sujets; j++ ));
do
    N=''
    k=1
    for i in ${limites[@]};
    do
        if [[ $liste_questions =~ (^|[[:space:]])$k($|[[:space:]]) ]]
        then
            N="$N""{""$((1 + $RANDOM % $i))""}"
        else
            #N="$N""{""$((1 + $RANDOM % $i))""}"
            N="$N""{0}"
        fi
        k=$(($k+1))
    done
    echo "\setcounter{question}{1}"$'\n'>>"$FILE"
    echo "\begin{enumerate}"$'\n'>>"$FILE"
    echo "\germe""${N:0:27}">> "$FILE"
    echo "\germeb""${N:27:27}">> "$FILE"
    echo "\germec""${N:54:6}">> "$FILE"
    echo "\input{/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/calcul.tex}"$'\n'>>"$FILE"
    echo "\germed""${N:60:24}">>"$FILE"
    echo "\input{/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/arith.tex}"$'\n' >>"$FILE"
    echo "\germee""${N:84:27}">>"$FILE"
    echo "\germef""${N:111:27}">>"$FILE"
    echo "\germeg""${N:138:27}">>"$FILE"
    echo "\germeh""${N:165:12}">>"$FILE"
    echo "\input{/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/calclitt.tex}"$'\n' >>"$FILE"
    echo "\end{enumerate}"$'\n'>>"$FILE"
    echo "\newpage" >>"$FILE"
done
# cat "/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/germe.tex"
pdflatex -synctex=1 -interaction=nonstopmode -shell-escape  "/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/Controlevierge.tex"
rm "Controlevierge.out"
rm "Controlevierge.aux"
rm "Controlevierge.log"
rm "Controlevierge.synctex.gz"
open -a Preview "Controlevierge.pdf"

