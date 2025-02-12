#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag está invertida en el archivo "SIDAG" 
    (Gadis al revés), y es la única línea que empieza con ARQPYB.
                                                       
    Comandos recomendados: rev / cat / grep 

*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag está invertida no arquivo "SIDAG"
    (GADIS ao revés), máis é a única liña que comeza con ARQPYB.
                                                       
    Comandos recomendados: rev / cat / grep 
                                 
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is reversed in the "SIDAG" 
    file (Gadis backwards), and it is the only line that 
    starts with ARQPYB.
                                                       
    Recommended commands: rev / cat / grep 

*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
touch "SIDAG" 

for i in $(seq 1 200); do

    random_part1="PYB"
    while [ "$random_part1" = "PYB" ]; do
        random_part1=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 3)   # 3 caracteres aleatorios
    done
    random_part2=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)   # 9 caracteres aleatorios

    echo "ARQ${random_part1}-${random_part2}" >> "SIDAG"
done
echo "$2" >> "SIDAG"
shuf "SIDAG" -o "SIDAG"

tac "SIDAG" | rev > "SIDAG.tmp" && mv "SIDAG.tmp" "SIDAG"
