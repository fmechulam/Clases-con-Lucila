#!/bin/bash

buscar_archivo() {
    local nombre_archivo=$1
    local ruta_archivo

    ruta_archivo=$(find . -type f -name "$nombre_archivo")
    
    if [ -z "$ruta_archivo" ]; then
        echo "No se encontró el archivo '$nombre_archivo'."
        exit 1
    fi
    
    echo "$ruta_archivo"
}

#buscamos los archivos necesarios en el directorio actual y sub-directorios
ARCHIVO_POKEMON=$(buscar_archivo "pokemon.csv")
ARCHIVO_HABILIDADES=$(buscar_archivo "pokemon_abilities.csv")
ARCHIVO_NOMBRES_HABILIDADES=$(buscar_archivo "ability_names.csv")

echo "ingrese nombres de pokemones ("" para terminar)"

while IFS= read NOMBRE_POKEMON && [-n "$NOMBRE_POKEMON"]; do

    ID=$(grep -i ",$NOMBRE_POKEMON," "$ARCHIVO_POKEMON" | cut -d',' -f1)

    if [ -z "$ID" ]; then
        echo "pokemon "$NOMBRE_POKEMON" no encontrado"
        continue
    fi

    #obtenemos altura y peso
    ALTURA=$(grep -i ",$NOMBRE_POKEMON," "ARCHIVO_POKEMON" | cut -d',' -f4)
    PESO=$(grep -i ",$NOMBRE_POKEMON," "ARCHIVO_POKEMON" | cut -d',' -f5)

    echo "-------------------------"
    echo "pokemon $NOMBRE_POKEMON"
    echo "altura : $ALTURA"
    echo "peso : $PESO"
    echo "habilidades :"

    #obtenemos las habilidades
    HABILIDADES=$(grep "^ID," "$ARCHIVO_HABILIDADES" | cut -d',' -f2)

    for $HABILIDAD_ID in $HABILIDADES; do
        HABILIDAD_NOMBRE=$(grep "^HABILIDAD_ID,7," "$ARCHIVO_NOMBRES_HABILIDADES" | cut -d',' -f3)
        if [ -n $HABILIDAD_NOMBRE ] 
            echo " * $HABILIDAD_NOMBRE"
        fi
    done
done






