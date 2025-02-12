#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag es el nombre del archivo 
    que pesa exactamente 69 bytes.
                                                        
    Comandos recomendados: find / ls
                                                    
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag é o nome do único arquivo que
    pesa exactamente 69 bytes
                                                        
    Comandos recomendados: find / ls
                 
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the name of the 
    file that weighs exactly 69 bytes.
                                                        
    Recommended Commands: find / ls
                
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
for i in $(seq 1 100); do
    flag="ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"
    size=69
    while [ "$size" -eq 69 ]; do
        size=$(od -An -N1 -i /dev/urandom | tr -d ' ' | awk '{print ($1 % 101)}')
    done
    dd if=/dev/urandom of="$flag" bs="$size" count=1 > /dev/null 2>&1
done

dd if=/dev/urandom of="$2" bs=69 count=1 > /dev/null 2>&1