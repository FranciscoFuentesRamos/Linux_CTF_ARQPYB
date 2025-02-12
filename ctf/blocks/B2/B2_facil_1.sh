#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************
                                                                  
    En este reto, tendrás que obtener la flag del archivo 
    que tiene espacios en el nombre.           
                                                        
    Comandos recomendados: cat
             
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************
                                                                  
    Neste reto, terás que obter a flag do arquivo
    que ten espazos no nome              
                                                        
    Comandos recomendados: cat
                      
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************
                                                                  
    In this challenge, you will need to extract
    the flag from the file that has spaces in its name.
             
                                                        
    Recommended commands: cat
                
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
touch "la revolucion industrial y sus consecuencias"
echo "$2" > "la revolucion industrial y sus consecuencias"