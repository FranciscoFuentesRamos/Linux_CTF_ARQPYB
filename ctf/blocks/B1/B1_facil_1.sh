#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).

cd "/home/$1"
# LANG -------------------------
# ES ---------------------------
echo "*******************************************************                       
                                                        
    En este reto la flag es el nombre del único
    archivo oculto en tu directorio actual que empieza
    por ARQPYB.               
                                                        
    Comandos recomendados: ls
                                                    
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto a flag é o nome do único arquivo
    oculto no directorio actual. Lembra que o arquivo 
    ten que comezar por ARQPYB             
                                                        
    Comandos recomendados: ls
                                                    
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the name 
    of the only hidden file in your current 
    directory that starts with ARQPYB.              
                                                        
    Recommended commands: ls
                                                    
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
touch ".$2"


