#!/bin/sh
#################################################################################################################################
###                          Installation Wordpress                             ##              index                                                             
### Simple script to automate the installation of WordPress on Ubuntu/Debian.   ## 1. Starting the script.
### the package do most of the hard work, so this script can be small-ish and   ## 2. install Apache mariadb-client wget gnupg.
###lazy-ish.																	## 3. security of showing apache version.
###                                                                             ## 4. Installation PhP.
### WARNING: Anything not listed in the currently supported systems list is not ## 5. Installation Php7.4 Mysql and Libapache2 
###                                                                             ##    to connect Wordpress to server MariaDB.
### going to work, despite the fact that you might see code that detects your   ## 6. Wordpress Installation.
### OS and acts on it.  If it isn't in the list, the code is not complete a     ## 7. Go to the folder.
### will not work.  More importantly, the repos that this script uses do not    ## 8. Un-tar Wordpress dans notre dossier.
### exist, if the OS isn't listed.  Don't even bother trying it.                ## 9. We Give the right rights on Wordpress.
### Version=V1 By KHALIFA S. 08JUNE2022                                         ## 10. Modifey the config of WP-Config.
### Version=V1.2 By KHALIFA S. 10JUNE2022                                       ## 11. change the rights on WP-Config.
###                                                                             ## 12. Add confs SSL.
###                                                                             ## 13. Create file apache2 confs for our wordpress.
####################################################################################
## 1. Starting the script ##
############################
##Mise à jour des paquets 
sudo apt update ; sudo apt upgrade -y ; sudo apt full-upgrade -y
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "System up to date"
  else
    printf  "%s\n" "Ouch, the Probleme is in 1. Starting the script"
  exit 1;
fi
#################################################
## 2. install Apache mariadb-client wget gnupg ##
#################################################
sudo apt -y install wget apache2 gnupg mariadb-client && systemctl status apache2
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "Packages installed"
  else
    printf "%s\n" "Ouch, the Probleme is in 2. install Apache mariadb-client wget gnupg"
  exit 1;
fi
###########################################
## 3. security of showing apache version ##
###########################################
sudo echo "ServerTokens Prod" >> /etc/apache2/apache2.conf
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "YES NOONE GONNA NOW :D"
  else
    printf "%s\n" "Ouch, the Probleme is in 3. security of showing apache version (Secret is out)"
  exit 1;
fi
#########################
## 4. Installation PhP ##
#########################
## Add depo to depolist
sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "Packages installed"
  else
    printf "%s\n" "Ouch, the Probleme is in 4. Installation PhP"
  exit 1;
fi
## We fitch PHP depo 
sudo wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "Packages installed"
  else
    printf "%s\n" "Ouch, the Probleme is in 4. Installation PhP"
  exit 1;
fi
## Installation Php7.4
sudo apt update && sudo apt upgrade -y && sudo apt-get install -y php7.4 php7.4-common php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-mysql php7.4-dev php7.4-cli php7.4-cgi php7.4-soap php7.4-intl php7.4-zip php7.4-fpm && phpenmod -v 7.4 gd mbstring curl xml mysqli soap intl zip ;
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "Packages installed"
  else
    printf "%s\n" "Ouch, the Probleme is in 4. Installation PhP"
  exit 1;
fi
########################################################################################
## 5. Installation Php7.4 Mysql and Libapache2 to connect Wordpress to server MariaDB ##
########################################################################################
apt-get install php-mysql -y && apt-get install libapache2-mod-php7.4 -y
################
##condition If##
################
if [ "$?" -eq "0" ]; then
    printf "Packages installed"
  else
    printf "%s\n" "Ouch, the Probleme is in  5. Installation Php7.4 Mysql and Libapache2"
  exit 1;
fi
###############################
## 6. Wordpress Installation ##
###############################
## Creation of a folder in home
mkdir /home/itachi/sites
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "Folder created"
  else
    printf "%s\n" "Ouch, the Probleme is in 6. Wordpress Installation"
  exit 1;
fi
##########################################################################
## 7. Go to the folder to make sure its there and excute the CMDs there ## 
##########################################################################
cd  /home/itachi/sites
################
##condition If##
################
if [ "$?" -eq "0" ]; then
    printf "Yaaay we have arrived"
  else
    printf "%s\n" "Ouch, the Probleme is in 7. Go to the folder to make sure its there and excute the CMDs there(Folder not found)"
  exit 1;
fi
############################################
## 8. Un-tar Wordpress dans notre dossier ##
############################################
sudo tar -zxvf latest.tar.gz
################
##condition If##
################
if [ "$?" -eq "0" ]; then
    printf "Yaaay Package Untarrred"
  else
    printf "%s\n" "Ouch, the Probleme is in 8. Un-tar Wordpress dans notre dossier"
  exit 1;
fi
##############################################
## 9. We Give the right rights on Wordpress ##
##############################################
sudo find  /home/itachi/sites/wordpress -type d -exec chmod 755 {} \; && sudo find  /home/itachi/sites/wordpress -type f -exec chmod 644 {} \; && sudo chown itachi:itachi -R  /home/itachi/sites/wordpress && sudo cp  /home/itachi/sites/wp-config-sample.php  /home/itachi/sites/wp-config.php 
################
##condition If##
################
if [ "$?" -eq "0" ]; then
    printf "Yaaay Folder Rights is ALSO IMPORTANT RIGHTS :d"
  else
    printf "%s\n" "Ouch, the Probleme is in 9. We Give the right rights on Wordpress (We Are Blocked) "
  exit 1;
fi
#########################################
## 10. Modifey the config of WP-Config ##
#########################################
## Chang database name
echo "What is the name of your database?!"
read namedatabase
sed  -i.bak -e 's/database_name_here/$namedatabase/'  /home/itachi/sites/wordpress/wp-config.php
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "Yaaay DONE :d"
  else
    printf "%s\n" "Ouch, the Probleme is in 10. Modifey the config of WP-Config(Change is imposible) "
  exit 1;
fi
##change User 
echo "Who gonna use this database?!"
read nameuser
sed  -i.bak -e 's/DB_USER/$nameuser/' /home/itachi/sites/wordpress/wp-config.php
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "Yaaay DONE :d"
  else
    printf "%s\n" "Ouch, the Probleme is in 10. Modifey the config of WP-Config(Change is imposible) "
  exit 1;
fi
##change Password 
echo "Please use your strongest password, if you cant create one, i invite you to try: https://passwordsgenerator.net/ "
read namepassword
sed  -i.bak -e 's/DB_PASSWORD/$namepassword/' /home/itachi/sites/wordpress/wp-config.php
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "Yaaay DONE :d"
  else
    printf "%s\n" "Ouch, the Probleme is in 10. Modifey the config of WP-Config (your passowrd is weak) "
  exit 1;
fi
##change Host 
echo "Where is Our server MariaDB?!"
read namehost
sed  -i.bak -e 's/DB_HOST/$namehost/' /home/itachi/sites/wordpress/wp-config.php
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "Yaaay DONE :d"
  else
    printf "%s\n" "Ouch Change is imposible "
  exit 1;
fi
########################################
## 11. change the rights on WP-Config ##
########################################
sudo chmod 000 /home/itachi/sites/wordpress/wp-config-sample.php && sudo chmod 444 /home/itachi/sites/wordpress/wp-config.php
################
##condition If##
################
if [ "$?" -eq "0" ]; then
    printf "Yaaay We HAVE THE POWER hahaha :d"
  else
    printf "%s\n" "Ouch, the Probleme is in 11. change the rights on WP-Config"
  exit 1;
fi
##Restart apache2
sudo systemctl restart apache2
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "YES DONE :d"
  else
    printf "%s\n" "Ouch We Are Blocked in 11. change the rights on WP-Config "
  exit 1;
fi
#######################
## 12. Add confs SSL ##
#######################
sudo apt-get install certbot -y && sudo a2enmod ssl && sudo a2enmod rewrite && sudo systemctl reload apache2
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "Yaaay We HAVE THE Let's Encrypt POWER hahaha :d"
  else
    printf "%s\n" "Ouch, the Probleme is in 12. Add confs SSL (We gonna be Hacked)"
  exit 1;
fi
#####################################################
## 13. Create file apache2 confs for our wordpress ##
#####################################################
echo "What you Wanna call your Site?!"
read namesite
sudo touch /etc/apache2/sites-available/$namesite.conf 
echo " 
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com
        ServerAdmin webmaster@localhost
        ServerName $namesite
        RewriteEngine On
        RewriteCond %{HTTPS} !=on
        RewriteRule ^/?(.*) https://%{SERVER_NAME}/$1 [R=301,L]
        DocumentRoot /home/itachi/sites/wordpress/
        <Directory />
        Options FollowSymLinks
        AllowOverride None
        </Directory>
        <Directory /home/itachi/sites/wordpress/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
        Require all granted
        </Directory>
        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn
        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
<VirtualHost *:443>
        ServerAdmin webmaster@localhost
        ServerName $namesite
        DocumentRoot /home/itachi/sites/wordpress/
        <Directory />
        Options FollowSymLinks
        AllowOverride None
        </Directory>
        <Directory /home/itachi/sites/wordpress/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
        Require all granted
        </Directory>
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        LogLevel warn
#        SSLEngine on
#        SSLCertificateFile /etc/letsencrypt/live/$namesite/fullchain.pem
#        SSLCertificateKeyFile /etc/letsencrypt/live/$namesite/privkey.pem
</VirtualHost> " > /etc/apache2/sites-available/$namesite.conf
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "Yaaay DONE :d"
  else
    printf "%s\n" "Ouch, the Probleme is in 13. Create file apache2 confs for our wordpress"
  exit 1;
fi
##Make apache2 validate our configuration file
sudo a2ensite $namesite.conf && sudo systemctl reload apache2 
##################
## condition If ##
##################
if [ "$?" -eq "0" ]; then
    printf "Yaaay Cool just one step and we are there :D"
  else
    printf "%s\n" "Ouch, the Probleme is in 13. Create file apache2 confs for our wordpress (Apache2 hates US)"
  exit 1;
fi
#########################
##Installation Finished##
#########################
printf "COOL, Instllation Finished, You did a Good Job"
###########
##THE END##
###########