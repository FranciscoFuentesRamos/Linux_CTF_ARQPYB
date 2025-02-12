#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"

# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag está dentro de un archivo 
    en cualquiera de las carpetas dentro del 
    directorio "miau". Buena suerte :) 
    (Recuerda que las flags empiezan con ARQPYB).             
                                                        
    Comandos recomendados: grep

*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag está dentro dun arquivo en 
    calqueira das carpetas dentro do directorio "miau".
    Boa sorte :) 
    (Lembra que as flags comezan por ARQPYB).            
                                                        
    Comandos recomendados: grep
     
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is inside a file in any 
    of the folders within the "miau" directory. Good luck :) 
    (Remember that flags start with ARQPYB).               
                                                        
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

for i in $(seq 1 20); do

    folder=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 6)
    mkdir $folder && crear_archivos "$folder"

done

folder=$(find -type d | shuf -n 1)
file=$(ls $folder | shuf -n 1)
echo $2 > "$folder"/"$file"