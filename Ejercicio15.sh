#!/bin/bash

#Crear un script de Bash que imprima en un archivo llamado “ordenados.txt”
#los nombres de todos los archivos del directorio actual ordenados según sus tamaños.


ls -l | grep "^-" | sort -k5 -n | awk '{print $9}' > ordenados.txt

echo "Los nombres de los archivos ordenados por tamaño se guardaron en ordenados.txt"


#explicacion:

#ls -l lista los archivos pero con detalles. Ej -rw-r--r-- 1 user user  524288 mar 27 10:20 Ejercicio1.txt. Donde la "columna" 9 es el nombre del archivo

#grep "^-" : filtra solo los archivos, sin directorios

#sort -k5 -n: Ordena los archivos según la quinta columna (que es el tamaño en bytes) y usa la opción -n para ordenarlos numéricamente.

#awk '{print $9}': toma la salida del sort y extrae solo la novena columna, que es la columna del nombre del archivo.

#Finalmente, redirigimos la salida a ordenados.txt con > para que se guarde ahi.