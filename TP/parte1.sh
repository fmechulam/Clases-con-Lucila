#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <padron> <directorio_salida>"
    exit 1
fi

PADRON=$1
DIRECTORIO=$2

#calculamos el tipo del pokemon
TIPO=$(( (PADRON % 18) + 1 ))

#calculamos la estadistica minima
ESTADISTICA_MINIMA=$(( (PADRON % 100) + 350 ))

#buscamos el archivo "pokemon_types.csv" en el directorio actual y sub-directorios
ARCHIVO_IDS_TIPOS=$(find . -type f -name "pokemon_types.csv" | head -n 1)

#comprobamos que hayamos encontrado el archivo "pokemon_types.csv"
if [ -z "$ARCHIVO_IDS_TIPOS" ]; then
    echo "No se encontro el archivo 'pokemon_types.csv'."
    exit 1
fi

#buscamos el archivo "pokemon_stats.csv" en el directorio actual y sub-directorios
ARCHIVO_STATS_TIPOS=$(find . -type f -name "pokemon_stats.csv" | head -n 1)

if [ -z "$ARCHIVO_STATS_TIPOS" ]; then
    echo "No se encontro el archivo 'pokemon_stats.csv'."
    exit 1
fi

#buscamos el archivo "pokemon.csv" en el directorio actual y sub-directorios
ARCHIVO_NOMBRES=$(find . -type f -name "pokemon.csv" | head -n 1)

if [ -z "$ARCHIVO_NOMBRES" ]; then
    echo "No se encontro el archivo 'pokemon.csv'."
    exit 1
fi

#busco / creo si no encuentro el directorio pasado por parametro
mkdir -p "$DIRECTORIO"
RESULTADO="$DIRECTORIO/resultado.txt"

#filtramos los ids de los pokemones que cumplan con el tipo
POKEMON_FILTRADOS=$(grep -i ",${TIPO}," "$ARCHIVO_IDS_TIPOS" | cut -d',' -f1)

# Agregamos depuración para verificar que se están filtrando los pokemones correctamente
echo "Pokemones filtrados por tipo $TIPO: $POKEMON_FILTRADOS"

#calcular la estadistica total de cada pokemon y filtrar por estadistica total minima
> "$RESULTADO"

for ID in $POKEMON_FILTRADOS; do
    #calculamos las estadisticas totales de cada pokemon
    STATS_TOTAL=$(grep "^$ID," "$ARCHIVO_STATS_TIPOS" | cut -d',' -f3 | paste -sd+ - | bc)
    
    # Agregamos depuración para verificar el cálculo de la estadística total
    echo "Estadísticas totales de Pokemon ID $ID: $STATS_TOTAL"

    #filtramos por estadistica total minima
    if [ "$STATS_TOTAL" -ge "$ESTADISTICA_MINIMA" ]; then
        #obtenemos el nombre del pokemon usando el id
        NOMBRE=$(grep "^$ID," "$ARCHIVO_NOMBRES" | cut -d',' -f2)

        # Verificamos si se obtuvo el nombre correctamente
        if [ -z "$NOMBRE" ]; then
            echo "No se pudo obtener el nombre para el Pokémon ID $ID"
        else
            #guardamos el nombre en el archivo de resultado
            echo "$NOMBRE" >> "$RESULTADO"
            echo "Pokemon $ID cumple con la estadística mínima. Nombre: $NOMBRE"
        fi
    fi
done

# Agregamos mensaje final de depuración
echo "Proceso completado. Los resultados están en '$RESULTADO'."