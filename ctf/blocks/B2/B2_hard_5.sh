#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag está en el número de línea 
    del archivo "Marmelo" correspondiente al número 
    de líneas del archivo "Queixo" que contengan al 
    menos un número.
                                                             
    Comandos recomendados: sed / grep

*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag está no número de liña di arquivo
    "Marmelo" correspondente ao número de liñas do arquivo
    "Queixo" que conteñan polo menos un número.
                                                             
    Comandos recomendados: sed / grep

*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    n this challenge, the flag is in the line number
    of the "Marmelo" file that corresponds to the number 
    of lines in the "Queixo" file containing at least one number.
                                                             
    Recommended commands: sed / grep

*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
touch Queixo && touch Marmelo

numbers=$(shuf -i 1-250 -n 1) 

for i in $(seq 1 $numbers); do
    echo "$(tr -dc 'a-zA-Z' < /dev/urandom | head -c 9)" >> "Queixo"
    echo "$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)" >> "Queixo"
done
n=$(grep -c '[0-9]' Queixo)

shuf "Queixo" -o "Queixo"

for i in $(seq 1 500); do

    if [ "$i" -eq "$n" ]; then
        echo "$2" >> "Marmelo"
    else
        echo "ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)" >> "Marmelo"
    fi
   
done
