#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag es el nombre del 
    archivo .txt más pesado de entre todos 
    los directorios 
    (el .txt no forma parte de la flag).
                                                    
    Comandos recomendados: ls / head / find
                   
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag é o nome do arquivo .txt
    máis pesado de entre todos os directorios
    (o .txt non forma parte da flag, lémbrao)
                                                    
    Comandos recomendados: ls / head / find

*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the name of 
    the heaviest .txt file among all the directories 
    (the .txt is not part of the flag).
                                                    
    Recommended Commands: ls / head / find

*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------

#!/bin/sh

# Generar directorios y archivos
for i in $(seq 1 20); do    
    dir_name="dir_$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 8)"
    mkdir "$dir_name"

    for j in $(seq 1 20); do
        file_name="ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9).$(shuf -e txt jpg png gif csv -n 1 2>/dev/null || echo txt)"
        
        random_value=$(od -An -N1 -i /dev/urandom | tr -d ' ')
        if [ $((random_value % 101)) -gt 0 ]; then
            size=$(( $(od -An -N1 -i /dev/urandom | tr -d ' ') % 75 ))
            if [ "$size" -gt 0 ]; then
                head -c "$size" </dev/urandom > "$dir_name/$file_name"
            fi
        fi
    done
done

# Seleccionar un directorio aleatorio y crear un archivo específico
dir=$(find . -type d -name "dir_*" | shuf -n 1 2>/dev/null || echo "")

size=$(( $(od -An -N1 -i /dev/urandom | tr -d ' ') % 21 + 80 ))
head -c "$size" </dev/urandom > "$dir/$2.txt"



