# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 

# Ejecutar: docker build -t arqpyb_base image && docker save -o image/arqpyb_base.tar arqpyb_base

FROM ubuntu:24.04 

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV TZ=Europe/Madrid

# Instalar dependencias básicas
RUN apt-get update && apt-get install -y --no-install-recommends\
    python3 \
    python3-pip \
    python3-gi \
    python3-gi-cairo \
    python3-joblib \ 
    python3-pandas \ 
    python3-sklearn \ 
    gir1.2-gtk-3.0 \
    gir1.2-vte-2.91 \
    x11-apps \
    libx11-dev \
    libgtk-3-dev \
    sudo \
    perl \
    gnome-themes-extra \
    && rm -rf /var/lib/apt/lists/*

#RUN apk add mandoc coreutils-doc findutils-doc util-linux-doc sed-doc grep-doc mawk-doc

# Ejecuta el setup

COPY setup_.sh /setup_.sh
RUN chmod +x /setup_.sh && /setup_.sh
RUN rm /setup_.sh
# RUN unminimize

CMD ["python3", "/local/ctf/ui/ui.py"]
