#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto la flag es el nombre del archivo que menos
    pesa dentro del directorio mas pesado

    (OJO : ls y find no te dicen el tamaño real
    del directorio)
                                                        
    Comandos recomendados: du / sort / find / ls /
              
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto a flag é o nome do arquivo que menos pesa
    dentro do directorio máis pesado

    (OLLO_PIOLLO : ls e find non din o tamaño real
    do directorio)
                                                        
    Comandos recomendados: du / sort / find / ls / 
                       
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the name of 
    the lightest file within the heaviest directory.

    (TIP : ls and find don't show the real
    directory's size)

    Recommended Commands: du / sort / find / ls / 
                                                    
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
for i in $(seq 1 20); do
    mkdir -p "C$i"   
    for j in $(seq 1 10); do
        size=33
        while [ "$size" -eq 33 ] || [ "$size" -eq 0 ]; do
            size=$(( $(od -An -N1 -i /dev/urandom | tr -d ' ') % 51 ))
        done
        flag="ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"
        dd if=/dev/urandom of="C$i/$flag" bs="$size" count=1 > /dev/null 2>&1
    done
done

cd "$(find . -mindepth 1 -maxdepth 1 -type d -exec du -h {} + | sort -hr | 
head -n 1 | awk '{print $2}' | xargs -I {} basename {})"
touch "$2"