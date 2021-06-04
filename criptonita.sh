#!/bin/bash

#Author: ACO
#Date: 2021
#This Shell Script uses bash as command interpreter
#Commit language: Spanish

#Funcion de validado de ruta
validarRuta()
{
	#Variable que indica si ya se tiene un objeto a cifrar
	ARCHIVO="FALSE"
	#Se imprimen las instrucciones para selección de ruta de archivo a cifrar
	clear;
	echo "INGRESE LA RUTA, PUEDE USAR COMANDOS BÁSICOS DE NAVEGACIÓN"
	echo "Listar: list"
	echo "Regresar: back"
	echo -e "Dirigirse a (poner go ENTER y luego la ruta): go"
	echo  "Para ingresar la ruta del archivo solo escribala"
	#Bucle que se rompe cuando se indica una ruta aceptada
	until [ "$ARCHIVO" == "TRUE" ]
	do							
		echo -e "ESTAS EN: $PWD"
		echo -n '>> '
		#Variable que almacena la ruta o el comando para el archivo a cifrar
		read COM_RUT;
		#Switch case para comandos de navegación o ingreso de ruta a archivo a cifrar
		case $COM_RUT in
			"list")
				#Listamos
				ls;
			;;
			"back")
				#Tal cual es un cd ..
				cd ..
			;;	
			"go")
				#Se almacenará la ruta para después dirigirse e ella
				RUTA=""
				echo -n "Ir a: "
				read RUTA
				if [ -d "$RUTA" ]
				then
					cd "$RUTA"
				else
					echo "$RUTA no es un directorio"
				fi
			;;
			"help")
				echo "INGRESE LA RUTA, PUEDE USAR COMANDOS BÁSICOS DE NAVEGACIÓN"
				echo "Listar: list"
				echo "Regresar: back"
				echo -e "Dirigirse a (poner go ENTER y luego la ruta): go"
				echo  "Para ingresar la ruta del archivo a cifrar solo escribala"
			;;
			"clear")
				clear
			;;
			"exit")		
				break
			;;
			*)
				#Se parte de la consideración que el usuario puso una ruta
				RUTA="$COM_RUT"
				#Variables a usar como booleanos para verificar que tipo de ruta ingresaron
				FILE="FALSE"
				DIR="FALSE"									
				if [ -d "$RUTA" ] && [ -f "$FILE" ]
				then
					#En el caso que exista el fichero y el directorio
					echo "La ruta es ambigua, usted se refiere a:"
					echo "1) Directorio"
					echo "2) Documento"
					#Variable para ambiguedad
					DESAMB=""
					read DESAMB
					if [ DESAMB = "1" ]
					then
						DIR="TRUE"
						ARCHIVO="TRUE"
					elif [ DESAMB = "2" ]
					then
						FILE="TRUE"
						ARCHIVO="TRU"
					else
						echo "Respuesta no válida"
					fi
				elif [ -f "$RUTA" ]
				then
					#Existe únicamente el fichero										
					FILE="TRUE"
					ARCHIVO="TRUE"															
				elif [ -d "$RUTA" ]
				then
					#Existe únicamente el direct
					DIR="TRUE"
				else
					echo "La ruta es incorrecta"
				fi
			;;
		esac
	done
}

#FUNCIÓN DE CIFRADO
cifrado()
{	
	#Se investiga la ruta del archivo
	validarRuta
	
	
	#Verificamos que tipo de ruta dio el usuario
	if [ $FILE = "TRUE" ]
	then	
	case $METODO in
		"1")
			gpg --symmetric --cipher-algo 3DES $RUTA && rm $RUTA
			mv $RUTA.gpg $RUTA
		;;
		"2")
			gpg --symmetric --cipher-algo AES $RUTA && rm $RUTA
			mv $RUTA.gpg $RUTA
		;;
		"3")
			gpg --symmetric --cipher-algo AES192 $RUTA && rm $RUTA
			mv $RUTA.gpg $RUTA
		;;
		"4")
			gpg --symmetric --cipher-algo AES256 $RUTA && rm $RUTA
			mv $RUTA.gpg $RUTA
		;;
		"5")
			gpg --symmetric --cipher-algo BLOWFISH $RUTA && rm $RUTA
			mv $RUTA.gpg $RUTA
		;;
		"6")
				gpg --symmetric --cipher-algo CAMELIA128 $RUTA && rm $RUTA
				mv $RUTA.gpg $RUTA
		;;
		"7")
			gpg --symmetric --cipher-algo CAMELIA192 $RUTA && rm $RUTA
			mv $RUTA.gpg $RUTA
		;;
		"8")
			gpg --symmetric --cipher-algo CAMELIA256 $RUTA && rm $RUTA
			mv $RUTA.gpg $RUTA
		;;
		"9")
			gpg --symmetric --cipher-algo CAST5 $RUTA && rm $RUTA
			mv $RUTA.gpg $RUTA
		;;
		"10")
			gpg --symmetric --cipher-algo IDEA $RUTA && rm $RUTA
			mv $RUTA.gpg $RUTA
		;;
		"11")
			gpg --symmetric --cipher-algo TWOFISH $RUTA && rm $RUTA
			mv $RUTA.gpg $RUTA
		;;
		esac
	fi		
}

descencriptar()
{
	validarRuta

	mv $RUTA $RUTA.gpg
	gpg -d -o $RUTA $RUTA.gpg
	rm $RUTA.gpg
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
					clear
				elif [ "$METODO" = "12" ]
				then
					clear
				fi
			done
			;;
		"2")
			descencriptar
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


