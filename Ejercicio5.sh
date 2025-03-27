##!/bin/bash

#Crear un script de Bash que reciba dos números (base y altura) para luego calcular el perímetro de un rectángulo.

calcularPerimetro() {
    local perimetro=$(( ($1 + $2)*2 ))
    echo $perimetro
}

echo "ingrese el largo del primer lado"
read lado1
echo "ingrese el largo del segundo lado"
read lado2

#echo "ingrese los 2 lados de un rectangulo (en formato: valor1 valor2), para calcular su perimetro
#read valor1 valor2

perimetro=$(calcularPerimetro $lado1 $lado2)
echo "el perimetro del rectangulo es de $perimetro"
