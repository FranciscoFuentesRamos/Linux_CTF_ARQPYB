#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
cd "/home/$1"
# Reto -------------------------
touch .reto

# LANG -----------------------
# ES -------------------------
echo "*******************************************************                       
                                                        
    En este reto, la flag es el archivo MÁS antiguo 
    de la carpeta creada el día que nací, 
    (22/07/2002, por si eres un desconsiderado).
                                                        
    Comandos recomendados: ls / grep / tail / mawk

*******************************************************" > .reto_es
# GL -------------------------
echo "*******************************************************                       
                                                        
    Neste reto, a flag é o arquivo MÁIS antigo do
    cartafol creado o día que nacín.
    (22/07/2002, por se eres un desconsiderado, pailán)
                                                        
    Comandos recomendados: ls / grep / tail / mawk

*******************************************************" > .reto_gl
# EN -------------------------
echo "*******************************************************                       
                                                        
    In this challenge, the flag is the oldest file in the 
    folder created on my birthday 
    (22/07/2002, in case you're inconsiderate).
                                                        
    Recommended commands: ls / grep / tail / mawk

*******************************************************" > .reto_en
#------------------------------
# RETO
#------------------------------
# Generar un número aleatorio usando od
get_random() {
    od -An -N2 -i /dev/urandom | awk '{print $1}'
}

for i in $(seq 1 40); do
    # Generar fecha aleatoria
    year=$(($(get_random) % 24 + 2000))      # Año entre 2000 y 2023
    month=$(($(get_random) % 12 + 1))         # Mes entre 1 y 12
    day=$(($(get_random) % 28 + 1))           # Día entre 1 y 28 (para evitar problemas con meses de 30/31 días)
    hour=$(($(get_random) % 24))              # Hora entre 0 y 23
    minute=$(($(get_random) % 60))            # Minuto entre 0 y 59
    second=$(($(get_random) % 60))            # Segundo entre 0 y 59

    random_date=$(printf "%04d%02d%02d%02d%02d.%02d" "$year" "$month" "$day" "$hour" "$minute" "$second")

    mkdir -p "C-$i"

    for j in $(seq 1 20); do
        # Generar fecha aleatoria
        year=$(($(get_random) % 24 + 2000))
        month=$(($(get_random) % 12 + 1))
        day=$(($(get_random) % 28 + 1))
        hour=$(($(get_random) % 24))
        minute=$(($(get_random) % 60))
        second=$(($(get_random) % 60))

        random_date=$(printf "%04d%02d%02d%02d%02d.%02d" "$year" "$month" "$day" "$hour" "$minute" "$second")

        # Crear archivo con fecha aleatoria
        touch -t "$random_date" "C-$i/ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"
    done

    # Crear directorio con fecha aleatoria
    touch -t "$random_date" "C-$i"
done

# Elegir una carpeta aleatoria
folder=$(find . -type d -name "C-*" | shuf -n 1)

# Generar fecha aleatoria para los archivos finales
hour=$(($(get_random) % 24))
minute=$(($(get_random) % 60))
second=$(($(get_random) % 60))
touch -t "$(printf "19990911%02d%02d.%02d" "$hour" "$minute" "$second")" "$folder/$2"

hour=$(($(get_random) % 24))
minute=$(($(get_random) % 60))
second=$(($(get_random) % 60))
touch -t "$(printf "20020722%02d%02d.%02d" "$hour" "$minute" "$second")" "$folder"
