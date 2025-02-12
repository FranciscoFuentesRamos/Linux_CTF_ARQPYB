#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag es el nombre de uno de los
    archivos en cualquiera de las carpetas dentro del directorio
    "miau". El archivo contiene la palabra "Alexelcapo".            
                                                        
    Comandos recomendados: grep 
         
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag é o nome dun dos arquivos dentro de 
    calqueira das carpetas do directorio "miau".
    O arquivo contén a palabnra "Alexelcapo"          
                                                        
    Comandos recomendados: grep 
               
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the name of one
    of the files in any of the folders within the "miau" 
    directory. The file contains the word "Alexelcapo".            
                                                        
    Recommended commands: grep 
               
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
mkdir "miau" && cd miau

crear_archivos() {
    carpeta="$1"
    echo "Mortadelo" >> "$carpeta/Wallace"
    echo "Filemon" >> "$carpeta/Grommit"
    echo "Tronchamulas" >> "$carpeta/Lady_Campanula_Tottington"
    echo "Ofelia" >> "$carpeta/Señora_Mantillo"
    echo "SuperintendenteVicente" >> "$carpeta/Feathers_McGraw"
    echo "JimmyElCachondo" >> "$carpeta/Victor_Quartermaine"
    echo "Trini" >> "$carpeta/Reverend Clement Hedges"
    echo "Mari" >> "$carpeta/Mr_Crock"
    echo "Bacterio" >> "$carpeta/Mrs_Girdling"
    echo "Rompetechos" >> "$carpeta/Mr_Leaching"
}


for i in $(seq 1 40); do

    folder=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 6)
    mkdir "$folder" && crear_archivos "$folder"

done

folder=$(find -type d | shuf -n 1)
file=$(ls $folder | shuf -n 1)
rm "$folder/$file"
echo "Alexelcapo" >> "$folder/$2"