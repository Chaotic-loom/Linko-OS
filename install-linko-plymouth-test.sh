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

# 0. Comprobación de root
if [ "$EUID" -ne 0 ]; then
  echo "⚠️  Ejecuta este script con sudo o como root."
  exit 1
fi

# 1. Comprobar que el tema existe en el home del usuario
if [ ! -d "$SRC_DIR" ]; then
  echo "❌  No encuentro el tema en: $SRC_DIR"
  exit 2
fi

# 2. Copiar el tema al directorio de Plymouth
echo "📁  Copiando tema Linko a $DEST_DIR..."
rm -rf "$DEST_DIR"
cp -r "$SRC_DIR" "$DEST_DIR"

# 3. Buscar el .plymouth dentro de DEST_DIR
PLY_FILE=$(find "$DEST_DIR" -maxdepth 1 -type f -name '*.plymouth' | head -n1 || true)
if [ -z "$PLY_FILE" ]; then
  echo "❌  No se encontró ningún archivo .plymouth en $DEST_DIR"
  exit 3
fi

# 4. Registrar el tema con update-alternatives
echo "🔗  Registrando alternativa default.plymouth → $PLY_FILE"
update-alternatives --install \
  "$PLYMOUTH_ALT" \
  default.plymouth \
  "$PLY_FILE" \
  100

# 5. Seleccionar el tema como predeterminado
echo "🎯  Activando Linko como tema por defecto"
update-alternatives --set default.plymouth "$PLY_FILE"

# 6. Reconstruir initramfs para incluir el tema
echo "⚙️  Reconstruyendo initramfs..."
update-initramfs -u

# 7. Reiniciar para ver el nuevo splash
echo -e "\n✅  Tema instalado y configurado."
echo "🔄  Reiniciando ahora para aplicar cambios..."
sleep 2
reboot
