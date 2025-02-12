#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag se encuentra en el archivo 
    (file_X) que coincida con el número de líneas 
    del archivo "FuturoAlcaldeDeSantiago".           
                                                        
    Comandos recomendados: wc / cut / cat
                                                    
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag atópase no arquivo (file_X)
    que coincida co número de liñas do
    arquivo "FuturoAlcaldeDeSantiago"            
                                                        
    Comandos recomendados: wc / cut / cat
                                                    
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is in the file (file_X) 
    that matches the number of lines in the 
    "FuturoAlcaldeDeSantiago" file.            
                                                        
    Recommended commands: wc / cut / cat
               
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------

num_lines=$(shuf -i 1-49 -n 1) 
touch "FuturoAlcaldeDeSantiago"
for i in $(seq 1 "$num_lines"); do
    echo "" >> "FuturoAlcaldeDeSantiago" 
done

for i in $(seq 1 50); do
    if [ "$i" -eq "$num_lines" ]; then
        echo "$2" > "file_$i"
    else
        echo "ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)" > "file_$i"
    fi
done
