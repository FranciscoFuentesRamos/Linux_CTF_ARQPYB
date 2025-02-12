#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto la flag es :
    - Un archivo oculto 
    - Empieza por ARQPYB 
    - Es el archivo más pesado dentro de la única 
    carpeta cuyo propietario es $1
                                                        
    Comandos recomendados: find / ls / grep / head 

*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto a flag é:
    - Un arquivo oculto
    - Comeza por ARQPYB
    - É o arquivo máis pesado dentro da única
    carpeta cuxo propietario é $1

    Comandos recomendados: find / ls / grep / head 

*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is:
    - A hidden file 
    - Starts with ARQPYB 
    - Is the heaviest within the only folder 
    owned by $1.
                                                        
    Recommended Commands: find / ls / grep / head 

*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
for i in $(seq 1 20); do    
    dir_name="dir_$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 8)"
    mkdir "$dir_name"

    for j in $(seq 1 10); do
        random_value=$(od -An -N1 -i /dev/urandom | tr -d ' ')
        if [ $((random_value % 25)) -gt 0 ]; then

            size=$(od -An -N1 -i /dev/urandom | tr -d ' ')
            size=$((size % 51))

            filename="ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"
            hidden_filename=".ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"

            head -c "$size" </dev/urandom > "$dir_name/$filename"
            head -c "$size" </dev/urandom > "$dir_name/$hidden_filename"
        fi
    done
done

selected_folder=$(find . -maxdepth 1 -type d -name 'dir_*' | shuf -n 1)

chown  "$1":retos_grp "$selected_folder"

head -c "60" </dev/urandom > "$selected_folder/.$2"


