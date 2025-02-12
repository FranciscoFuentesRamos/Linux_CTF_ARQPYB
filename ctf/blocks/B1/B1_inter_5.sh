#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# Reto -------------------------
touch .reto

# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag es el nombre del archivo MENOS
    pesado del directorio actual
                                                        
    Comandos recomendados: ls | tail

*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag é o nome do arquivo menos pesado
    do directorio actual
                                                        
    Comandos recomendados: ls | tail

*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the name of the 
    lightest file in the current directory.
                                                        
    Recommended Commands: ls | tail

*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
for i in $(seq 1 25); do
    head -c "$((( RANDOM % 50 ) + 1 ))" /dev/urandom > "ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"
done
touch "$2"