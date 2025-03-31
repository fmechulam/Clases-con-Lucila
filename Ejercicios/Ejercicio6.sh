#!/bin/bash

#Crear un script de Bash que le solicite al usuario el ingreso de un número e indicar si el número es mayor, menor o igual a 0. Imprimir por pantalla.

echo "ingrese un numero para compararlo con 0"
read valor

if [$valor -gt 0]; then
    echo "$valor es mayor a cero"
    
elif [$valor -lt 0]; then
    echo "$valor es menor a cero"

else echo "$valor es cero"
fi

