#! /bin/bash
# Por Jorge Dueñas Lerín

# Verifica que el fichero id.txt tiene un contienido
if grep -q "Modifícame" id.txt; then
    echo "El fichero id.txt no ha sido modificado. Por favor, modifícalo antes de continuar."
    exit 1
else
    echo "El fichero id.txt ha sido modificado correctamente."
fi

mkdir -p ~/Disco/Imagen/
mkdir -p ~/Disco/Salida/
mkdir -p ~/Disco/Claves/
mkdir -p ~/Disco/Otros/
mkdir -p ~/Disco/Minix/
mkdir -p ~/Disco/Utilidades/

ID_ALUMNO=$(cat id.txt | tr -d ' \t\n\r')
echo "ID del alumno: $ID_ALUMNO"

WK_PATH=$(echo ~)/Disco

mkdir -p ${WK_PATH}

cp minix3hd.plot.7z ${WK_PATH}/Imagen/
7z x ${WK_PATH}/Imagen/minix3hd.plot.7z -o${WK_PATH}/Imagen/
cp ${WK_PATH}/Imagen/minix3hd.plot.qcow2 ${WK_PATH}/Imagen/minix3hd.plot.$ID_ALUMNO.qcow2

cp minix312ahack.7z ${WK_PATH}/Minix/
7z x ${WK_PATH}/Minix/minix312ahack.7z -o${WK_PATH}/Minix/

cp start_minix ${WK_PATH}/Utilidades/
sed -i "s/##id##/$ID_ALUMNO/g" ${WK_PATH}/Utilidades/start_minix
chmod +x ${WK_PATH}/Utilidades/start_minix

echo "Instalación completada. Puedes iniciar Minix ejecutando la orden: start_minix"