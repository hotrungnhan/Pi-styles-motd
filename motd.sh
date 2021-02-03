
#!/bin/bash

upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
secs=$((${upSeconds}%60))
mins=$((${upSeconds}/60%60))
hours=$((${upSeconds}/3600%24))
days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

# get the load averages
read one five fifteen rest < /proc/loadavg                                                                                                          
echo "$(tput setaf 2)
        #     #                                                     ######  ###     # 
        #  #  #  ######  #        ####    ####   #    #  ######    #     #   #      # 
        #  #  #  #       #       #    #  #    #  ##  ##  #         #     #   #      #  
        #  #  #  #####   #       #       #    #  # ## #  #####     ######    #      #  
        #  #  #  #       #       #       #    #  #    #  #         #         #      #
        #  #  #  #       #       #    #  #    #  #    #  #         #         #     ### 
         ## ##   ######  ######   ####    ####   #    #  ######    #        ###    ###                                                                  
   .~~.   .~~.    `date "+%A,%d %B %Y,%H:%M:%S"`
  '. \ ' ' / .'   `lsb_release -s -d` (`uname -srm`) $(tput setaf 1) 
   .~ .~~~..~.    CPU................: $(tput setaf 3)`cat /proc/cpuinfo | grep 'model name' | head -1 | cut -d':' -f2|tail -c +2`$(tput setaf 1) 
  : .~.'~'.~. :   Memory.............: $(tput setaf 3)`free -m | head -n 2 | tail -n 1 | awk {'print $7'}`MB (Availiable) / `free -m | head -n 2 | tail -n 1 | awk {'print $2'}`MB (Total) $(tput setaf 1) 
 ~ (   ) (   ) ~  Disk...............: $(tput setaf 3)`df -h / | awk '{ a = $4 } END { print a }'`B (Availiable) / `df -h / | awk '{ a = $2 } END { print a }'`B (Total) $(tput setaf 1) 
( : '~'.~.'~' : ) Uptime.............: $(tput setaf 3)${UPTIME} $(tput setaf 1) 
 ~ .~ (   ) ~. ~  Load Averages......: $(tput setaf 3)${one}, ${five}, ${fifteen} (1, 5, 15 min) $(tput setaf 1) 
  (  : '~' :  )   Running Processes..: $(tput setaf 3)`ps ax | wc -l | tr -d " "`  $(tput setaf 1) 
   '~ .~~~. ~'    Local IP Addresses.: $(tput setaf 3)`ifconfig wlan0 | grep "inet" | awk  '{printf $2;exit}'` $(tput setaf 7)and$(tput setaf 3) `ifconfig wlan0 | grep "inet6" | awk  '{printf $2;exit}'`$(tput setaf 1)  
       '~'        Public IP Addresses: $(tput setaf 3)`curl -s 'https://api.myip.com' |python3 -c "import sys, json; print(json.load(sys.stdin)['ip'])"`$(tput setaf 1) 
                  Last login.........: $(tput setaf 3)`last "$USER" -d -x iso  --time-format iso -2| awk 'FNR == 2 {printf $4;exit}'|python3 -c "from datetime import datetime;import sys; print(datetime.strptime(sys.stdin.read()
,'%Y-%m-%dT%H:%M:%S%z').strftime('%A, %d %B %Y, %H:%M:%S'))"`
                                       (`last "$USER" -2 -a --time-format notime|awk 'FNR == 2 {printf $4;exit}'`)
$(tput sgr0)"