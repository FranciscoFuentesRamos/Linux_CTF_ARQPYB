#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************
                                                     
    Este es el reto de introducción al Bloque 1 :3       
    (Navegación en directorios)                       
                                                        
    En este reto tendrás que sacar la flag del nombre 
    del único archivo visible de este directorio              
                                                        
    Comandos Recomendados: ls
                                                    
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************
                                                     
    Este é o reto de introdución ao Bloque 1 :3       
    (Navegación en directorios)                       
                                                        
    Neste reto terás que sacar a flag do nome 
    do único arquivo visible neste directorio              
                                                        
    Comandos Recomendados: ls
                                                    
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************
                                                     
    This is the introduction challenge to Block 1 :3
    (Directory Navigation)

    In this challenge, you will need to extract the flag 
    from the name of the only visible file in this directory.             
                                                        
    Recommended Commands: ls
                                                    
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
touch "$2"