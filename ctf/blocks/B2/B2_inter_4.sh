#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag se encuentra en el número de 
    línea del archivo "SeñorAlcalde" correspondiente al 
    número de veces que aparece la palabra "miau" en el 
    archivo "Expropiese".
                                                        
    Comandos recomendados: wc / cut / cat / grep
  
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag atópase no número de liña do
    arquivo "SeñorAlcalde" correspondente ao número
    de veces que aparece a palabra "miau" no arquivo
    "Expropiese".            
                                                        
    Comandos recomendados: wc / cut / cat / grep
                                       
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is found in the line 
    number of the "SeñorAlcalde" file corresponding to 
    the number of times the word "miau" appears in the 
    "Expropiese" file.            
                                                        
    Recommended commands: wc / cut / cat / grep

*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------

touch "SeñorAlcalde"  && touch "Expropiese"

miau=$(shuf -i 1-75 -n 1) 

for i in $(seq 1 500); do
    echo "$(tr -dc 'a-z' < /dev/urandom | head -c 4)" >> "Expropiese"
done
for i in $(seq 1 $miau); do
    echo "miau" >> "Expropiese"
done
shuf "Expropiese" -o "Expropiese"
for i in $(seq 1 100); do

    if [ "$i" -eq "$miau" ]; then
        echo "$2" >> "SeñorAlcalde"
    else
        echo "ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)" >> "SeñorAlcalde"
    fi

done
