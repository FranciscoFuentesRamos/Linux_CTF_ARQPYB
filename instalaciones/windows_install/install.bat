@echo off


::# Nome do proxecto: Linux_CTF_ARQPYB
::# Copyright (c) 2025 Chuten
::# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).

setlocal

:: Verificar si Docker está instalado
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Docker no está instalado o no está en el PATH. Abortando...
    pause
    exit /b
)

:: Iniciar Docker Desktop
start /wait "" "C:\ProgramData\Microsoft\Windows\Start Menu\Docker Desktop.lnk"

:: Comprobar si se está ejecutando con permisos de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Este script necesita permisos de administrador. Solicitando elevación...
    :: Reiniciar el script con privilegios de administrador
    powershell -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

:: Código con permisos de administrador continúa aquí
echo Ejecutando con permisos de administrador...

:: Obtener la ruta de la carpeta "Documentos" del usuario
for /f "tokens=*" %%A in ('powershell -Command "[System.Environment]::GetFolderPath('MyDocuments')"') do set "USER_DOCS=%%A"
set "DEST_DIR=%USER_DOCS%\Linux_CTF_ARQPYB"

:: Crear el directorio de destino si no existe
if not exist "%DEST_DIR%" (
    echo Creando el directorio "%DEST_DIR%"...
    mkdir "%DEST_DIR%"
)

:: Configurar la ruta absoluta del archivo ZIP
set "ZIP_FILE=%~dp0Linux_CTF_ARQPYB.zip"

:: Verificar si el archivo ZIP existe
if not exist "%ZIP_FILE%" (
    echo El archivo %ZIP_FILE% no existe. Abortando...
    pause
    exit /b
)

:: Descomprimir el archivo ZIP directamente en el directorio de destino
echo Descomprimiendo %ZIP_FILE% en %DEST_DIR%...
powershell -NoProfile -Command ^
    "try { Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%DEST_DIR%' -Force } catch { Write-Error 'Error descomprimiendo el archivo ZIP.'; exit 1 }"

if errorlevel 1 (
    echo Ocurrió un error al descomprimir el archivo. Abortando...
    pause
    exit /b
)

echo Descompresión completada exitosamente.



:: ================================================================
:: ================================================================

:: Ruta al archivo tar dentro de Documentos
set "TAR_FILE=%DEST_DIR%\image\arqpyb_base.tar"

:: Verificar si el archivo tar existe
if not exist "%TAR_FILE%" (
    echo El archivo tar "%TAR_FILE%" no existe. Abortando...
    pause
    exit /b
)

:: Cargar la imagen de Docker
echo Cargando la imagen de Docker desde "%TAR_FILE%"...
docker load -i "%TAR_FILE%" >nul 2>&1
if %errorlevel% neq 0 (
    echo Error al cargar la imagen de Docker. Abortando...
    pause
    exit /b
)
:: Ejecutar el contenedor Docker
echo Ejecutando el contenedor Docker...

docker run -it --name arqpyb_run ^
    -e DISPLAY=host.docker.internal:0 ^
    -e XDG_RUNTIME_DIR=/tmp/runtime-docker ^
    -v "/tmp/runtime-docker:/tmp/runtime-docker" ^
    -v "%DEST_DIR%\ctf:/local/ctf/" ^
    arqpyb_base

echo Contenedor Docker ejecutado.

:: ================================================================
:: ================================================================

for /f "tokens=*" %%A in ('powershell -Command "[System.Environment]::GetFolderPath('Desktop')"') do set "USER_DESKTOP=%%A"

:: Ruta al archivo .lnk en la misma carpeta que el script
set "SOURCE_LNK=%~dp0Linux_CTF_ARQPYB.lnk"

:: Verificar si el archivo .lnk existe
if not exist "%SOURCE_LNK%" (
    echo El archivo "%SOURCE_LNK%" no existe. Abortando...
    pause
    exit /b
)

:: Copiar el acceso directo al escritorio
echo Copiando "%SOURCE_LNK%" al escritorio "%USER_DESKTOP%"...
copy "%SOURCE_LNK%" "%USER_DESKTOP%" >nul

if %errorlevel% equ 0 (
    echo Copia completada correctamente.
) else (
    echo Ocurrió un error al copiar el archivo.
)

echo Acceso directo al Linux_CTF_ARQPYB creado.
echo Finalizada la instalación.