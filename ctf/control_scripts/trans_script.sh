#!/bin/sh


# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
IDIOMA=$(cat /etc/ctf_var/LANG)

# Definir los mensajes para cada idioma
case "$IDIOMA" in
  "es" )
    NO_FLAG="Error: No se ha proporcionado ninguna flag."
    BAD_FLAG="Lo siento, la flag no es correcta"
    ;;
  "gl" )
    NO_FLAG="Erro: Non se proporcionou ningunha flag."
    BAD_FLAG="Sintoo, a flag non é correta"
    ;;
  "en" )
    NO_FLAG="Error: There is no flag."
    BAD_FLAG="Sorry, that's not the flag"
    ;;
  * )
    echo "Idioma no soportado"
    exit 1
    ;;
esac

RED="\033[0;37m"
RESET="\033[0m"


if [ -z "$1" ]; then
    echo "${RED}$NO_FLAG${RESET}"
    exit 1
fi
# Conseguimos la flag

num=$(pwd | sed 's|^/home/Reto||; s|/.*||' | sed 's/^0*//')

if [ "$(sed -n "${num}p" "/etc/ctf_var/flag")" = "$(echo -n $1 | sha256sum)" ]; then
    # Echo jocoso

    clear
    echo "\e[32m$(cat /local/ctf/congrats.txt)\e[0m" 


    if [ "$(cat /etc/ctf_var/reto_actual)" = "$(printf "Reto%02d" "$(expr "$num")")" ]; then # EL RETO ES EL RETO ACTUAL
        # Subir datos al csv -----------------------------------------------------
        result_reto="$(cat /etc/ctf_var/t0);$(echo "$(date "+%Y-%m-%d %H:%M:%S")");$(cat /etc/ctf_var/reto_type);$(( $(wc -l < "/home/$(printf "Reto%02d" "$(expr "$num")")/.ash_history") + 1 ))"
        echo "$result_reto" >> /etc/ctf_var/results.csv
        ##
        #Variables
        ##
        users_cnt=$(( $(cat /etc/ctf_var/users_cnt) + 1 )) && echo $users_cnt > /etc/ctf_var/users_cnt
        niveles_cnt=$(( $(cat /etc/ctf_var/niveles_cnt) + 1 )) && echo $niveles_cnt > /etc/ctf_var/niveles_cnt
        bloques_cnt=$(cat /etc/ctf_var/bloques_cnt)

        bloque_numero=$(cat /etc/ctf_var/BLOQUES | cut -d',' -f$(cat /etc/ctf_var/bloques_cnt))
        
        num_decimal=$(expr "$num" + 0)
        siguiente_reto=$(printf "Reto%02d" $(expr $num_decimal + 1))



        change_bloq=0
        flag="ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"

        # Acabamos la run  ------------------------------------------------------
        if [ "$users_cnt" -eq "$(cat /etc/ctf_var/NUM_USERS)" ]; then
            clear
            sh /local/ctf/control_scripts/print.sh /etc/ctf_var/results.csv
            exit 0
        # Cambiamos bloque  --------------------------------------------------------
        elif [ "$niveles_cnt" -eq "$(cat /etc/ctf_var/NIVELES)" ]; then
            echo "$(( bloques_cnt + 1 ))" > /etc/ctf_var/bloques_cnt
            echo "0" > /etc/ctf_var/niveles_cnt
            change_bloq=1
            bloque_numero=$(cat /etc/ctf_var/BLOQUES | cut -d',' -f$(cat /etc/ctf_var/bloques_cnt))
        fi

        echo "$siguiente_reto" > "/etc/ctf_var/reto_actual"

        #Generar nueva flag ---------
        
        echo -n $flag | sha256sum >> "/etc/ctf_var/flag"

        # Generar nuevo Reto --------------
        echo "$(date "+%Y-%m-%d %H:%M:%S")" > /etc/ctf_var/t0
        
        if [ "$change_bloq" -eq 1 ] && [ "$(cat /etc/ctf_var/INTRO)" -eq 1 ]; then # Cambiamos de bloque y hay intro
            selected_file=/ctf/blocks/B$bloque_numero/B${bloque_numero}_intro.sh
            echo "facil" > /etc/ctf_var/reto_type

        elif [ "$change_bloq" -eq 1 ]; then # Cambio bloque SIN intro
            selected_file=$(ls /ctf/blocks/B$bloque_numero/B${bloque_numero}_facil_*.sh | shuf -n 1)
            echo "facil" > /etc/ctf_var/reto_type
        else # TRANSICIÓN NORMAL


            new_diff=$(python3 /local/ctf/control_scripts/selection_script.py "$result_reto")
            
            selected_file=$(ls /ctf/blocks/B$bloque_numero/B${bloque_numero}_${new_diff}*.sh | shuf -n 1)
            if [ -z "$selected_file" ]; then
                selected_file=$(ls /ctf/blocks/B$bloque_numero/B${bloque_numero}_*.sh | shuf -n 1)
                new_diff=$(echo "$selected_file" | awk -F'_' '{print $2}')
            fi
            echo "$new_diff" > /etc/ctf_var/reto_type
        fi 
        
        bash "$selected_file" "$siguiente_reto" "$flag"
        rm "$selected_file"
        su - "$siguiente_reto"

    else # El reto no es el actual, simplemente loguea al siguiente
        num_decimal=$(expr "$num" + 0)
        siguiente_reto=$(printf "Reto%02d" $(expr $num_decimal + 1))
        su - "$siguiente_reto"
    fi
else
    echo "${RED}$BAD_FLAG${RESET}"
fi
