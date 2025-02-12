#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto tienes 2 archivos:

    - "Cespi" contiene las claves
    - "Omar" contiene los valores

    El valor de la flag corresponde a la misma línea
    donde está la clave "panecillos".       
                                                        
    Comandos recomendados: grep / cat / sed / cut / mawk
                                                    
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto temos 2 arquivos:

    - "Cespi" contén as chaves 
    - "Omar" contén os valores 

    O valor da flag corresponde á mesma liña
    onde está a chave "panecillos"     
                                                        
    Comandos recomendados: grep / cat / sed / cut / mawk
                                                    
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, you have 2 files:

    - "Cespi" contains the keys
    - "Omar" contains the values

    The flag's value corresponds to the same line
    where the key "panecillos" is found.       
                                                        
    Recommended commands: grep / cat / sed / cut / mawk

*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
touch "Omar" && touch "Cespi"

line=$(shuf -i 15-175 -n 1)

for i in $(seq 1 200); do
    longitud=$((RANDOM % 8 + 3))
    palabra=$(tr -dc 'a-z' < /dev/urandom | head -c "$longitud")

    if [ $i -eq $line ]; then
        echo $2 >> "Omar"
        echo "panecillos" >> "Cespi"
    else
        echo "ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)" >> "Omar"
        echo "$(tr -dc 'a-z' < /dev/urandom | head -c $((RANDOM % 8 + 3)))" >> "Cespi"
    fi
done