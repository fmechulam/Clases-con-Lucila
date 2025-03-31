#!/bin/bash

#Crear un script de Bash que reciba un número entero e indique si el número es par o impar.

echo "ingrese un numero"
read valor

if [((valor %2 == 0))]; then
    echo "el valor ingresado es par"

else
    echo "el valor ingresado es impar"

fi