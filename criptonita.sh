#!/bin/bash

#criptonita 0.0.1 GPLv3

#This Shell Script uses bash as command interpreter / Este script utiliza bash como interprete de comandos
#Author: ACO
#Date: 2021
#Commit language: Spanish
#contact:acoproteco@gmail.com



#Variables para imprimir texto en color se usa en algunos textos junto con echo 
C='\033[0;31m'  #Variable para colorear texto
NC='\033[0m'    #Variable para quitar color a texto




#Funcion que verifica si la ruta de archivo es válida
validarRuta()
{
	#Variable que almacena si ya se encontró el archivo a cifrar o descifrar
	ARCHIVO="FALSE"
	FILE="FALSE" # FILE es True cuando sabemos que se trata de un fichero
	DIR="FALSE"  #DIR  es True cuando sabemos que se trata de una carpeta

	#Se imprimen las instrucciones para selección de ruta de archivo se puede navegar por los directorios
	clear; #Limpiamos emulador de consola
	echo "INGRESE LA RUTA, PUEDE APOYARSE EN LOS COMANDOS"
	echo "Listar: list"
	echo "Regresar: back"
	echo -e "Dirigirse a (poner go ENTER y luego la ruta): go" #Texto con salto de línea 
	echo  "Para ingresar la ruta del archivo solo escribala sin ningún comando previo" 
	
	#Bucle que mantiene en un prompt del script se rompe cuando se valida la ruta
	until [ "$ARCHIVO" == "TRUE" ]
	do							

		#Imprimimos la ruta en la que se encuentra el usuario
		echo -e "${C}RUTA ACTUAL: $PWD ${NC}"

		#Imprimimos un promt para indicar la entrada de comandos
		echo -n 'criptonita@>> '
		
		#Variable que almacena la ruta o el comando de navegación
		read COM_RUT; #Leemos el comando o ruta ingresada por el usuario

		#Switch case para comandos de navegación o ingreso de ruta a archivo a cifrar
		case $COM_RUT in
			"list") #Listamos lo que hay en la ruta actual
				#Listamos
				ls;
			;;
			"back") #Es para poder regresar a la carpeta madre
				#Tal cual es un cd ..
				cd ..
			;;	
			"go") #Es como el comando cd pero a dos pasos
				#Se almacenará la ruta para después dirigirse e ella
				RUTA=""
				echo -n "Ir a: "
				
				#Variable que almacena la ruta lee la entrada del usuario
				read RUTA

				#Verificamos que se trate de un directorio
				if [ -d "$RUTA" ]
				then
					#Nos movemos al directorio en caso de existir
					cd "$RUTA"
				else
					#Se indica que no es un directorio lo que indica que no podemos movernos ahí
					echo "$RUTA no es un directorio"
				fi
			;;
			"help") #Imprime de nuevo las instrucciones de uso
				echo "INGRESE LA RUTA, PUEDE USAR COMANDOS BÁSICOS DE NAVEGACIÓN"
				echo "Listar: list"
				echo "Regresar: back"
				echo -e "Dirigirse a (poner go ENTER y luego la ruta): go"
				echo  "Para ingresar la ruta del archivo a cifrar solo escribala"
			;;
			"clear") #Funciona como un clear en consola
				clear
			;;
			"exit")  #Salimos del prompt de validación de ruta
				break
			;;			
			*)
				#De no estar en el listado de comandos pasa a ruta para su próxima verificación 
				RUTA="$COM_RUT"

				#Variables a usar como booleanos para verificar que tipo de ruta ingresaron				

				#Estructura de control de validación de ruta
				if [ -f "$RUTA" ] #En el caso de que exista la ruta y se un fichero
				then
					#Existe únicamente el fichero										
					FILE="TRUE"
					ARCHIVO="TRUE"															
				elif [ -d "$RUTA" ] #En el caso de que exita la ruta y el directorio
				then
					#Existe únicamente el direct
					DIR="TRUE"
					ARCHIVO="TRUE"
				else
					#La ruta que ingresó no es una ruta válida
					echo "La ruta es incorrecta"
				fi
			;;
		esac #Final de switch para comandos de validación de ruta
	done #Final de ciclo de busqueda de archivo a trabajar 
}

#FUNCIÓN DE CIFRADO
cifrado()
{	
	#Se investiga la ruta del archivo
	if [ $RECURSIVO = "TRUE" ] #El caso recursivo es exclusivo para el segundo tratamiento de directorio
	then
		RECURSIVO="FALSE"  #El recursivo solo debe aplicar una vez por cada directorio
		DIR="FALSE"        #Se indica que ya no hay un directorio al cual cifrar 
	else
		#Se pide una ruta para indicar el archivo y se valida 
		#(en el caso de recursivo la ruta ya se tiene y no requiere validación extra) 
		validarRuta          
	fi	

	#Verificamos que tipo de ruta dio el usuario
	if [ $FILE = "TRUE" ] && [ $ARCHIVO = "TRUE" ]
	then	
	
	#De acuerdo al método seleccionamos los comandos acordes
		case $METODO in
			"1") #Para cifrar a 3DES
				gpg --no-symkey-cache --symmetric --cipher-algo 3DES $RUTA && rm $RUTA #Cifra genera un gpg y elimina original
				mv $RUTA.gpg $RUTA #cambia el nombre con extensión original
			;;
			"2") #Para cifrar a AES 128
				gpg --no-symkey-cache --symmetric --cipher-algo AES $RUTA && rm $RUTA #Cifra genera un gpg y elimina original
				mv $RUTA.gpg $RUTA #cambia el nombre con extensión original
			;;
			"3") #Para cifrar a AES 192
				gpg --no-symkey-cache --symmetric --cipher-algo AES192 $RUTA && rm $RUTA #Cifra genera un gpg y elimina original
				mv $RUTA.gpg $RUTA #cambia el nombre con extensión original
			;;
			"4") #Para cifrar a AES 256
				gpg --no-symkey-cache --symmetric --cipher-algo AES256 $RUTA && rm $RUTA #Cifra genera un gpg y elimina original
				mv $RUTA.gpg $RUTA #cambia el nombre con extensión original
			;;
			"5") #Para cifrar a BLOWFISH
				gpg --no-symkey-cache --symmetric --cipher-algo BLOWFISH $RUTA && rm $RUTA #Cifra genera un gpg y elimina original
				mv $RUTA.gpg $RUTA #cambia el nombre con extensión original
			;;
			"6") #Para cifrar a CAMELIA128
				gpg --no-symkey-cache --symmetric --cipher-algo CAMELIA128 $RUTA && rm $RUTA #Cifra genera un gpg y elimina original
				mv $RUTA.gpg $RUTA #cambia el nombre con extensión original
			;;
			"7") #Para cifrar a CAMELIA192
				gpg --no-symkey-cache --symmetric --cipher-algo CAMELIA192 $RUTA && rm $RUTA #Cifra genera un gpg y elimina original
				mv $RUTA.gpg $RUTA #cambia el nombre con extensión original
			;;
			"8") #Para cifrar a CAMELIA256
				gpg --no-symkey-cache --symmetric --cipher-algo CAMELIA256 $RUTA && rm $RUTA #Cifra genera un gpg y elimina original
				mv $RUTA.gpg $RUTA #cambia el nombre con extensión original
			;;
			"9") #Para cifrar a CAST5
				gpg --no-symkey-cache --symmetric --cipher-algo CAST5 $RUTA && rm $RUTA #Cifra genera un gpg y elimina original
				mv $RUTA.gpg $RUTA #cambia el nombre con extensión original
			;;
			"10") #Para cifrar a IDEA
				gpg --no-symkey-cache --symmetric --cipher-algo IDEA $RUTA && rm $RUTA #Cifra genera un gpg y elimina original
				mv $RUTA.gpg $RUTA #cambia el nombre con extensión original
			;;
			"11") #Para cifrar a TWOFISH
				gpg --no-symkey-cache --symmetric --cipher-algo TWOFISH $RUTA && rm $RUTA #Cifra genera un gpg y elimina original
				mv $RUTA.gpg $RUTA #cambia el nombre con extensión original
			;;
		esac #Fin de switch de metodo de cifrado
	elif [ $DIR = "TRUE" ] && [ $ARCHIVO = "TRUE" ] #Es el caso en el que el archivo es un directorio
	then
		#En ruta actual guardamos la ruta del usuario al momento de ejecutar el script ya que requerimos mover para 
		#al momento de usar tar no generar carpetas madre extras
		RUTAACTUAL="$(pwd)"  #Se guarda la ubicación actual
		MADREDIR="$(cd $RUTA && cd .. && pwd)"  #Se identifica la carpeta madre del directorio
		cd $MADREDIR # Nos movemos al contenedor del directorio para comprimir con tar
		NOMBREDIR="$(basename $RUTA)" #Obtenemos el nombre del directorio a partir de la ruta absoluta
		#Comprimimos eliminamos original renombramos comprimido y mandamos a cifrado
		tar -cf $RUTA.tar $NOMBREDIR && rm -r $RUTA && mv $RUTA.tar $RUTA && FILE="TRUE" && RECURSIVO="TRUE" && cifrado
		cd $RUTAACTUAL #Regresamos al usuario al directorio inicial
	fi

}

descifrar()
{

	validarRuta
	RESPUESTA=""
	if [ $FILE = "TRUE" ] && [ $ARCHIVO = "TRUE" ]
	then
		until [ "$RESPUESTA" == "s" ] || [ "$RESPUESTA" == "S" ] || [ "$RESPUESTA" == "N" ] || [ "$RESPUESTA" == "n" ]
		do
			echo "¿El archivo a descifrar era un directorio S/N?"
			read RESPUESTA			
		done
		if [ $RESPUESTA = "S" ] || [ $RESPUESTA = "s" ]
		then
			mv $RUTA $RUTA.gpg && gpg -d -o $RUTA $RUTA.gpg || mv $RUTA.gpg $RUTA 
			if [ -f "$RUTA" ]
			then
				RUTAACTUAL="$(pwd)"
				MADREDIR="$(cd $RUTA && cd .. && pwd)"
				rm $RUTA.gpg && mv $RUTA $RUTA.tar && cd $MADREDIR && tar -xvf $RUTA.tar && rm $RUTA.tar 
				cd $RUTAACTUAL
			fi
		elif [ $RESPUESTA = "N" ] || [ $RESPUESTA = "n" ]
		then	 
			mv $RUTA $RUTA.gpg && gpg -d -o $RUTA $RUTA.gpg || mv $RUTA.gpg $RUTA
			if [ -f "$RUTA.gpg" ]
			then
				mv $RUTA.gpg $RUTA && rm $RUTA.gpg
			fi
		fi	
	fi
}




#Verificamos que exista steghide
if [ -f "/usr/bin/steghide" ]
then
	echo "Steghide OK"
else
	echo "Requiere de instalación de steghide"
	sudo apt install steghide
fi

#Verificamos que exista gpg 
if [ -f "/usr/bin/gpg" ]
then
	echo "gpg OK"
else
	echo "Requiere instalación de gpg"
	sudo apt install gpg
fi

#Limpiamos pantalla para comenzar con ejecución de script
clear

#Inicializamos OPCION variable que almacena la respuesta del menú principal
OPCION="0";

#Bucle de menú principal, se rompe al usar 4, exit, salir o 4)
until [ "$OPCION" == "4" ] || [ "$OPCION" == "exit" ] || [ "$OPCION" == "salir" ] || [ "$OPCION" == "4)" ]
do
	echo "criptonita 0.0.1 GPL v3"
	echo -e "Seleccione la opción deseada:"
	echo "1) Cifrar"
	echo "2) Descifrar"
	echo "3) Esteganografía"
	echo "4) Salir"
	read OPCION;
	#switch case que nos perminte actuar de acuerdo a la respuesta de menú principal
	case $OPCION in
		"1")						
			#Es el caso en el que el usuario quiere cifrar
			#METODO es la variable que almacena la respuesta del usuario en el menú de métodos de cifrado
			METODO="0";
			#Bucle del menú de métodos, se rompe con selección de respuesta 8
			until [ "$METODO" == "12" ]
			do
				clear								
				echo -e "Selecciona el método de cifrado:"
				echo "1) 3DES"
				echo "2) AES 128"
				echo "3) AES 192"
				echo "4) AES 256"
				echo "5) BLOWFISH"
				echo "6) CAMELIA 128"
				echo "7) CAMELIA 192"
				echo "8) CAMELIA 256"
				echo "9) CAST5"
				echo "10) IDEA"
				echo "11) TWOFISH" 
				echo "12) regresar"
				read METODO
				
				if [ "$METODO" -ge 1 ] && [ "$METODO" -le 11 ]
				then
					cifrado
					RECURSIVO="FALSE"
					clear
				elif [ "$METODO" = "12" ]
				then
					clear
				fi
			done
			;;
		"2")
			descifrar
			;;
		"3")
			echo "Seleccionaste Esteganografía"
			;;
		"4")
			clear
			;;
		"man criptonita")
			echo "Manual"
			;;
		*)
			echo "Opción inválida"

			clear
			echo "Para ver el manual de uso ingrese: man criptonita"			
			;;
	esac
done


