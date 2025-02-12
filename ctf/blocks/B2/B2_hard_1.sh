#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto tendrás que sacar la flag dentro 
    del archivo llamado ' - '             
                                                        
    Comandos recomendados: cat
                    
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto terás que sacar a flag dentro do
    arquivo chamado ' - '            
                                                        
    Comandos recomendados: cat
              
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, you will need to extract
    the flag from the file named '-'.             
                                                        
    Recommended commands: cat
                  
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
touch -
echo "$2" > -