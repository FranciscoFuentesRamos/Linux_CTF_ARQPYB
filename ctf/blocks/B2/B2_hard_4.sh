#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag se ha dividido entre los 
    archivos dentro de este directorio, y es la única 
    línea que empieza con ARQPYB. 
    (El número de los archivos indica el orden).        
                                                        
    Comandos recomendados: mawk / grep

*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto a flag foi dividida entre os 
    arquivos dentro do directorio actual, máis é
    a única liña que comeza por ARQPYB.
    (O número do arquivo indica seu orde)          
                                                        
    Comandos recomendados: mawk / grep

*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag has been split across 
    the files in this directory, and it is the only 
    line that starts with ARQPYB. 
    (The number of the files indicates the order).            
                                                        
    Recommended commands: mawk / grep
                             
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
touch "foo"

for i in $(seq 1 100); do

    random_part1="PYB"
    while [ "$random_part1" = "PYB" ]; do
        random_part1=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 3) 
    done
    random_part2=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)

    echo "ARQ${random_part1}-${random_part2}" >> "foo"
done

echo "$2" >> "foo"
shuf "foo" -o "foo"

for i in $(seq 1 4); do
    touch "file_$i"
    awk -v start=$(( (i - 1) * 4 + 1 )) -v len=4 '{print substr($0, start, len)}' "foo" > "file_$i"
done

rm "foo"



