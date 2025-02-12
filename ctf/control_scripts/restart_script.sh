#!/bin/sh


# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
IDIOMA=$(cat /etc/ctf_var/LANG)
clear

case "$IDIOMA" in
  "es" )
    WARNING_MSG="Borrarás todo tu progreso"
    CONF_MSG="¿Estás seguro de que quieres continuar? (s/n)"
    ERROR_MSG=" * Valor no válido * "
    ;;
  "gl" )
    WARNING_MSG="Vas borrar todo o teu progreso"
    CONF_MSG="Estás seguro de que queres continuar? (s/n)"
    ERROR_MSG=" * Valor non válido * "
    ;;
  "en" )
    WARNING_MSG="You will delete all your progress"
    CONF_MSG="Are you sure you want to continue? (y/n)"
    ERROR_MSG=" * Invalid value * "
    ;;
  * )
    echo "Idioma no soportado"
    exit 1
    ;;
esac


RED="\033[0;37m"
RESET="\033[0m"

echo "${RED}****************************************************${RESET}"
while true; do
  echo "\n${RED}$WARNING_MSG${RESET}"
  echo " "
  echo "${RED}$CONF_MSG${RESET}"
  echo " "
  read -r respuesta
  echo " "

  respuesta=$(echo "$respuesta" | tr '[:upper:]' '[:lower:]')

  if [ "$respuesta" = "y" ] || [ "$respuesta" = "s" ]; then
    total_retos=$(cat /etc/ctf_var/NUM_USERS)

    for i in $(seq 1 $total_retos); do
        usuario=$(printf "Reto%02d" $i)

        deluser --remove-home $usuario > /dev/null 2>&1

    done

    find /etc/ctf_var -mindepth 1 ! -name 'LANG' -exec rm -rf {} +
    rm -rf /ctf

    su - Reto00
    break
  elif [ "$respuesta" = "n" ]; then
      clear
      echo "\033[35m Nothing ever happens -_-\033[0m" 
      break
  else
      echo "\n${RED}$ERROR_MSG${RED}\n"
  fi
done





