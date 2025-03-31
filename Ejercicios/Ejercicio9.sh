#Crear un script de Bash que imprima los primeros n números naturales. Solicitar al usuario el ingreso de n.

echo "ingrese un valor"
read valor

for ((i=1, i<=$valor, i++)); do
    echo $i
done