# Manual avanzado de uso de Linux_CTF_ARQPYB

En este manual se abordará una explicación detallada de cada uno de los directorios o  archivos y su uso dentro de la aplicación, al final del manual habrá una sección de "preguntas frecuentes" para abordar casuísticas concretas.

## Índice
- [Manual avanzado de uso de Linux\_CTF\_ARQPYB](#manual-avanzado-de-uso-de-linux_ctf_arqpyb)
  - [Índice](#índice)
  - [/ctf](#ctf)
    - [/blocks](#blocks)
    - [/control\_scripts](#control_scripts)
    - [/models](#models)
    - [/ui](#ui)
    - [/image](#image)
    - [/models](#models-1)
  - [FAQ](#faq)
    - [¿Cómo traducir a otro idioma?](#cómo-traducir-a-otro-idioma)
    - [¿Cómo añadir retos?](#cómo-añadir-retos)
    - [¿Cómo probar cambios en Linux?](#cómo-probar-cambios-en-linux)
  


## /ctf<a name="ctf"></a>

El directorio /ctf es el directorio "core" de la aplicación, en este directorio se engloba toda la lógica del entorno, la generación de retos, interfaz ... 
Cuando se [genera la imagen](#image) y se inicia el container, toda esta carpeta queda compartida con el contenedor, los siguientes capítulos tratarán con más detalle que labor hace cada uno de sus directorios.

### /blocks<a name="blocks"></a>

En este directorio es donde se supone que deben ir localizados los scripts generadores de retos organizados por bloques (en este caso B1 y B2).
Dentro de cada uno de sus carpetas tenemos los scripts referentes a cada bloque, sus nombre **TIENEN QUE** seguir la siguiente estructura:

`{Nº Bloque}_{Dificultad}_{Nº}`

Los scripts generadores de retos deben ir clasificados en una de las 3 dificultades definidas (fácil, inter y hard), y cada uno debe diferenciarse a través del último número.

Los scripts de genereación de reto van a recibir siempre 2 variables de entrada:
- $1 será el nombre del Reto en el cual se van a ejecutar
- $2 es la flag generada

Ambas variables se pasan a través del [script de transición](#control_scripts) las cuales se generan en el propio script. Los scripts de generación siguen la siguiente estructura; encabezado, enunciado y cuerpo.

- **Encabezado**: Común a todos los retos, en este simplemente se define la autoría del script y se sitúa en el directorio **/home/$1**.
- **Enunciado**: El enunciado del reto se guarda en el archivo **.reto_{código_idioma}**, generándose uno por cada idioma. Dentro del enunciado se recomienda incluir la descripción del reto y una serie de comandos sugeridos.
- **Cuerpo**: La parte del script encargada de ocultar la bandera ($2) conforme al enunciado.

El script siempre se ejecuta como usuario root y se elimina del directorio nativo /ctf al ejecutarse (para evitar duplicidades). El original se mantiene en la carpeta compartida en /local/ctf, desde donde se copian a partir del script de reinicio.

### /control_scripts<a name="control_scripts"></a>

Los scripts de control son el núcleo de todo el entorno. Se encargan de orquestar el resto de scripts; a continuación, se analizará el funcionamiento de cada uno:

- **init_script**: Una vez creada la imagen y desde el Reto00 (el hub), se inicia este script. Primero, plantea un diálogo en función del idioma vigente en la interfaz. De este diálogo se deben obtener tres datos: Bloques, Retos e Intro. A continuación, se aplica la siguiente fórmula:
  `Nº Bloques × Nº Niveles + Nº Bloques × Nivel Introductorio = Nº Usuarios`, y se crean las carcasas vacías de los retos, es decir, se generan usuarios "vacíos" (sin ningún reto generado), con alias, un cat del enunciado al iniciar sesión, el directorio /home definido, entre otros. Finalmente, se genera el primer reto y se inicia sesión en él.
- **print**: Este script se encarga de imprimir los resultados de los retos al completarlos todos. Se activa a partir del trans_script. Simplemente lee el contenido de **/etc/ctf_var/results.csv** y muestra los datos de manera legible y traducida al idioma de la interfaz.
- **restart_script**: Este script reinicia toda la estructura creada por init_script. Primero, inicia un diálogo para confirmar si se desea reiniciar y, a continuación, elimina los usuarios creados y todas las variables en **/etc/ctf_var** (excepto LANG). Finalmente, se vuelve a iniciar sesión en Reto00.
- **selection_script**: Este script es un anexo de trans_script. Es el único script en Python y se encarga de interpretar los resultados del reto (calcular el tiempo total de ejecución y el número de comandos empleados). Aplica un modelo previamente generado en [models](#models-1) y almacenado en la carpeta [models en ctf](#models). Se utilizará el modelo acorde con la dificultad, y estos modelos determinarán si el nivel sube, baja o se mantiene. En función del resultado, el script calcula y devuelve la nueva dificultad (fácil, intermedio o difícil).
- **trans_script**: Este script gestiona la transición entre retos, detecta cambios de bloque y determina el final del conjunto de retos. En primer lugar, carga las variables almacenadas en **/etc/ctf_var** y las modifica según sea necesario (las variables funcionan como contadores para determinar cuándo cambiar de bloque o finalizar). En caso de que la flag sea incorrecta o vacía, imprimirá un mensaje de error acorde con el idioma de la interfaz. Si el reto ya fue completado previamente, simplemente iniciará sesión en el siguiente reto. Si la flag es correcta, se aumentarán los contadores según la lógica establecida y se guardarán los datos de desempeño en **results.csv**. Si la sesión finaliza, se imprimirá **results.csv** a través de **print.sh**. Luego, se generará una nueva flag y su hash se almacenará en **/etc/ctf_var/flag**. Se ejecutará **selection_script** para determinar la nueva dificultad del siguiente reto y se seleccionará aleatoriamente un script que coincida con el bloque y la dificultad correspondiente. Finalmente, se eliminará el script del directorio local en **/ctf** y se iniciará sesión en el siguiente reto.

### /models<a name="models_ctf"></a>

En **models** simplemente se almacenan los modelos generados previamente en [/models](#models-1).

### /ui<a name="ui"></a>

Dentro de **ui** hay una carpeta con distintas versiones del logo y la interfaz en GTK Python. Esta interfaz se inicia por defecto al levantar el contenedor y cuenta con varias funciones:
- Habilitar una terminal mediante VTE para interactuar con el CTF. Se trata de una interfaz asíncrona de VTE con colores definidos manualmente, por lo que puede no seguir el código estándar de colores de Bash.
- Un menú lateral donde se muestra el logo y varios botones para facilitar tareas como iniciar sesión en diferentes usuarios, entre otras.
- Un menú superior con un desplegable para cambiar el idioma, afectando tanto a la interfaz como al archivo **/etc/ctf_var/LANG**, que se actualiza con el código del idioma correspondiente.

### /image<a name="image"></a>

Dentro del directorio **image** hay tres archivos: **arqpyb_base.tar**, **setup_.sh** y **Dockerfile**.

- **arqpyb_base.tar**: Es la imagen guardada generada a través del Dockerfile. Contiene la estructura base del entorno con el usuario Reto00 creado.
- **Dockerfile**: Archivo utilizado para generar la imagen base del proyecto. En él se instalan en Ubuntu los paquetes necesarios de Python y otras bibliotecas esenciales. Luego, ejecuta **setup_.sh** para organizar la estructura de la imagen y los usuarios. Finalmente, define en CMD la ejecución de la interfaz.
- **setup_.sh**: Script que configura el sistema. Incluye reglas en sudoers para que los usuarios **Reto** no necesiten contraseña al ejecutar los scripts de control. Crea un grupo **retos_grp** y evita la solicitud de contraseña al cambiar entre usuarios del mismo grupo mediante **pam.d**. Además, configura el usuario **Reto00** con sus alias y enunciados. Finalmente, crea el directorio **/etc/ctf_var**.

### /models<a name="models"></a>

Este directorio está diseñado para generar modelos. Los dos elementos clave son **model_trainer.py** y **train.csv**.
- **train.csv**: Archivo con los datos de desarrollo que se utilizarán para entrenar el modelo.
- **model_trainer.py**: Entrena un modelo de regresión logística para cada dificultad (fácil, intermedio y difícil). También genera gráficos y reportes en las carpetas correspondientes. Finalmente, los modelos se exportan con **joblib** al directorio **modelos**. Para aplicarlos, deben moverse a **/ctf/models**.

## FAQ<a name="faq"></a>

### ¿Cómo traducir a otro idioma?

Para traducir el proyecto a otro idioma:
1. En **ui.py**, define un nuevo idioma en los botones y traduce su contenido.
2. Cada vez que se cambie de idioma, la interfaz ejecutará `echo $lang > /etc/ctf_var/LANG`.
3. En los scripts de control en shell, agrega una nueva entrada en los casos de traducción.
4. En cada reto dentro de **/ctf/blocks**, crea un nuevo enunciado en **.reto_$lang**.

### ¿Cómo añadir retos?

1. Crea un nuevo script en un bloque siguiendo la estructura **{NºBloque}\_{Dificultad}\_{Nº}**.
2. Asegúrate de que sea compatible con **/bin/sh** y esté traducido a los idiomas base.
3. Respeta la estructura de otros scripts, usando `$1` para el usuario Reto y `$2` para la flag.

### ¿Cómo probar cambios en Linux?

Ejecuta:
~~~
docker build -t arqpyb_base image && docker save -o image/arqpyb_base.tar arqpyb_base
xhost +local:
docker run -it --name arqpyb_run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd)/ctf:/local/ctf/ arqpyb_base
~~~

