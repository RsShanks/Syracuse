#!/bin/bash
## boucle pour lancer en boucle ./syracuse

var1=$1
var2=$2
mkdir UndeN
mkdir temporaire
while [ $var1 -le $var2 ]
do
    ./syracuse $var1 f$var1.dat
    mv f$var1.dat UndeN
    echo "`grep -v -e"n" -e"=" UndeN/f$var1.dat`" > temporaire/f$var1.dat # ca récupère tous les n pour chaque Un d'un U0
    echo "$var1 `tail -3 UndeN/f$var1.dat | head -n+1 | cut -f 2 -d ' '`"  >> dureevol.dat  #récup la durée de vol
    echo "$var1 `tail -2 UndeN/f$var1.dat | head -n+1 | cut -f 2 -d ' '`" >> altimax.dat  #recupere l'altidute max
    echo "$var1 `tail -1 UndeN/f$var1.dat | cut -f 2 -d ' '`" >> dureeAlti.dat #recupere durée altix
    let  "var1+=1"
done

    gnuplot << EOF
    set terminal jpeg size 800,600
    set output 'TousLesUn.jpeg'
    unset key
    set title "Graphique de tous les Un"
    set xlabel 'n'
    set ylabel 'Un'
    plot for[c=$1:$2]'temporaire/f'.c.'.dat' w l lt 1 lc 22
    quit
EOF


gnuplot << EOF
set terminal jpeg size 800,600
set output 'grapheAltitudeMax.jpeg'
unset key
set title "Graphe AltitudeMax"
set xlabel 'n'
set ylabel 'Un'
set xrange [$1:$2]
plot "altimax.dat" w l lt 1 lc 22
quit
EOF


gnuplot << EOF
set terminal jpeg size 800,600
set output 'dureevol.jpeg'
unset key
set title "durée de vol"
set xlabel 'n'
set ylabel 'Un'
set xrange [$1:$2]
plot "dureevol.dat" w l lt 1 lc 22
quit
EOF


gnuplot << EOF
set terminal jpeg size 800,600
set output 'dureealti.jpeg'
unset key
set title "duree altitude"
set xlabel 'n'
set ylabel 'Un'
set xrange [$1:$2]
plot "dureeAlti.dat" w l lt 1 lc 22
quit
EOF
mkdir -p données_syracuse
mv dureeAlti.dat altimax.dat dureevol.dat données_syracuse/
            mkdir -p graphique_syracuse
mv dureealti.jpeg dureevol.jpeg grapheAltitudeMax.jpeg TousLesUn.jpeg graphique_syracuse/
rm -r temporaire