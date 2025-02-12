#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag es el nombre del único archivo 
    del directorio actual cuyo propietario es $1.
                                                        
    Comandos recomendados: ls / find
          
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag é o nome do único arquivo do
    directorio actual cuxo propietario é $1.
                                                        
    Comandos recomendados: ls / find
              
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the name of the only 
    file in the current directory whose owner 
    is the $1.
                                                        
    Recommended Commands: ls / find
           
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
for i in $(seq 1 100); do
    flag="ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"
    touch "$flag"
done

touch "$2"
chown  "$1":retos_grp "$2"