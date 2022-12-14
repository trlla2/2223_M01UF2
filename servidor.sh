#!/bin/bash

PORT="2223"

echo "Servidor Transfer Unite Recursive Internacional Protocol: TURIP"

echo "(0) LISTEN: Handshake"

MSG=`nc -l $PORT`

HANDSHAKE=`echo $MSG | cut -d " " -f 1`
IP_CLIENT=`echo $MSG | cut -d " " -f 2`
IP_CLIENT_MD5=`echo $MSG | cut -d " " -f 3`

echo "(3) SEND MSG: Comprobacion"

IP_MD5=`echo $IP_CLIENT | md5sum | cut -d " " -f 1`

if [ "$IP_CLIENT_MD5" != "$IP_MD5" ]
then
	echo "ERROR 1: IP Clinete incorrecta"
	exit 1
fi

if [ "$HANDSHAKE" != "HOLI_TURIP" ]
then
	echo "ERROR 1: Handshake incorrecto"

	echo "KO_TURIP" | nc $IP_CLIENT $PORT
	
	exit 1
fi

echo "OK_TURIP" | nc $IP_CLIENT $PORT

echo "(4) LISTEN" 

MSG=`nc -l $PORT`

PREFIX=`echo $MSG | cut -d " " -f 1`
FILE_NAME=`echo $MSG | cut -d " " -f 2`

echo "(7) SEND MSG: "
if [ $PREFIX != "FILE_NAME" ]
then
	echo "ERROR 2: Nombre del archivo mal formado"

	echo "KO_FILE_NAME" | nc $IP_CLIENT $PORT
	
	exit 1 
fi

echo "OK_FILE_NAME" | nc $IP_CLIENT $PORT

echo "(8) LISTEN"

nc -l $PORT >/home/enti/inbox/$FILE_NAME

echo "(10) LISTEN "

MSG=`nc -l $PORT`

if [ "@MSG" = " " ]
then
	echo "KO_FLIE_NUM" | nc $IP_CLIENT $PROT
	exit 1
fi

echo "Ok_FILE_NUM" | nc $IP_CLIENT $PORT

for i in {1. .$MSG}
do
	echo `nc -l $PORT` > archivo$i
done


exit 0 
