#Crear un script de Bash que solicite al usuario un número natural n y cree n cantidad de archivos con los nombres archivo1, archivo2, etc.
#Escribir en todos los archivos el nombre del usuario actual.

echo "ingrese un numero natural"
read num

for ((i=1, i <= num, i++)) do
    echo "mi usuario es: $(whoami)" > "archivo$i"
done