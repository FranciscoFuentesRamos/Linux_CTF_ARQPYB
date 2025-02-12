#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
# docker load -i image/arqpyb_base.tar

# Permisos --------------------------------------------

echo "root ALL=(ALL:ALL) ALL  " > /etc/sudoers
echo "%retos_grp ALL=(root) NOPASSWD: /local/ctf/control_scripts/trans_script.sh  " >> /etc/sudoers
echo "Reto00 ALL=(root) NOPASSWD: /local/ctf/control_scripts/init_script.sh" >> /etc/sudoers
echo "%retos_grp ALL=(root) NOPASSWD: /local/ctf/control_scripts/restart_script.sh  " >> /etc/sudoers
echo "Reto00 ALL=(root) NOPASSWD: /local/ctf/control_scripts/restart_script.sh" >> /etc/sudoers
echo "@includedir /etc/sudoers.d" >> /etc/sudoers

groupadd retos_grp

PAM_LINE="auth sufficient pam_succeed_if.so user ingroup retos_grp"
sed -i "1i $PAM_LINE" /etc/pam.d/su

# Usuario benvida ------------------------------------

reto="Reto00"

useradd -m "$reto"
adduser "$reto" retos_grp
chsh -s /bin/bash "$reto"

touch /home/$reto/.profile
echo "*******************************************************
                                                            
                BIENVENIDO AL LINUX_CTF_ARQPYB

  Las normas son muy sencillas: se irán generando retos con una
  dificultad acorde a tu nivel de habilidad y tendrás que encontrar
  en cada reto las banderas. Todas las banderas siguen la misma
  estructura: "ARQPYB-XxXxXxXxX".

  Para leer el reto, pon el comando "reto".
  Para validar una bandera, pon el comando "flag".
  Para reiniciar los niveles, pon el comando "restart".

  TIP: Recuerda que en los terminales linux copiar es CTRL-MAYUS-C
  y pegar es CTRL-MAYUS-V

  Ánimo y suerte, camarada. Cuando estés listo para empezar,
  escribe "rdy" en el terminal.
        
*******************************************************" > /home/$reto/.reto_es
echo "*******************************************************
                                                            
                WELCOME TO LINUX_CTF_ARQPYB

  The rules are very simple: challenges will be generated with a
  difficulty level corresponding to your skill, and you will have to find
  the flags in each challenge. All flags follow the same
  structure: "ARQPYB-XxXxXxXxX".

  To read the challenge, use the command "reto".
  To validate a flag, use the command "flag".
  To restart the levels, use the command "restart".

  TIP: Remember that in linux terminal, to copy you have to use
  CTRL-MAYUS-C and to paste CTRL-MAYUS-V

  Good luck and stay strong, comrade. When you're ready to start,
  type "rdy" in the terminal.
        
*******************************************************" > /home/$reto/.reto_en
echo "*******************************************************
                                                            
                BENVIDO AO LINUX_CTF_ARQPYB

  As normas son moi sinxelas: iranse xerando retos cunha
  dificultade acorde co teu nivel de habilidade e terás que atopar
  en cada reto as bandeiras. Todas as bandeiras seguen a mesma
  estrutura: "ARQPYB-XxXxXxXxX".

  Para ler o reto, pon o comando "reto".
  Para validar unha bandeira, pon o comando "flag".
  Para reiniciar os niveis, pon o comando "restart".

  TIP: Lembra que nos terminais linux copiar é CTRL-MAYUS-C
  e pegar é CTRL-MAYUS-V

  Ánimo e sorte, camarada. Cando esteas listo para comezar,
  escribe "rdy" no terminal.
        
*******************************************************" > /home/$reto/.reto_gl

#.PROFILE 
{
    # ALIAS
    echo "alias rdy='sudo /local/ctf/control_scripts/init_script.sh'"
    echo "alias restart='sudo /local/ctf/control_scripts/restart_script.sh'"
    echo "alias reto='sh -c \"echo \\\"\\e[35m\$(cat /home/$reto/.reto_\$(cat /etc/ctf_var/LANG))\\e[0m\\\"\"'"
    # HOME
    echo "export HOME=/home/$reto"
    echo "cd /home/$reto"
    # Prompt 
    echo "export PS1='\u\$ '"
    # Limpieza terminal
    echo "clear"
    echo "echo \"\033[35m\$(cat /home/$reto/.reto_\$(cat /etc/ctf_var/LANG))\033[0m\""
} >> "/home/$reto/.profile"

chown "$reto:$reto" "/home/$reto/.profile"

mkdir /etc/ctf_var/



