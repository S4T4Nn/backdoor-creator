#!/bin/bash

chmod +x back.sh

echo "Vc ja tem o metasploit instalado?"
read -p "s/n >> " p1
case "$p1" in
	s)
		echo "instalando..."
		apt-get install figlet dex2jar -y
		clear
		figlet Download completo
	;;

	n)
		echo "instalando..."
		apt-get install figlet dex2jar metasploit-framework -y
                clear
                figlet Download completo
	;;
esac
