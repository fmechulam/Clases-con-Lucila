#Crear un script de Bash que solicite el ingreso de un número n y que luego calcule su factorial.

echo "ingrese un numero"
read num

factorial=1
for ((i=1, i<=$num, i++)); do
    factorial=$((factorial * $i))
done

echo "el factorial de $numero es $factorial"