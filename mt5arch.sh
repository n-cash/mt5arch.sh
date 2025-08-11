#!/bin/bash
 
set -e
 
# -------------------------------------------
# MetaTrader 5 Installer for Arch Linux
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
        echo "➡️  Edit /etc/pacman.conf, uncomment [multilib] and execute: sudo pacman -Sy"
        exit 1
    fi
}
 
install_dependencies() {
    echo "📦 Installing necesary packages..."
    sudo pacman -Syu --needed wine-staging wine-gecko wine-mono winetricks wget
}
 
create_prefix() {
    if [ -d "$WINEPREFIX_DIR" ]; then
        echo "⚠️ Prefix '$WINEPREFIX_DIR' already exists."
        read -p "¿Do you wish to erase it and create it again? [s/N]: " choice
        if [[ "$choice" =~ ^[Ss]$ ]]; then
            rm -rf "$WINEPREFIX_DIR"
        else
            echo "ℹ️  Using existing prefix."
            return
        fi
    fi
 
    echo "🛠️  Creating a 64 bit prefix in '$WINEPREFIX_DIR'..."
    export WINEARCH=win64
    export WINEPREFIX="$WINEPREFIX_DIR"
    wineboot --init > /dev/null
    winetricks -q settings win10
}
 
download_mt5_installer() {
    if [ -f "$INSTALLER_NAME" ]; then
        echo "✔️ MT5 Installer is already downloaded."
    else
        echo "⬇️  Downloading MT5 installer..."
        wget -O "$INSTALLER_NAME" "$MT5_URL"
    fi
}
 
install_mt5() {
    echo "🚀 Starting MT5 Installer..."
    export WINEPREFIX="$WINEPREFIX_DIR"
    wine "$INSTALLER_NAME"
}
 
# ----------- Main Execution -----------
 
echo "🔧 MetaTrader 5 Instalation Script For Arch Linux"
 
check_multilib_enabled
install_dependencies
create_prefix
download_mt5_installer
install_mt5
 
echo "✅ Instalation complete. You can start Metatrader 5 by using:"
echo "   WINEPREFIX=\"$WINEPREFIX_DIR\" wine \"\$WINEPREFIX/drive_c/Program Files/MetaTrader 5/terminal64.exe\""
