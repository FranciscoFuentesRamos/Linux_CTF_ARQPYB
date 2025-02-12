#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag es el nombre del directorio en el 
    que te encuentras, dentro de la ruta /home del reto actual.               
                                                        
    Comandos recomendados: pwd
                                                    
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag é o nome do directorio no que te 
    atopas, dentro da ruta /home do reto actual.               
                                                        
    Comandos recomendados: pwd
                                                    
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the name of the directory 
    you are in, within the /home path of the current challenge.              
                                                        
    Recommended commands: pwd
                                                    
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
mkdir "$2"
echo "cd /home/$1/$2" >> /home/$1/.profile