#!/bin/bash

# Crear un script de Bash que reciba dos números e imprima por pantalla su suma

sumar() {
    suma=$(($1 + $2))
    echo $suma
}


echo "ingresar el primer valor"
read valor1
echo "ingresar el segundo valor"
read valor2

resultado=$(sumar valor1 valor2)

echo "el resultado de hacer $valor1 + $valor2 es $resultado"