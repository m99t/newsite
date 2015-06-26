: '
#-----------------------------------------------------------------------------------------------------#
|                                                                                                     |
|               __________________                   .___             __  .__                         |
|         _____/   __   \______   \_______  ____   __| _/_ __   _____/  |_|__| ____   ____            |
|        /     \____    /|     ___/\_  __ \/  _ \ / __ |  |  \_/ ___\   __\  |/  _ \ /    \           |
|       |  Y Y  \ /    / |    |     |  | \(  <_> ) /_/ |  |  /\  \___|  | |  (  <_> )   |  \          |
|       |__|_|  //____/  |____|     |__|   \____/\____ |____/  \___  >__| |__|\____/|___|  /          |
|             \/                                      \/           \/                    \/           |
|                                                                                                     |
#-----------------------------------------------------------------------------------------------------#
 
                            [ httpd.conf append script for adding virtualhosts ]
              [ To use this file as a raw command eg. "[root@m9WS-Main ~]# newsite", ]
                      [ issue this command: mv ./newsite.sh /usr/bin/newsite ]
 
                                Title   [      newsite.sh           ]
                                Version [ 1.0                       ]
                                Date    [ 25 - June  - 2015         ]
                                Authors [ Sean Murphy,              ]
'

#Define Vars
serverip="" #Server IP
port="80" #Port
servicename="httpd" #service name of webserver
virtualdir="/var/www/html/" #Default CentOS Apache dir's
confdir="/etc/httpd/conf/httpd.conf" #Default CentOS Apache conf


clear
echo "
               .d8888b.  888b    888                         .d8888b.  d8b 888            
              d88P  Y88b 8888b   888                        d88P  Y88b Y8P 888            
              888    888 88888b  888                        Y88b.          888            
88888b.d88b.  Y88b. d888 888Y88b 888  .d88b.  888  888  888  \"Y888b.   888 888888 .d88b.  
888 \"888 \"88b  \"Y888P888 888 Y88b888 d8P  Y8b 888  888  888     \"Y88b. 888 888   d8P  Y8b 
888  888  888        888 888  Y88888 88888888 888  888  888       \"888 888 888   88888888 
888  888  888 Y88b  d88P 888   Y8888 Y8b.     Y88b 888 d88P Y88b  d88P 888 Y88b. Y8b.     
888  888  888  \"Y8888P\"  888    Y888  \"Y8888   \"Y8888888P\"   \"Y8888P\"  888  \"Y888 \"Y8888  
"

echo -e "Adding a newsite to '$confdir' \n\n"

echo "Please enter the folder name in '$virtualdir'"
read folder

echo "Enter the Domain that will use this virtual host"
read domain

echo "Enter any aditional aliases or press enter for none"
read alias

if [ "$alias" == "" ]
then
echo "
<VirtualHost $serverip:$port>
    DocumentRoot \"$virtualdir$folder\"
    ServerName $domain
</virtualhost>
" >> $confdir

else
echo "
<VirtualHost $serverip:$port>
    DocumentRoot \"$virtualdir$folder\"
    ServerName $domain
    ServerAlias $alias
</virtualhost>
" >> $confdir
fi

echo "Reloading $servicename"
service $servicename reload
echo "Reloaded"
