#!/bin/bash


IP_LOCAL="127.0.0.1"
PORT="2223"
SERVER_AD="localhost" 


echo "Cliente"

echo "(1) SEND MSG: HOLI_TURIP"

IP_MD5=`echo $IP_LOCAL | md5sum | cut -d " " -f 1`  

echo "HOLI_TURIP $IP_LOCAL $IP_MD5" | nc $SERVER_AD $PORT

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
