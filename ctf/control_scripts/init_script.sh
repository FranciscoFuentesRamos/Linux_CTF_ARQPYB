#!/bin/sh


# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 

if grep -q "Reto01" /etc/passwd; then
    su - Reto01
fi

# docker run -it -v ./ctf:/local/ctf/ arqpyb_base /bin/sh -l

# ARGS -------------------------------------------
IDIOMA=$(cat /etc/ctf_var/LANG)
clear

# Definir los mensajes para cada idioma
case "$IDIOMA" in
  "es" )
    BLOQUES_MSG="¿Qué bloques quieres?"
    BLOQUES_B1="B1 - Navegación entre ficheros"
    BLOQUES_B2="B2 - Lectura de ficheros"
    BLOQUES_PROMPT="( 1,2 | 1 | 2 )"
    ERROR_MSG=" * Valor no válido * "
    NIVELES_MSG="¿Niveles por bloque?"
    NIVELES_PROMPT="(1-15)"
    INTRO_MSG="¿Nivel introductorio? (y/n)"
    INTRO_PROMPT="(s/n)"
    ;;
  "gl" )
    BLOQUES_MSG="¿Que bloques queres?"
    BLOQUES_B1="B1 - Navegación entre ficheiros"
    BLOQUES_B2="B2 - Lectura de ficheiros"
    BLOQUES_PROMPT="( 1,2 | 1 | 2 )"
    ERROR_MSG=" * Valor non válido * "
    NIVELES_MSG="Niveis por bloque?"
    NIVELES_PROMPT="(1-15)"
    INTRO_MSG="Nivel introdutorio?"
    INTRO_PROMPT="(s/n)"
    ;;
  "en" )
    BLOQUES_MSG="Which blocks do you want?"
    BLOQUES_B1="B1 - File navigation"
    BLOQUES_B2="B2 - File reading"
    BLOQUES_PROMPT="( 1,2 | 1 | 2 )"
    ERROR_MSG=" * Invalid value * "
    NIVELES_MSG="Levels per block?"
    NIVELES_PROMPT="(1-15)"
    INTRO_MSG="Introduction level?"
    INTRO_PROMPT="(y/n)"
    ;;
  * )
    echo "Idioma no soportado"
    exit 1
    ;;
esac


GREEN="\033[0;32m"
YELLOW="\033[1;31m"
RED="\033[0;37m"
RESET="\033[0m"

# Bloques
echo "****************************************************"
while true; do
  echo "\n${GREEN}$BLOQUES_MSG${RESET}"
  echo " "
  echo " ${GREEN}- $BLOQUES_B1${RESET}"
  echo " ${GREEN}- $BLOQUES_B2${RESET}"
  echo " "
  echo "${YELLOW}$BLOQUES_PROMPT${RESET}"
  echo " "
  read -r bloques 
  echo " "
  
  if echo "$bloques" | grep -Eq '^[1-2](,[1-2])*$'; then
    BLOQUES=$(echo "$bloques" | tr ',' '\n' | sort -n | uniq | tr '\n' ',' | sed 's/,$//')
    if [ -n "$BLOQUES" ]; then
      break
    fi
  fi
  echo "\n${RED}$ERROR_MSG${RED}\n"
done
echo "****************************************************"
# Niveles
while true; do
  echo "\n${GREEN}$NIVELES_MSG${RESET}"
  echo " "
  echo "${YELLOW}$NIVELES_PROMPT${RESET}"
  echo " "
  read -r NIVELES
  echo " "
  if [ "$NIVELES" -ge 1 ] 2>/dev/null && [ "$NIVELES" -le 15 ] 2>/dev/null; then
    break 
  else
    echo "\n${RED}$ERROR_MSG${RED}\n"
  fi
done
echo "****************************************************"
# Nivel introductorio
while true; do
  echo "\n${GREEN}$INTRO_MSG${RESET}"
  echo " "
  echo "${YELLOW}$INTRO_PROMPT${RESET}"
  echo " "
  read -r respuesta
  echo " "

  respuesta=$(echo "$respuesta" | tr '[:upper:]' '[:lower:]')

  if [ "$respuesta" = "y" ] || [ "$respuesta" = "s" ]; then
    INTRO_NIVEL=1 
    break
  elif [ "$respuesta" = "n" ]; then
    INTRO_NIVEL=0 
    break
  else
    echo "\n${RED}$ERROR_MSG${RED}\n"
  fi
done

NUM_BLOQUES=$(echo $BLOQUES | tr ',' '\n' | wc -l)
NUM_USERS=$((NIVELES * NUM_BLOQUES + NUM_BLOQUES * INTRO_NIVEL))

#Creación usuarios/retos ---------------------

mkdir /ctf
cp -r /local/ctf/blocks /ctf/

for i in $(seq 1 $NUM_USERS); do
  reto=$(echo "$i" | awk '{printf "Reto%02d", $1}')
  useradd -m "$reto"
  adduser "$reto" retos_grp
  chsh -s /bin/bash "$reto"

  touch /home/$reto/.ash_history
  chown $reto:$reto /home/$reto/.ash_history

  touch /home/$reto/.profile
  echo "*******************************************************
                                                                
    ERROR: Este reto aún no ha sido generado, 
    debes completar los retos anteriores
            
  *******************************************************" > /home/$reto/.reto_es
  echo "*******************************************************
                                                                
    ERRO: Este reto aínda non che foi xerado, 
    debes completar os retos anteriores
            
  *******************************************************" > /home/$reto/.reto_gl
  echo "*******************************************************
                                                                
    ERROR: This challenge hasn't been generated, 
    you must complete the previous challenges
            
  *******************************************************" > /home/$reto/.reto_es
  #.PROFILE -------------------------
  {
  # ALIAS
  echo "alias flag='sudo /local/ctf/control_scripts/trans_script.sh'"
  echo "alias reto='sh -c \"echo \\\"\\e[35m\$(cat /home/$reto/.reto_\$(cat /etc/ctf_var/LANG))\\e[0m\\\"\"'"
  echo "alias restart='sudo /local/ctf/control_scripts/restart_script.sh'"
  # HOME
  echo "export HOME=/home/$reto"
  echo "cd /home/$reto"
  # Prompt 
  echo "export PS1='\u\$ '"
  # Historial
  echo "export HISTFILE=/home/$reto/.ash_history"
  echo 'export HISTSIZE=1000'
  echo 'export HISTFILESIZE=2000'
  echo 'shopt -s histappend '
  echo 'PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"'
  # Limpieza terminal
  echo "clear"
  echo "echo \"\033[35m\$(cat /home/$reto/.reto_\$(cat /etc/ctf_var/LANG))\033[0m\"" 
  } >> "/home/$reto/.profile"
  chown "$reto:$reto" "/home/$reto/.profile"
done


#Creación Flag nivel actual ---------------------------

mkdir /etc/ctf_var/
touch /etc/ctf_var/flag
flag="ARQPYB-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 9)"
echo -n $flag | sha256sum > "/etc/ctf_var/flag"

# Configuración variables ---------------------------------

echo "$(date "+%Y-%m-%d %H:%M:%S")" > /etc/ctf_var/t0
echo "$((NIVELES + INTRO_NIVEL))" > /etc/ctf_var/NIVELES
echo "$BLOQUES" > /etc/ctf_var/BLOQUES
echo "$NUM_USERS" > /etc/ctf_var/NUM_USERS
echo "$INTRO_NIVEL" > /etc/ctf_var/INTRO
echo "Reto01" > "/etc/ctf_var/reto_actual"

echo "$(echo $BLOQUES | cut -d',' -f1)" > /etc/ctf_var/bloques_cnt
echo "0" > /etc/ctf_var/niveles_cnt
echo "0" > /etc/ctf_var/users_cnt

touch /etc/ctf_var/results.csv

# Configuración primer usuario

touch /etc/ctf_var/reto_type

bloque_numero="B$(echo $BLOQUES | cut -d',' -f1)"

if [ "$INTRO_NIVEL" -eq 1 ]; then
  "/ctf/blocks/$bloque_numero/${bloque_numero}_intro.sh" Reto01 $flag
  rm /ctf/blocks/$bloque_numero/${bloque_numero}_intro.sh
  echo "facil" > /etc/ctf_var/reto_type
else
  selected_file=$(ls /ctf/blocks/$bloque_numero/${bloque_numero}_facil_*.sh | shuf -n 1)
  echo "facil" > /etc/ctf_var/reto_type
  "$selected_file" Reto01 $flag
  rm $selected_file
fi

su - Reto01