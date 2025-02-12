#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************
                                                                  
    En este reto, tendrás que obtener la flag del 
    primer carácter de las 9 flags entre las líneas 75 y 83 
    del archivo "AnaRosaQuintana".            
                                                        
    Comandos recomendados: sed / cut / tr /cat
                    
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************
                                                                  
    Neste reto, terás que obter a flag do primeiro 
    caracter das 9 filas entre as liñas 75 e 83
    do arquivo "AnaRosaQuintana"         
                                                        
    Comandos recomendados: sed / cut / tr /cat
                    
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************
                                                                  
    In this challenge, you will need to extract the flag 
    from the first character of the 9 flags between 
    lines 75 and 83 of the "AnaRosaQuintana" file.
                                                        
    Recommended commands: sed / cut / tr /cat
                   
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
touch "AnaRosaQuintana"

for i in $(seq 1 74); do
    flag="ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"
    echo "$flag" >> "AnaRosaQuintana"
done

suffix=$(echo "$2" | cut -c8-16)
for i in $(seq 0 8); do
  flag_pz=$(echo "$suffix" | cut -c$((i+1))) 
  echo "ARQPYB-$flag_pz$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8)" >> "AnaRosaQuintana"
done

for i in $(seq 1 74); do
    flag="ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"
    echo "$flag" >> "AnaRosaQuintana"
done