#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag está en la carpeta con 
    caracteres en cirílico,
    (usar el tabulador puede ser útil).
                                                        
    Comandos recomendados: ls / cd  
                                                    
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag está no cartafol con
    caracteres en cirílico, 
    (igual, usar o tabulador pode ser útil)
                                                        
    Comandos recomendados: ls / cd  
              
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is in the folder with
    Cyrillic characters (using the tab key might be helpful).
                                                        
    Recommended commands: ls / cd  
                                                    
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
mkdir "boas_нино_браво"
touch "boas_нино_браво"/$2