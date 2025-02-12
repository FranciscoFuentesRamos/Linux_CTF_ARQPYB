#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag es el nombre del 
    único archivo que empieza con ARQPYB.             
                                                        
    Comandos recomendados: ls
                                                    
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
    
    Neste reto, a flag é o nome do único 
    arquivo que comeza por ARQPYB.             
                                                        
    Comandos recomendados: ls
            
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the name of 
    the only file that starts with ARQPYB.               
                                                        
    Recommended Commands: ls
                                                    
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
for i in $(seq 1 99); do

    random_part1="PYB"
    while [ "$random_part1" = "PYB" ]; do
        random_part1=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 3)   # 3 caracteres aleatorios
    done
    random_part2=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)   # 9 caracteres aleatorios

    touch "ARQ${random_part1}-${random_part2}"
done

touch $2