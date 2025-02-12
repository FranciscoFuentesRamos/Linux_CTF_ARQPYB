#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
##############################

ZIP_FILE="Linux_CTF_ARQPYB.zip"
DEST_DIR="/opt/Linux_CTF_ARQPYB"

mkdir -p "$DEST_DIR"
echo "Descomprimiendo $ZIP_FILE..."
TEMP_DIR=$(mktemp -d)
unzip -q "$ZIP_FILE" -d "$TEMP_DIR"
echo "Moviendo el contenido a $DEST_DIR..."
mv "$TEMP_DIR"/* "$DEST_DIR"
rm -rf "$TEMP_DIR"

echo "Descompresión y movimiento completados..."

###############################

docker load < /opt/Linux_CTF_ARQPYB/image/arqpyb_base.tar
docker run -it --name arqpyb_run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /opt/Linux_CTF_ARQPYB/ctf/:/local/ctf/  arqpyb_base > /dev/null 2>&1 

echo "Container cargado e iniciado..."

###############################

cp Linux_CTF_ARQPYB.desktop /usr/share/applications/Linux_CTF_ARQPYB.desktop

update-desktop-database /usr/share/applications/

echo "Instalación terminada."

exit 0