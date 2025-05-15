#!/bin/bash
#
# install-linko-plymouth.sh
# Copia el tema Linko a Plymouth, lo registra, lo activa y reinicia el sistema.
#
# Uso: sudo ./install-linko-plymouth.sh

set -e

# Variables
THEME_NAME="linko"
SRC_DIR="/home/restonic4/Linko-OS/image/mbr/simple_dual/plymouth/$THEME_NAME"
DEST_DIR="/usr/share/plymouth/themes/$THEME_NAME"
PLYMOUTH_ALT="/usr/share/plymouth/themes/default.plymouth"

# Comprobaciones previas
if [ "$EUID" -ne 0 ]; then
  echo "⚠️  Por favor, ejecuta este script como root o con sudo."
  exit 1
fi

if [ ! -d "$SRC_DIR" ]; then
  echo "❌  No se encuentra el directorio de tu tema en:"
  echo "    $SRC_DIR"
  exit 2
fi

# 1. Copiar el tema al directorio de Plymouth
echo "📁  Copiando tema Linko a $DEST_DIR..."
rm -rf "$DEST_DIR"
cp -r "$SRC_DIR" "$DEST_DIR"

# 2. Registrar el tema con update-alternatives
PLY_FILE="$DEST_DIR/$THEME_NAME.plymouth"
if [ ! -f "$PLY_FILE" ]; then
  echo "❌  No se encuentra el archivo .plymouth en $DEST_DIR"
  exit 3
fi

echo "🔗  Registrando alternativa default.plymouth..."
update-alternatives --install \
  "$PLYMOUTH_ALT" \
  default.plymouth \
  "$PLY_FILE" \
  100

# 3. Seleccionar el tema como predeterminado
echo "🎯  Seleccionando Linko como tema por defecto..."
update-alternatives --set default.plymouth "$PLY_FILE"

# 4. Actualizar initramfs
echo "⚙️  Reconstruyendo initramfs para incluir el nuevo tema..."
update-initramfs -u

# 5. Reiniciar para ver el nuevo splash
echo ""
echo "✅  Tema instalado y configurado."
echo "🔄  Reiniciando Ubuntu para aplicar cambios..."
sleep 2
reboot