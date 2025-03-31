#!/bin/bash

if ['$#' -ne 2]; then
    echo "Uso: $0 <padron> <directorio>"
    exit 1
fi

PADRON=$1
DIRECTORIO=$2

#calculamos el tipo del pokemon
TIPO=$(( (PADRON % 18) +1 ))

#calculamos la estadistica minima
ESTADISTICA_MINIMA=$(( (PADRON % 100) + 350 ))

#buscamos el archivo "pokemon_types.csv" en el directorio actual y sub-directorios
ARCHIVO_IDS_TIPOS=$(find . -type f -name "pokemon_types.csv" | head -n 1)

#comprobamos que hayamos encontrado el archivo "pokemon_types.csv"
if [ -z "$ARCHIVO_IDS_TIPOS" ]; then
    echo "No se encontro el archivo "pokemon_types.csv"."
    exit 1
fi

#buscamos el archivo "pokemon_stats.csv" en el directorio actual y sub-directorios
ARCHIVO_STATS_TIPOS=$(find . -type f -name "pokemon_stats.csv" | head -n 1)

if [ -z "$ARCHIVO_STATS_TIPOS" ]; then
    echo "No se encontro el archivo "pokemon_stats.csv"."
    exit 1
fi

#buscamos el archivo "pokemon.csv" en el directorio actual y sub-directorios
ARCHIVO_NOMBRES=$(find . -type f -name "pokemon" | head -n 1)

if [ -z "$ARCHIVO_NOMBRES" ]; then
    echo "No se encontro el archivo "pokemon.csv"."
    exit 1
fi

#busco / creo si no encuentro el directorio pasado por parametro
mkdir -p "$DIRECTORIO"
RESULTADO="$DIRECTORIO/resultado.txt"

#filtramos los ids de los pokemones que cumplan con el tipo
POKEMON_FILTRADOS=$(grep -i ",${TIPO}," "$ARCHIVO_IDS_TIPOS" | cut -d',' -f1)

#calcular la estadistica total de cada pokemon y filtrar por estadistica total minima
> "$RESULTADO"
for ID in $POKEMON_FILTRADOS; do
    #calculamos las estadisticas totales de cada pokemon
    STATS_TOTAL=$(grep "^$ID," "$ARCHIVO_STATS_TIPOS" | cut -d',' -f3 | paste -sd+ - | bc)
    
    #filtramos por estadistica total minima
    if ["$STATS_TOTAL" -ge "$ESTADISTICA_MINIMA"]; then
        #obtenemos el nombre del pokemon usando el id
        NOMBRE=$(grep "$^ID," "$ARCHIVO_NOMBRES" | cut -d',' -f2)
        #guardamos el nombre en el archivo de resultado
        echo "$NOMBRE" >> "$RESULTADO"
    fi
done



        
