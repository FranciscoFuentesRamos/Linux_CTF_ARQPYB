@echo off
::# Nome do proxecto: Linux_CTF_ARQPYB
::# Copyright (c) 2025 Chuten
::# Este software distribuese baixo a Licencia Creative Commons BY-NC (ver arquivo LICENSE para máis detalles).

:: Comprobar si se está ejecutando con permisos de administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Este script necesita permisos de administrador. Solicitando elevación...
    :: Reiniciar el script con privilegios de administrador
    powershell -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

start /wait "" "C:\ProgramData\Microsoft\Windows\Start Menu\Docker Desktop.lnk"

:: Código con permisos de administrador continúa aquí
echo Ejecutando con permisos de administrador...

:: Obtener la ruta de la carpeta "Documentos" independientemente del idioma
for /f "tokens=*" %%A in ('powershell -Command "[System.Environment]::GetFolderPath('MyDocuments')"') do set "USER_DOCS=%%A"
set "DEST_DIR=%USER_DOCS%\Linux_CTF_ARQPYB"

:: Verificar si la carpeta existe
if exist "%DEST_DIR%" (
    echo Eliminando la carpeta "%DEST_DIR%"...
    rmdir /s /q "%DEST_DIR%"
    if %errorlevel% equ 0 (
        echo Carpeta eliminada correctamente.
    ) else (
        echo Ocurrió un error al eliminar la carpeta.
    )
) else (
    echo No se encontró la carpeta "%DEST_DIR%".
)

:: Detener y eliminar contenedores Docker creados
echo Eliminando contenedores Docker relacionados...
docker ps -a --filter "name=arqpyb_run" --format "{{.Names}}" | findstr "arqpyb_run" >nul 2>&1
if %errorlevel% equ 0 (
    docker rm -f arqpyb_run
    if %errorlevel% equ 0 (
        echo Contenedor "arqpyb_run" eliminado correctamente.
    ) else (
        echo Ocurrió un error al eliminar el contenedor "arqpyb_run".
    )
) else (
    echo No se encontró el contenedor "arqpyb_run".
)

:: Eliminar la imagen Docker relacionada
echo Eliminando la imagen Docker "arqpyb_base"...
docker images --format "{{.Repository}}" | findstr "arqpyb_base" >nul 2>&1
if %errorlevel% equ 0 (
    docker rmi -f arqpyb_base
    if %errorlevel% equ 0 (
        echo Imagen "arqpyb_base" eliminada correctamente.
    ) else (
        echo Ocurrió un error al eliminar la imagen "arqpyb_base".
    )
) else (
    echo No se encontró la imagen "arqpyb_base".
)

:: Obtener la ruta del escritorio del usuario actual
for /f "tokens=*" %%A in ('powershell -Command "[System.Environment]::GetFolderPath('Desktop')"') do set "USER_DESKTOP=%%A"

:: Ruta al acceso directo en el escritorio
set "LNK_PATH=%USER_DESKTOP%\Linux_CTF_ARQPYB.lnk"

:: Verificar si el acceso directo existe
if exist "%LNK_PATH%" (
    echo Eliminando el acceso directo "%LNK_PATH%"...
    del "%LNK_PATH%"
    if %errorlevel% equ 0 (
        echo Acceso directo eliminado correctamente.
    ) else (
        echo Ocurrió un error al eliminar el acceso directo.
    )
) else (
    echo No se encontró el acceso directo "%LNK_PATH%".
)

echo Desinstalación completada.
