#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************
                                                                  
    En este reto, tendrás que obtener la flag de
    la línea 200 del archivo "SusanaGrito".     
                                                        
    Comandos recomendados: sed

*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************
                                                                  
    Neste reto, terás que obter a flag da
    liña 200 do arquivo "SusanaGrito"             
                                                        
    Comandos recomendados: sed

*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************
                                                                  
    In this challenge, you will need to extract the flag 
    from line 200 of the "SusanaGrito" file.             
                                                        
    Recommended commands: sed

*******************************************************" > .reto_es
#------------------------------
# RETO
#------------------------------
touch "SusanaGrito"

for i in $(seq 1 199); do
    flag="ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"
    echo "$flag" >> "SusanaGrito"
done
echo "$2" >> "SusanaGrito"
for i in $(seq 1 74); do
    flag="ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"
    echo "$flag" >> "SusanaGrito"
done