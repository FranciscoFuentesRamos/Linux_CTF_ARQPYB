#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************
                                                     
    Este es el reto de introducción al Bloque 2 :3
    (Información en ficheros).

    En este reto, tendrás que obtener la flag del archivo 
    en el directorio actual, cuyo nombre es el mejor cantautor 
    español.              
                                                        
    Comandos recomendados: cat
                                                    
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************
                                                     
    Este é o reto de introducción ao Bloque 2 :3
    (Información en ficheiros)

    Neste reto, terás que obter a flag do arquivo no directorio
    actual, cuxo nome é o mellor cantautor español             
                                                        
    Comandos recomendados: cat
                                                    
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************
                                                     
    This is the introductory challenge to Block 2 :3 
    (File Information).

    In this challenge, you will need to extract the flag 
    from the file in the current directory, whose name is 
    the best Spanish singer-songwriter.              
                                                        
    Recommended commands: cat
                                                    
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
touch "julio_iglesias.txt"
echo "$2">>"julio_iglesias.txt"