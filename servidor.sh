#!/bin/bash
echo "Servidor Transfer Unite Recursive Internacional Protocol: TURIP"

echo "(0) LISTEN"
MSG= `nc -l 2223`
IP= "$MSG" | cut -d " " -f 2
HOLI=

if [ "$MSG" != "HOLI_TURIP" ]
then
	echo "ERROR 1: Handshake incorrecto"
	exit 1
fi
