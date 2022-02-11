#!/bin/bash
## boucle pour lancer en boucle ./syracuse

var1=$1
var2=$2

create_directories () {
    mkdir -pv UndeN
    mkdir -pv temporaire
    mkdir -pv données_syracuse
    mkdir -pv graphique_syracuse
}

move_data_and_graphs () {
    mv dureeAlti.dat altimax.dat dureevol.dat données_syracuse/
    mv dureealti.jpeg dureevol.jpeg grapheAltitudeMax.jpeg TousLesUn.jpeg graphique_syracuse/

}

run_syracuse () {
    U0=$1

    ./syracuse $U0 f$U0.dat

    mv f$U0.dat UndeN

    echo "`grep -v -e"n" -e"=" UndeN/f$U0.dat`" > ./temporaire/f$U0.dat # ca récupère tous les n pour chaque Un d'un U0
    echo "$U0 `tail -3 UndeN/f$U0.dat | head -n+1 | cut -f 2 -d ' '`"  >> ./dureevol.dat  #récup la durée de vol
    echo "$U0 `tail -2 UndeN/f$U0.dat | head -n+1 | cut -f 2 -d ' '`" >> ./altimax.dat  #recupere l'altidute max
    echo "$U0 `tail -1 UndeN/f$U0.dat | cut -f 2 -d ' '`" >> ./dureeAlti.dat #recupere durée altix
}


create_plot () {
    echo "Création du graphique : " $1
    title=$1
    xlabel=$2
    ylabel=$3
    file_name=$4
    plot_data=$5
    plot_range=$6

    gnuplot << EOF
    set terminal jpeg size 800,600
    set output '$file_name'
    unset key
    set title "$title"
    set xlabel '$xlabel'
    set ylabel '$ylabel'
    $plot_range
    plot $plot_data w l lt 1 lc 22
    quit
EOF
}


create_directories

while [ $var1 -le $var2 ]
do
    run_syracuse $var1
    let  "var1+=1"
done

create_plot 'Graphique de tous les Un' n Un TousLesUn.jpeg "for[c=$1:$2]'temporaire/f'.c.'.dat'"
create_plot 'Graphe AltitudeMax' n Un grapheAltitudeMax.jpeg '"altimax.dat"' "set xrange [$1:$2]"
create_plot 'Durée de vol' n Un dureevol.jpeg '"dureevol.dat"' "set xrange [$1:$2]"
create_plot 'Duree altitude' n Un dureealti.jpeg '"dureeAlti.dat"' "set xrange [$1:$2]"


move_data_and_graphs
rm -r temporaire
