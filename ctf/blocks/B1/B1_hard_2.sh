#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag es el nombre de un archivo 
    dentro de la carpeta editada más recientemenmte
    perteneciente a $1
    (puede que el archivo no sea visible a simple vista).
                                                        
    Comandos recomendados: ls / find / grep 

*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag é o nome dun arquivo dentro da
    carpeta editada máis recentemente que pertence a $1
    (pode que o arquivo non sexa visible a simple vista)
                                                        
    Comandos recomendados: ls / find / grep 

*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the name of 
    a file within the most recent folder 
    owned by the $1 
    (it may not be visible at first glance).
                                                        
    Recommended Commands: ls / find / grep 

*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------

random_date(){
    printf "%04d%02d%02d%02d%02d.%02d" \
        $((RANDOM % 24 + 2000)) $((RANDOM % 12 + 1)) $((RANDOM % 28 + 1)) \
        $((RANDOM % 24)) $((RANDOM % 60)) $((RANDOM % 60))
}

crear_archivos() {
    carpeta="$1"
    touch  "$carpeta/Wallace"
    touch  "$carpeta/Grommit"
    touch  "$carpeta/Lady_Campanula_Tottington"
    touch  "$carpeta/Señora_Mantillo"
    touch  "$carpeta/Feathers_McGraw"
    touch  "$carpeta/Victor_Quartermaine"
    touch  "$carpeta/Reverend_Clement_Hedges"
    touch  "$carpeta/Mr_Crock"
    touch  "$carpeta/Mrs_Girdling"
    touch  "$carpeta/Mr_Leaching"
}

for i in $(seq 1 20); do
    folder=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 6)
    mkdir dir_$folder && crear_archivos "dir_$folder"
    if [ $(($i % 2)) -eq 0 ]; then
        chown "$1":retos_grp "dir_$folder"
    fi
    touch -t $(random_date) "dir_$folder"
done

touch "$(find . -group retos_grp | shuf -n 1)/.$2"
