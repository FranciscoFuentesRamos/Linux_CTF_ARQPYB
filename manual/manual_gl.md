# Manual avanzado de uso de Linux_CTF_ARQPYB

Neste manual abordaráse unha explicación detallada de cada un dos directorios ou arquivos e o seu uso dentro de todo o aplicativo, ao final do manual haberá unha sección de "preguntas frecuentes" para abordar casuísticas concretas.

## Índice
- [Manual avanzado de uso de Linux\_CTF\_ARQPYB](#manual-avanzado-de-uso-de-linux_ctf_arqpyb)
  - [Índice](#índice)
  - [/ctf](#ctf)
    - [/blocks](#blocks)
    - [/control\_scripts](#control_scripts)
    - [/models](#models)
    - [/ui](#ui)
  - [/Image](#image)
  - [/Models](#models-1)
  - [FAQ ](#faq-)
    - [Como podo traducir a outro idioma?](#como-podo-traducir-a-outro-idioma)
    - [Como podo engadir retos ?](#como-podo-engadir-retos-)
    - [Como podo engadir bloques ?](#como-podo-engadir-bloques-)
    - [Como podo debuguear en linux?](#como-podo-debuguear-en-linux)
  


## /ctf<a name="ctf"></a>

O directorio CTF é o directorio core do aplicativo, neste directorio englobamos toda a lóxica da contorna, scripts de control, a xeración do reto, a interface ... 
Cando se [xera a imaxe](#image) e se inicia o container, toda esta carpeta queda compartida co contedor, os seguintes capítulos tratarán con máis detalle que labor fai cada un dos seus directorios.

### /blocks<a name="blocks"></a>

Neste directorio é onde se supón que deben ir localizados os scripts xeradores de retos organizados por bloques (neste caso B1 e B2). 
Dentro de cada un das súas carpetas temos os scripts referentes a cada bloque, os seus nomes **TEÑEN** que seguir a seguinte estructura:

`{Nº Bloque}_{Dificultade}_{Nº}`

Os scripts xeradores de retos deben ir clasificados en unha das 3 dificultades definidas ( facil, inter e hard), e cada un diferenciarse a través do último número. 

Os scripts de xeración de reto van recibir sempre 2 variables: 
- $1 será o nome do Reto no cal se vai executar o reto
- $2 é a flag xerada

Ambas variables se pasan a través do [script de transición](#control_scripts) as cales se xerán no script propiamente. 
Os scripts de xeración seguen a seguinte estrutura; encabezado, enunciado e corpo.

- Encabezado : común a todos os retos, neste simplemente defínese a autoría do script, e situase no directorio **/home/$1**
- Enunciado : o enunciado do reto gárdase no arquivo **.reto_{código idioma}**, xérase un por cada idioma, dentro do enunciado recomendase poñer o enunciado e unha serie de comandos recomendados.
- Corpo :  a parte do script encargada de agochar a bandeira ($2) conforme o enunciado

O script execútase sempre como usuario root, e bórrase do directorio nativo /ctf ao executarse (para evitar duplicidade). O orixinal segue na carpoeta compartida en /local/ctf, dende onde se copian a partires do script de reinicio.

### /control_scripts<a name="control_scripts"></a>

Os scripts de control son o corazón de toda a contorna, son os encargados de orquestrar o resto de scripts; a continuación analizaránse un por un o seu funcionamiento:

- **init_script** : unha vez creada a imaxe e dende o Reto00 (o hub) iniciase este script, primeiro plantexa un diálogo en función do idioma vixente na interface. Deste diálogo teñense que sacar 3 datos, Bloques, Retos e Intro. A continuación aplícase a seguinte fórmula `Nº Bloques × Nº Niveles + Nº Bloques × Nivel Introdutorio = Nº Usuarios `, e creanse as carcasas vacías dos retos, é dicir, xéranse usuarios "vacíos" (sen ningún reto xerado), con alias, un cat do enunciado ao logearse, o directorio /home definido, e demases. Finalmente xérase o primeiro reto e loguease neste.
- **print** : este script é o encargado de imprimir os resultados dos retos ao rematalos todos, actívase a partires do trans_script. O script simplemente lee o contido de /etc/ctf_var/results.csv e imprime os datos de manera lexible e traducida ao idioma da interface.
- **restart_script**: este script é o encargado de reiniciar toda a estrutura levantada por init_script, simplemente inicia un dialogo para confirmar que se quere reiniciar e a continuación borranse os usuarios creados e todas as variables creadas en /etc/ctf_var (menos LANG). Finalmente loguease de volta a Reto00.
- **selection_script** este script é un anexo do trans_script, é o único script en python máis é o encargado de interpretar os resultados do Reto (calcular o tempo total de execución e o número de comandos empregados), aplicará un modelo, previamente xerado en [models](#models-1) e gardado na carpeta [models en ctf](#models), e usaráse o modelo acorde coa dificultade, estes modelos devolverán se suben baixan o mantñen o nivel, en función do resultado o script calcula e devolve a nova dificultade (facil, inter ou hard).
- **trans_script** : este script é o encargado de transicionar entre retos, detectar os cambios de bloques e o remate do conxunto de retos, por partes, o primeiro que fai é cargar as variables alocadas en /etc/ctf_var, e modificaas conforme considere (as variables serven a modo de contador para saber cando hai que cambair de bloque ou rematar). En caso de a flag ser incorrecta, vacía simplemente imprimirá un mensaxe de erro acorde ao idioma da interface. En caso de que o reto xa fora completado con anterioridade, simplemente logueará no reto seguinte. Finalmente, no caso de que o reto sexa o "actual" e a flag sexa correcta, aumentaránse os contadores acorde á loxica establecida e gardaríanse os datos de desempeño no reto en results.csv, se a run remata, imprimirase por pantalla os results.csv a través de print.sh. A continuación xerarase unha nova flag e o seu hash gardarase en /etc/ctf_var/flag, executase o selection_script para saber que nova dificultade lle corresponde ao novo reto e seleccionase aleatoriamente un script que sega o bloque correspondente e a dificultade, borrase o script do directorio local en /ctf e logueariase no seguinte reto.

### /models<a name="models_ctf"></a>

En models simplemente gárdanse os modelos xerados previamente en [/models](#models-1).

### /ui<a name="ui"></a>

En ui existe unha carpeta con distintas versións do logo e a interface en GTK python, esta interface arráncase por defecto ao levantar o container e ten varias funcións:
- Habilitar unha terminal a través de VTE coa que poder interactuar co CTF, trátase dunha interface asíncrona de VTE e coas cores definidas manualmente, polo que pode non seguir o código estandar de cores con respecto a bash
- Un menú lateral no cal se amosa o logo, e varios botóns para poder facilitar ao usuario final realizar varias labores como por exemplo loguearse a varios usuarios etc...
- No menú superior hai un despregabre para cambiar o idioma, este cambio afecta á interface e tamén reescribe o contido de /etc/ctf_var/LANG ao código de idioma correspondente.

## /Image<a name="image"></a>

Dentro do directorio image teríamos 3 arquivos: arqpyb_base.tar, setup_.sh e Dockerfile:

- arqpyb_base.tar :  e a imaxe gardada xerada a través do Dockerfile, ésta contén a estrutura base de toda a contorna, co usuario Reto00 creado.
- Dockerfile : é o arquivo usado para xerar a imaxe base do proxecto, neste instálanse nun ubuntu os paquetes necesarios de python e librarías para facer funcionar o proxecto así como outros. A contiunuación executase setup_.sh para xerar e organizar os aspectos xerais da imaxe e os usuarios. Finalmente definimos no CMD a execución da interface.
- setup_.sh : é o script no cal se delegan todas as labores de configuración do sistema, neste incluénse no sudoers varias regras para os usuarios Reto non solicitarlles o contrasinal de sudo cando executan os scripts de control, crease un grupo retos_grp e non se solicita contrasinal para pasar entre usuarios do mesmo grupo dentro de retos_grp grazas ao pam.d. Ademáis configurase o usuario Reto00, cos seus alias e enunciados. Finalmente creanse o directorio /ect/ctf_var.

## /Models<a name="Models"></a>

Esta carpeta está deseñada para xerar os modelos en función os 2 elementos importantes son model_trainer.py e train.csv.
- train.csv é o arquivo cos datos de desenvolvemento que van ser usados para entrenar o modelo.
- model_trainer.py será o encargado en entrenar un modelo de regresión loxística por cada unha das dificultades especificadas (facil, inter e hard), además xerará graficas e reportes nas carpetas correspondentes, finalmente os modelos exportaránse con joblib á carpeta modelos, estes modelos de ser aplicados deben ser movidos a /ctf/models.

## FAQ <a name="faq"></a>

### Como podo traducir a outro idioma?

Traducir a outro idioma o proxecto é doado de facer primeiro dentro da ui.py nos botóns terás que definir un novo idioma e traducir os contido dos botóns. Usa o código de idioma correspondente.
Ao traducir a interfaz, cada vez que cambies de idioma a interface fará un `echo $lang > /etc/ctf_var/LANG` a continuación terás que nos scripts de control en shell crear unha nova entrada nos cases de traducción, finalmente en cada un dos retos de `/ctf/blocks` terás que crear un novo enunciado para gardalo no arquivo `.reto_$lang`.

### Como podo engadir retos ?

É tan doado como crear un novo script nalgún dos bloques e respectar a estrutura anterior, {NºBloque}\_{Dificultade}\_{Nº}, por exemplo se para o bloque 1 fas un novo reto que considerás que é dificil debes engadilo á carpeta do proxecto en `ctf/blocks/B1/B1_hard_6.sh`.
Este script debería ser compatible con /bin/sh, traducido aos idiomas base (inglés, castelán e galego) e respetar a estrutura marcada polos outros scripts, en $1 iría o usuario Reto e $2 a flag, o enunciado chamaríase .reto_\$lang ...

### Como podo engadir bloques ? 

Para engadir bloques debes crear unha carpeta dentro de ctf/blocks (B3 por exemplo) e dotalo de algúns scripts para xerar retos.
A continuación en control_scripts/ debes modificar o dialogo que pregunta polos bloques e engadir os números de bloques que crees, neste caso engadir o 3.

### Como podo debuguear en linux? 

Se necesitas probar os cambios de forma rápida e doada é tan sinxelo como montar o contedor docker dende a carpeta raíz desta contorna con:
~~~
docker build -t arqpyb_base image && docker save -o image/arqpyb_base.tar arqpyb_base
~~~
Este comando montará o container e o gardará de forma local como `arqpyb_base.tar`, a continuación terás que activar o xhost:
~~~
xhost +local:
~~~
E finalmente cargar o container poñendo de carpeta compartida o directorio dende o que estás traballando, esto permitirá ver os cambios reflexados inmediatamente no contedor:
~~~
docker run -it --name arqpyb_run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd)/ctf:/local/ctf/  arqpyb_base
~~~