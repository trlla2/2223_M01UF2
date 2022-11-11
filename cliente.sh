#!/bin/bash

PORT="2223"
SERVER_AD="localhost" 


echo "Cliente"

echo "(1) SEND MSG: HOLI_TURIP"

echo "HOLI_TURIP 127.0.0.1" | nc $SERVER_AD $PORT

echo "(2) LISTEN: Comprovacion handshake"

MSG=`nc -l $PORT`

if [ "$MSG" != "OK_TURIP" ]
then
	echo "ERROR 1: Handshake incorrecto"
	
	exit 1 
fi
echo "(5) SEND MSG: File"

FILENAME="vaca.vaca"

echo "FILE_NAME $FILENAME" | nc $SERVER_AD $PORT

echo "(6)LISTEN"

MSG=`nc -l $PORT`

if [ "$MSG" != "OK_FILE_NAME" ]
then
	echo "ERROR 2: Nombre de archivo incorrecto"
	
	exit 1 
fi

cat /home/enti/vacas/$FILENAME | nc $SERVER_AD $PORT 

exit 0
