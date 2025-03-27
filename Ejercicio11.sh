#Crear un script de Bash que solicite al usuario el ingreso de un número par. En caso de que sea impar, solicitarlo nuevamente.

while true do
    
    echo "ingrese un numero par"
    read num

    if [((num %2 == 0))]; then
        echo "numero ingresado correctamente"
        break

    else
        echo "el numero ingresado no es par, ingreselo nuevamente"

    fi
done
    