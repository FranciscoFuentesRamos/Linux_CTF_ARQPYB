#!/bin/sh


# Nome do proxecto: Linux_CTF_ARQPYB
# Copyright (c) 2025 Chuten
# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).
 
# Colores ANSI
RED="$(printf '\033[96m')"
GREEN="$(printf '\033[91m')"
YELLOW="$(printf '\033[97m')"
RESET="$(printf '\033[0m')"

# Archivos de configuración
NIVELES_FILE="/etc/ctf_var/NIVELES"
BLOQUES_FILE="/etc/ctf_var/BLOQUES"

# Obtener idioma desde archivo o usar predeterminado
LANG_FILE="/local/ctf/temp/LANG"
if [ -f "$LANG_FILE" ]; then
    LANG=$(cat "$LANG_FILE" | tr -d '[:space:]')
else
    LANG="gl" # Idioma por defecto
fi

# Traducciones según el idioma
case "$LANG" in
    "es")
        MESSAGE="¡ Enhorabuena !, has terminado todos los retos :3
        Aqui tienes tus resultados, recuerda que puedes reiniciar el progreso escribiendo \"restart\"\n"
        HEADER1="Reto"
        HEADER2="Duracion (s)"
        HEADER3="Comandos"
        HEADER4="Dificultad"
        DIFF_EASY="facil"
        DIFF_MEDIUM="inter"
        DIFF_HARD="dificil"
        ;;
    "en")
        MESSAGE="Congratulations! You have completed all the challenges :3
        Here are your results. Remember, you can reset your progress by typing \"restart\"\n"
        HEADER1="Challenge"
        HEADER2="Duration (s)"
        HEADER3="Commands"
        HEADER4="Difficulty"
        DIFF_EASY="easy"
        DIFF_MEDIUM="medium"
        DIFF_HARD="hard"
        ;;
    "gl")
        MESSAGE="Noraboa !, remataches tódolos retos :3
        Aqui tes os teus resultados, lembra que podes reiniciar o progreso escribindo \"restart\"\n"
        HEADER1="Reto"
        HEADER2="Duración  (s )"
        HEADER3="Comandos"
        HEADER4="Dificultade"
        DIFF_EASY="sinxela"
        DIFF_MEDIUM="intermedia"
        DIFF_HARD="difícil"
        ;;
    *)
        echo "Idioma no soportado: $LANG"
        exit 1
        ;;
esac

# Leer niveles y bloques desde los archivos
if [ -f "$NIVELES_FILE" ]; then
    NIVELES=$(cat "$NIVELES_FILE" | tr -d '[:space:]')
else
    echo "Error: Archivo '$NIVELES_FILE' no encontrado."
    exit 1
fi

if [ -f "$BLOQUES_FILE" ]; then
    BLOQUES=$(cat "$BLOQUES_FILE" | tr -d '[:space:]')
else
    echo "Error: Archivo '$BLOQUES_FILE' no encontrado."
    exit 1
fi

# Función para calcular la diferencia de tiempo en segundos
calculate_seconds() {
    start_time=$(date -d "$1" +%s)
    end_time=$(date -d "$2" +%s)
    echo $((end_time - start_time))
}

# Función para traducir y decorar dificultad
decorate_difficulty() {
    difficulty=$1
    case "$difficulty" in
        facil) echo "${GREEN}${DIFF_EASY}${RESET}" ;;
        inter) echo "${YELLOW}${DIFF_MEDIUM}${RESET}" ;;
        hard) echo "${RED}${DIFF_HARD}${RESET}" ;;
        *) echo "$difficulty" ;;
    esac
}

# Generar etiquetas B1-1, B1-2... B2-1, B2-2, ...
generate_labels() {
    labels=""
    for bloque in $(echo "$BLOQUES" | tr ',' ' '); do
        for nivel in $(seq 1 "$NIVELES"); do
            labels="$labels B${bloque}-${nivel}"
        done
    done
    echo "$labels"
}

LABELS=$(generate_labels)
LABELS_ARRAY=$(echo "$LABELS" | tr ' ' '\n')

# Leer archivo CSV y generar tabla
process_csv() {
    input_file=$1
    label_index=0

    if [ ! -f "$input_file" ]; then
        echo "El archivo '$input_file' no existe o no es accesible."
        exit 1
    fi

    # Encabezado de la tabla
    printf "+--------------------+--------------------+--------------------+--------------------+\n"
    printf "| %-18s | %-18s | %-18s | %-18s \n" "$HEADER1" "$HEADER2" "$HEADER3" "$HEADER4"
    printf "+--------------------+--------------------+--------------------+--------------------+\n"

    label_index=1
    # Leer línea por línea el archivo CSV
    while IFS=';' read -r start_time end_time difficulty commands || [ -n "$start_time" ]; do
        # Calcular duración en segundos
        duration=$(calculate_seconds "$start_time" "$end_time")

        # Traducir y decorar dificultad
        decorated_difficulty=$(decorate_difficulty "$difficulty")

        # Obtener etiqueta de nivel (revisado)
        label=$(echo "$LABELS_ARRAY" | sed -n "$((label_index + 1))p")

        # Imprimir la fila formateada
        printf "| %-18s | %-18s | %-18s | %-18s \n" \
            "$label" "$duration" "$commands" "$decorated_difficulty"

        # Incrementar label_index
        label_index=$((label_index + 1))
    done < "$input_file"

    # Línea final de la tabla
    printf "+--------------------+--------------------+--------------------+--------------------+\n"

    printf "\n$MESSAGE\n"
}

# Verificar argumentos
if [ $# -ne 1 ]; then
    echo "Uso: $0 archivo.csv"
    exit 1
fi

# Procesar archivo CSV
process_csv "$1"
