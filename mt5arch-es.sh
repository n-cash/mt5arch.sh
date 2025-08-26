#!/bin/bash
 
set -e
 
# -------------------------------------------
# Instalador de MetaTrader 5 para Arch Linux
# Author: [AI]
# Date: 2025-08-10
# -------------------------------------------
 
# Variables
MT5_URL="https://download.mql5.com/cdn/web/metaquotes.software.corp/mt5/mt5setup.exe"
WINEPREFIX_DIR="$HOME/.mt5"
INSTALLER_NAME="mt5setup.exe"
 
# ----------- Functions -----------
 
check_multilib_enabled() {
    if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
        echo "❌ El repositorio [multilib] no está habilitado."
        echo "➡️  Edita /etc/pacman.conf, descomenta [multilib] y ejecuta: sudo pacman -Sy"
        exit 1
    fi
}
 
install_dependencies() {
    echo "📦 Instalando dependencias necesarias..."
    sudo pacman -Syu --needed wine-staging wine-gecko wine-mono winetricks wget
}
 
create_prefix() {
    if [ -d "$WINEPREFIX_DIR" ]; then
        echo "⚠️ El prefix '$WINEPREFIX_DIR' ya existe."
        read -p "¿Deseas eliminarlo y crearlo de nuevo? [s/N]: " choice
        if [[ "$choice" =~ ^[Ss]$ ]]; then
            rm -rf "$WINEPREFIX_DIR"
        else
            echo "ℹ️  Usando el prefix existente."
            return
        fi
    fi
 
    echo "🛠️  Creando prefix de 64 bits en '$WINEPREFIX_DIR'..."
    export WINEARCH=win64
    export WINEPREFIX="$WINEPREFIX_DIR"
    wineboot --init > /dev/null
    winetricks -q settings win10
}
 
download_mt5_installer() {
    if [ -f "$INSTALLER_NAME" ]; then
        echo "✔️  Instalador de MT5 ya descargado."
    else
        echo "⬇️  Descargando instalador de MT5..."
        wget -O "$INSTALLER_NAME" "$MT5_URL"
    fi
}
 
install_mt5() {
    echo "🚀 Iniciando instalador de MT5..."
    export WINEPREFIX="$WINEPREFIX_DIR"
    wine "$INSTALLER_NAME"
}
 
# ----------- Main Execution -----------
 
echo "🔧 Script de instalación de MetaTrader 5 para Arch Linux"
 
check_multilib_enabled
install_dependencies
create_prefix
download_mt5_installer
install_mt5
 
echo "✅ Instalación finalizada. Puedes iniciar MT5 con:"
echo "   WINEPREFIX=\"$WINEPREFIX_DIR\" wine \"\$WINEPREFIX/drive_c/Program Files/MetaTrader 5/terminal64.exe\""
