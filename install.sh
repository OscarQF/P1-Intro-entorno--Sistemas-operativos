#! /bin/bash
# Por Jorge Dueñas Lerín

# Verifica que el fichero id.txt existe
if [ ! -f id.txt ]; then
    echo "El fichero id.txt no existe. Por favor, créalo antes de continuar."
    exit 1
else
    echo "El fichero id.txt ha sido encontrado."
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
mv ${WK_PATH}/Imagen/minix3hd.plot.qcow2 ${WK_PATH}/Imagen/minix3hd.plot.$ID_ALUMNO.qcow2
rm ${WK_PATH}/Imagen/minix3hd.plot.7z

cp minix312ahack.7z ${WK_PATH}/Minix/
7z x ${WK_PATH}/Minix/minix312ahack.7z -o${WK_PATH}/Minix/

cp start_minix ${WK_PATH}/Utilidades/
sed -i "s/##id##/$ID_ALUMNO/g" ${WK_PATH}/Utilidades/start_minix
chmod +x ${WK_PATH}/Utilidades/start_minix


if [ -f /home/alumno/.ssh/id_rsa ]; then
    cp /home/alumno/.ssh/id_rsa /home/alumno/Disco/Claves/id_rsa
    cp /home/alumno/.ssh/id_rsa.pub /home/alumno/Disco/Claves/id_rsa.pub
    echo "Clave SSH copiada."
else
    echo "Error no hay clave SSH"
fi

if [ -f /home/alumno/.gitconfig ]; then
    cp /home/alumno/.gitconfig /home/alumno/Disco/Claves/gitconfig
    echo "Archivo .gitconfig copiado."
else
    echo "Error no hay archivo .gitconfig"
fi

if [ -f ~/.ssh/known_hosts ]; then
    cp ~/.ssh/known_hosts ~/Disco/Claves/known_hosts
    echo "Archivo known_hosts copiado."
else
    echo "Error no hay archivo known_hosts"
fi

echo "Instalación completada. Puedes iniciar Minix ejecutando la orden: start_minix"