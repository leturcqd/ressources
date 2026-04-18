#!/bin/sh
cd "/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles"
FILE="/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/germe.tex"
limites=(4 4 5 3 3 9 6 9 3 2 4 4 2 5 3 5 8 5 9 4 5 4 3 9 6 6 3 6 4 4 4 4 4 5 4 7 4 5 3 4 3 4 7 6 4 4 4 4 4 5 6 4 4 4 3 3 3 6 3 4 4 4 4 4)
printf "">"/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/germe.tex"
printf "Nombre de sujets ?"
read nombre_sujets
#printf "Numéro des questions séparés par des espaces"
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
    printf '\\setcounter{question}{1}'$'\n'>>"$FILE"
    printf '\\begin{enumerate}'$'\n'>>"$FILE"
    printf "\\germe""${N:0:27}">> "$FILE"
    printf "\\germeb""${N:27:27}">> "$FILE"
    printf "\\germec""${N:54:6}">> "$FILE"
    printf "\\input{/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/calcul.tex}"$'\n'>>"$FILE"
    printf "\\germed""${N:60:24}">>"$FILE"
    printf "\\input{/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/arith.tex}"$'\n' >>"$FILE"
    printf "\\germee""${N:84:27}">>"$FILE"
    printf "\\germef""${N:111:27}">>"$FILE"
    printf "\\germeg""${N:138:27}">>"$FILE"
    printf "\\germeh""${N:165:12}">>"$FILE"
    printf "\\input{/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/calclitt.tex}"$'\n' >>"$FILE"
    printf "\\germev""${N:177:15}">>"$FILE"
    printf "\\input{/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/volumes.tex}"$'\n'>>"$FILE"
    printf '\\end{enumerate}'$'\n'>>"$FILE"
    printf '\\newpage' >>"$FILE"
done
# cat "/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/germe.tex"
rm "/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/Controlevierge.pdf"
pdflatex -synctex=1 -interaction=nonstopmode -shell-escape  "/Users/davidleturcq/Desktop/ressources/Automatismes/3e/Controles/Controlevierge.tex"
rm "Controlevierge.out"
rm "Controlevierge.aux"
rm "Controlevierge.log"
rm "Controlevierge.synctex.gz"
open -a Preview "Controlevierge.pdf"

