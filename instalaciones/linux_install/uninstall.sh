#!/bin/sh

# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).

rm -rf /opt/Linux_CTF_ARQPYB
rm /usr/share/applications/Linux_CTF_ARQPYB.desktop
docker rm -f arqpyb_run
docker rmi -f arqpyb_base