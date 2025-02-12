#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"


# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la parte aleatoria de la flag 
    (es decir, lo que viene después de ARQPYB-), 
    está entre paréntesis en la única línea que 
    NO contiene la palabra ACAB (All Cats Are Beautiful) 
    dentro del archivo "AmanteBandido".   
                                                        
    Comandos recomendados: grep
                
*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a parte aleatoria da flag
    (é dicir, o que ven despois de ARQPYB- ) 
    está entre parénteses na única liña que
    NON contén a palabra ACAB (Amparo, Conchita, Asunción e Begoña)
    dentro do arquivo "AmanteBandido"

    Comandos recomendados: grep
             
*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the random part of the flag 
    (that is, what comes after ARQPYB-), 
    is inside parentheses on the only line that does 
    NOT contain the word ACAB (All Cats Are Beautiful) 
    within the "AmanteBandido" file.     

    Recommended commands: grep
                
*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------

generate_uppercase() {
    while :; do
        result=$(tr -dc 'A-Z' < /dev/urandom | head -c 10)
        case "$result" in
            *ACAB*) ;;  # Si contiene "ACAB", seguimos en el loop
            *) 
                echo "$result"  # Si no contiene "ACAB", lo imprimimos y salimos
                break
                ;;
        esac
    done
}

generate_uppercase_with_acab() {
    random_part=$(tr -dc 'A-Z' < /dev/urandom | head -c 6)
    position=$(od -An -N1 -i /dev/urandom | awk '{print ($1 % 7) + 1}')  # Nunca será 0

    first_part=$(echo "$random_part" | cut -c1-"$position" 2>/dev/null || echo "")
    second_part=$(echo "$random_part" | cut -c$((position + 1))- 2>/dev/null || echo "")

    echo "${first_part}ACAB${second_part}"
}

generate_random_chars() {
    tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 9
}

line=$(shuf -i 15-100 -n 1)
touch "AmanteBandido"

for i in $(seq 1 125); do
    if [ "$i" -eq "$line" ]; then
        echo "$(generate_uppercase)-($(echo "$2" | awk -F'-' '{print $2}'))" >> "AmanteBandido"
    else
        echo "$(generate_uppercase_with_acab)-($(generate_random_chars))" >> "AmanteBandido"
    fi
done


