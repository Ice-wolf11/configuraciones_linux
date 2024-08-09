# Directorio donde se encuentran los fondos de pantalla
DIR="/home/andrew/Imágenes/fondos"

# Selecciona una imagen aleatoria del directorio
PIC=$(find $DIR -type f | shuf -n1)

# Establece el fondo de pantalla
WALLPAPER="file://$PIC"
gsettings set org.gnome.desktop.background picture-uri-dark $WALLPAPER

# Aplica el esquema de colores con pywal
wal -i $PIC

