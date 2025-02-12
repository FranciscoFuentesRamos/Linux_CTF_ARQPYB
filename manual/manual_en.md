# Advanced Manual for Linux_CTF_ARQPYB Usage

This manual provides a detailed explanation of each directory or file and its usage within the application. At the end of the manual, there will be a "Frequently Asked Questions" section to address specific cases.

## Index
- [Advanced Manual for Linux\_CTF\_ARQPYB Usage](#advanced-manual-for-linux_ctf_arqpyb-usage)
  - [Index](#index)
  - [/ctf](#ctf)
    - [/blocks](#blocks)
    - [/control\_scripts](#control_scripts)
    - [/models](#models)
    - [/ui](#ui)
    - [/image](#image)
    - [FAQ](#faq)
      - [How to translate to another language?](#how-to-translate-to-another-language)
      - [How to add challenges?](#how-to-add-challenges)
      - [How to test changes in Linux?](#how-to-test-changes-in-linux)

## /ctf<a name="ctf"></a>

The /ctf directory is the "core" directory of the application. This directory encompasses all the logic of the environment, challenge generation, interface, etc.
When the [image is generated](#image) and the container is started, this entire folder is shared with the container. The following chapters will detail the role of each of its directories.

### /blocks<a name="blocks"></a>

This directory is where challenge-generating scripts should be located, organized by blocks (in this case, B1 and B2).
Within each of their folders, we have scripts related to each block. Their names **MUST** follow this structure:

`{Block Number}_{Difficulty}_{Number}`

The challenge-generating scripts must be classified into one of the three defined difficulties (easy, intermediate, and hard), and each one must be distinguished by the last number.

The challenge generation scripts will always receive 2 input variables:
- $1 will be the name of the Challenge in which they will be executed
- $2 is the generated flag

Both variables are passed through the [transition script](#control_scripts), which generates them within the script itself. The generation scripts follow this structure: header, statement, and body.

- **Header**: Common to all challenges, it simply defines the script's authorship and places it in the **/home/$1** directory.
- **Statement**: The challenge statement is stored in the file **.challenge_{language_code}**, generating one per language. The statement should include the challenge description and a series of suggested commands.
- **Body**: The part of the script responsible for hiding the flag ($2) according to the statement.

The script always runs as the root user and is removed from the native /ctf directory upon execution (to avoid duplication). The original is maintained in the shared folder at /local/ctf, from where it is copied via the restart script.

### /control_scripts<a name="control_scripts"></a>

Control scripts are the core of the entire environment. They orchestrate the other scripts; below is an analysis of each one's functionality:

- **init_script**: Once the image is created and from Challenge00 (the hub), this script is started. First, it presents a dialogue based on the interface's current language. Three data points must be obtained from this dialogue: Blocks, Challenges, and Intro. Then, the following formula is applied:
  `Number of Blocks × Number of Levels + Number of Blocks × Introductory Level = Number of Users`, and the empty challenge shells are created, meaning "empty" users (without any generated challenges) are created with aliases, a cat of the statement upon login, the defined /home directory, among others. Finally, the first challenge is generated, and login is initiated.
- **print**: This script prints the results of the challenges once all are completed. It is triggered by trans_script. It simply reads the contents of **/etc/ctf_var/results.csv** and displays the data in a readable format translated to the interface's language.
- **restart_script**: This script resets the entire structure created by init_script. First, it starts a dialogue to confirm whether a reset is desired, then deletes the created users and all variables in **/etc/ctf_var** (except LANG). Finally, it logs back into Challenge00.
- **selection_script**: This script is an annex to trans_script. It is the only Python script and is responsible for interpreting challenge results (calculating total execution time and the number of commands used). It applies a pre-generated model from [models](#models-1) stored in the [models in ctf](#models) folder. The appropriate model for the difficulty level will be used, and these models will determine whether the level goes up, down, or stays the same. Based on the result, the script calculates and returns the new difficulty (easy, intermediate, or hard).
- **trans_script**: This script manages the transition between challenges, detects block changes, and determines the end of the challenge set. First, it loads stored variables from **/etc/ctf_var** and modifies them as needed (the variables function as counters to determine when to change blocks or finish). If the flag is incorrect or empty, it prints an error message according to the interface's language. If the challenge was previously completed, it simply logs into the next challenge. If the flag is correct, counters increase as per the established logic, and performance data is stored in **results.csv**. If the session ends, **results.csv** is printed via **print.sh**. Then, a new flag is generated, and its hash is stored in **/etc/ctf_var/flag**. **selection_script** is executed to determine the next challenge's difficulty, and a script matching the block and corresponding difficulty is randomly selected. Finally, the script is deleted from the local directory in **/ctf**, and the next challenge session is started.

### /models<a name="models_ctf"></a>

In **models**, previously generated models from [/models](#models-1) are stored.

### /ui<a name="ui"></a>

Inside **ui**, there is a folder with different logo versions and the interface in GTK Python. This interface starts by default when the container is launched and includes several functions:
- Enables a terminal via VTE for interacting with the CTF. This is an asynchronous VTE interface with manually defined colors, which may not follow Bash's standard color scheme.
- A side menu displaying the logo and several buttons for facilitating tasks such as logging into different users.
- A top menu with a dropdown to change the language, affecting both the interface and the **/etc/ctf_var/LANG** file, which updates with the corresponding language code.

### /image<a name="image"></a>

The **image** directory contains three files: **arqpyb_base.tar**, **setup_.sh**, and **Dockerfile**.

### FAQ<a name="faq"></a>

#### How to translate to another language?
1. In **ui.py**, define a new language in the buttons and translate its content.
2. Every time the language is changed, the interface executes `echo $lang > /etc/ctf_var/LANG`.
3. In the shell control scripts, add a new entry in the translation cases.
4. In each challenge within **/ctf/blocks**, create a new statement in **.challenge_$lang**.

#### How to add challenges?
1. Create a new script in a block following the structure **{BlockNumber}_{Difficulty}_{Number}**.
2. Ensure it is compatible with **/bin/sh** and translated into the base languages.
3. Follow the structure of other scripts, using `$1` for the Challenge user and `$2` for the flag.

#### How to test changes in Linux?
~~~
docker build -t arqpyb_base image && docker save -o image/arqpyb_base.tar arqpyb_base
xhost +local:
docker run -it --name arqpyb_run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd)/ctf:/local/ctf/ arqpyb_base
~~~

