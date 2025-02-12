#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag es el nombre del archivo que 
    empieza con ARQPYB y tiene extensión .gif 
    (la extensión .gif no forma parte de la flag).
                                                        
    Comandos recomendados: ls / find

*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag é o nome do arquivo que comeza por
    ARQPYB e ten extensión .gif
    (A extensión .gif non forma parte da flag)
                                                        
    Comandos recomendados: ls / find

*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the name of the file 
    that starts with ARQPYB and has a .gif extension 
    (the .gif extension is not part of the flag).
                                                        
    Recommended Commands: ls / find

*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
for i in $(seq 1 25); do
    random_part1="PYB"
    while [ "$random_part1" = "PYB" ]; do
        random_part1=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 3)
    done
    touch "ARQ${random_part1}-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9).jpg"
    touch "ARQ${random_part1}-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9).png"
    touch "ARQ${random_part1}-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9).svg"
    touch "ARQ${random_part1}-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9).gif"

    touch "ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9).$(shuf -e txt jpg png csv -n 1)"

done

touch "$2.gif"