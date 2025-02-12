#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag está en el único 
    archivo que se encuentra a dos (2) directorios atrás 
    de distancia del que te encuentras.              
                                                        
    Comandos recomendados: cd / ls
                                                    
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag está no único arquivo que se 
    atopa a dous (2) directorios atrás do que te 
    atopas actualmente              
                                                        
    Comandos recomendados: cd / ls
                                                    
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is in the only file 
    located two (2) directories back from 
    your current directory              
                                                        
    Recommended Commands: cd / ls
                                                    
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------

touch "$2"
mkdir -p "/home/$1/Mortadelo/Filemon"
echo "cd /home/$1/Mortadelo/Filemon" >> /home/$1/.profile