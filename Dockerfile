FROM lzrbear/docker-apache2-ubuntu

ARG ENVIROMENT

##Estos comandos solo son necesarios para la instalacion del certificado SSL
#RUN apt-get update
#RUN apt-get -y install wget
#RUN wget https://dl.eff.org/certbot-auto
#RUN chmod a+x certbot-auto
#####

RUN a2enmod ssl
RUN a2enmod rewrite
RUN a2enmod proxy
RUN a2enmod proxy_http

COPY ./src/main/webapp/dist/ /var/www/html/

#Configuración de apache por defecto. Redireccion a https
COPY ./apacheConf/$ENVIROMENT/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./apacheConf/$ENVIROMENT/000-default.conf /etc/apache2/sites-enabled/000-default.conf

#Configurcion https y proxy a /ia
COPY ./apacheConf/$ENVIROMENT/000-default-le-ssl.conf /etc/apache2/sites-available/000-default-le-ssl.conf
COPY ./apacheConf/$ENVIROMENT/000-default-le-ssl.conf /etc/apache2/sites-enabled/000-default-le-ssl.conf
COPY ./apacheConf/$ENVIROMENT/options-ssl-apache.conf /etc/letsencrypt/options-ssl-apache.conf

#Certificados
COPY ./apacheConf/$ENVIROMENT/cert.pem /etc/letsencrypt/cert.pem
COPY ./apacheConf/$ENVIROMENT/privkey.pem /etc/letsencrypt/privkey.pem
COPY ./apacheConf/$ENVIROMENT/chain.pem /etc/letsencrypt/chain.pem

#Este comando hay que ejecutarlo manualmente dentro del pod. Solo se hace la primera vez para renovar/crear un certificado nuevo
#CMD ./certbot-auto --non-interactive --agree-tos --redirect --email frueda@profile.es --apache --domains $DOMAINS

#docker run -d -e IA_URL_BACKEND=http://192.168.1.118:8080/ -e SERVER_NAME=pre.ia.profile-agile.it -p 80:80 -p 443:443 --name iafront -v C:\Developer\sts-profile\workspace\iaprofile\frontend\src\main\webapp:/usr/local/apache2/htdocs iafront