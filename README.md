# mt5arch.sh
Installation script for Metatrader5 within Arch, using `wine`. [English version here!](https://github.com/n-cash/mt5arch.sh/tree/main?tab=readme-ov-file#what-does-this-script-do)

## ¿Qué hace este script?
Este script es una adaptación [de los scripts de instalación oficiales para metatrader 5 en Linux.](https://www.metatrader5.com/en/terminal/help/start_advanced/install_linux)
Estos scripts originalmente se enfocaron sobre Ubuntu y Debian. Aquí los habilitamos en Arch, descartando gran parte del script que solo era requerida para Ubuntu/Debian, e integrando a `pacman` como el package manager correspondiente.
Tenemos dos versiones disponibles, una en [inglés](https://github.com/n-cash/mt5arch.sh/tree/main?tab=readme-ov-file#what-does-this-script-do) y otra en español.
## Paso por paso...
El script:
1. Verifica si el repositorio `multilib` está habilitado en el archivo `/etc/pacman.conf`. Si no lo está, va a ser necesario ir hasta ese archivo y habilitar/descomentar `multilib`.
2. Verifica e instala `wine-staging`, `wine-gecko`, `wine-mono`, `winetricks`, `wget`. Para mt5 en particular, es recomendable reemplazar `wine` por `wine-staging` (verifica si no entra en conflicto con otras configuraciones de `wine` presentes).
3. Crea el WINEPREFIX, `$HOME/.mt5`. Descarga el instalador, y lo instala dentro de esa ruta. ¡Listo!
-----
## Instalación.
- Para instalar, puedes usar `curl` en tu emulador de terminal para descargarte el script, darle permisos de ejecución, y ejecutarlo.

**Versión en español del script**
```bash
curl -O https://raw.githubusercontent.com/n-cash/mt5arch.sh/refs/heads/main/mt5arch-es.sh
chmod +x mt5arch-es.sh
./mt5arch-es.sh
```
-----
## What does this script do?  
This script is an adaptation [of the official Metatrader 5 installation scripts for Linux.](https://www.metatrader5.com/en/terminal/help/start_advanced/install_linux) These original scripts were primarily focused on Ubuntu and Debian. This has adapted them for Arch. It removes much of the code specific to Ubuntu/Debian and integrates `pacman` as the corresponding package manager.
There's two versions for it available: one in English and one in Spanish.
## Step-by-Step Instructions... 
The script performs the following actions: 
1. Checks for multilib Repository: It verifies if the `multilib` repository is enabled in the `/etc/pacman.conf` file. If not, it prompts the user to enable/uncomment the multilib line within this file.
2. Installs Required Dependencies: It installs `wine-staging`, `wine-gecko`, `wine-mono`, `winetricks`, `wget`.  For MT5, it’s recommended to replace `wine` with `wine-staging` (check first it this conflicts with any other existing wine configurations).
3. Creates the WINEPREFIX: It creates the `$HOME/.mt5` directory – this is where the MT5 installation will be placed. It then downloads and installs the MT5 installer within this directory.  Installation complete! 
-----
## Installation
- To install, you can use `curl` in your terminal emulator to download the script, grant it executable permissions, and then run it.

**English version of the script**
```bash
curl -O https://raw.githubusercontent.com/n-cash/mt5arch.sh/refs/heads/main/mt5arch.sh
chmod +x mt5arch.sh
./mt5arch.sh
```
