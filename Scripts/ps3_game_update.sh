#!/bin/bash
# PS3 Update Downloader para Linux
# Descarga actualizaciones oficiales desde los servidores de Sony (a0.ww.np.dl.playstation.net)

echo "🕹️  PS3 Update Downloader (oficial Sony servers)"
read -p "Introduce el Title ID del juego (ejemplo: BLES01994): " TITLE_ID

# Crear carpeta de destino
mkdir -p "$HOME/PS3_Updates/$TITLE_ID"
cd "$HOME/PS3_Updates/$TITLE_ID" || exit

# Archivo XML que contiene los datos de la actualización
UPDATE_XML_URL="https://a0.ww.np.dl.playstation.net/tpl/np/$TITLE_ID/$TITLE_ID-ver.xml"

echo "🔍 Buscando archivo de versión en:"
echo "$UPDATE_XML_URL"
echo

# Descargar XML de versión
curl -O "$UPDATE_XML_URL" 2>/dev/null

# Verificar si se descargó
if [ ! -f "$TITLE_ID-ver.xml" ]; then
  echo "❌ No se pudo obtener el archivo de actualización. Es posible que Sony haya retirado el parche."
  exit 1
fi

# Buscar la URL del archivo PKG dentro del XML
PKG_URL=$(grep -oP 'http://[^\s"]+\.pkg' "$TITLE_ID-ver.xml" | head -n 1)

if [ -z "$PKG_URL" ]; then
  echo "⚠️  No se encontró un enlace de actualización en el XML."
  echo "Verifica el Title ID o prueba con otro juego."
  exit 1
fi

echo "✅ Enlace de actualización encontrado:"
echo "$PKG_URL"
echo
read -p "¿Deseas descargar esta actualización? (s/n): " CONFIRM

if [[ "$CONFIRM" == "s" || "$CONFIRM" == "S" ]]; then
  echo "⬇️  Descargando actualización..."
  curl -O "$PKG_URL"
  echo
  echo "✅ Descarga completada."
  echo "Archivo guardado en: $HOME/PS3_Updates/$TITLE_ID"
else
  echo "❌ Descarga cancelada."
fi
