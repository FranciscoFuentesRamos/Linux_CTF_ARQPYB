#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************
                                                                  
    En este reto, tendrás que obtener la flag 
    correspondiente a la fila con el valor numérico 
    más alto del archivo "campurrianas".          
                                                        
    Comandos recomendados: cat / sort / tail 
               
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************
                                                                  
    Neste reto, terás que obter a flag
    correspondente á fila co valor numérico
    máis alto do arquivo "campurrianas"  
                                                        
    Comandos recomendados: cat / sort / tail 
             
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************
                                                                  
    In this challenge, you will need to extract the flag 
    corresponding to the row with the highest numeric 
    value in the "campurrianas" file.
                                                        
    Comandos recomendados: cat / sort / tail 
                
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------

touch "campurrianas"
for _ in $(seq 1 300); do
    random_number=$(shuf -i 1-4877 -n 1) 
    random_string="ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)" > "file_$i"
    echo "$random_number,$random_string" >> "campurrianas"
done
echo "$(shuf -i 4879-4889 -n 1),$2" >> "campurrianas"
shuf "campurrianas" -o "campurrianas"

