#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, tendrás que buscar la única línea que 
    empieza con ARQPYB en el archivo "NinoBravo".     
                                                        
    Comandos recomendados: grep
                     
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, terás que buscar a única liña que 
    comeza por ARQPYB no arquivo "NinoBravo"     
                                                        
    Comandos recomendados: grep
                   
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, you will need to find the only 
    line that starts with ARQPYB in the "NinoBravo" file.    
                                                        
    Recommended commands: grep
              
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
touch "NinoBravo"

line=$(shuf -i 15-75 -n 1)

for i in $(seq 1 99); do

    random_part1="PYB"
    while [ "$random_part1" = "PYB" ]; do
        random_part1=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 3)
    done
    random_part2=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)

    if [ $i -eq $line ]; then
        echo $2 >> "NinoBravo"
    else
        echo "ARQ${random_part1}-${random_part2}" >> "NinoBravo"
    fi
done
