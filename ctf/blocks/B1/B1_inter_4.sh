#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag es el nombre del archivo 
    creado más recientemente.
                                                        
    Comandos recomendados: ls | head

*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag é o nome do arquivo creado
    máis recentemente
                                                        
    Comandos recomendados: ls | head

*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the name of 
    the most recently created file.
                                                        
    Recommended Commands: ls | head

*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
for i in $(seq 1 50); do
    random_date="$(printf "%04d%02d%02d%02d%02d.%02d" \
        $((RANDOM % 24 + 2000)) $((RANDOM % 12 + 1)) $((RANDOM % 28 + 1)) \
        $((RANDOM % 24)) $((RANDOM % 60)) $((RANDOM % 60)))"

    touch -t "$random_date" "ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"
done

touch "$2"





