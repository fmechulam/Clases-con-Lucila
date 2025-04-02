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

#buscamos los archivos necesarios en el directorio actual y sub-directorios
ARCHIVO_IDS_TIPOS=$(buscar_archivo "pokemon_types.csv")
ARCHIVO_STATS_TIPOS=$(buscar_archivo "pokemon_stats.csv")
ARCHIVO_NOMBRES=$(buscar_archivo "pokemon.csv")

#busco / creo si no encuentro el directorio pasado por parametro
mkdir -p "$DIRECTORIO"
RESULTADO="$DIRECTORIO/resultado.txt"

#filtramos los ids de los pokemones que cumplan con el tipo
POKEMON_FILTRADOS=$(grep -i ",$TIPO," "$ARCHIVO_IDS_TIPOS" | cut -d',' -f1)


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