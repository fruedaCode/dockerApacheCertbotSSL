#Imagen Docker con Ubuntu + apache2 + Certbot SSL

##Apache con redireccion de http a https y un proxypass para el backend
Bajo el directorio apacheConf se encuentran los directorios organizados por entornos.
El nombre de este directorio hay que pasarlo como build-arg cuando se ejecute el docker build.

##ARG docker-build
ENVIROMENT: Directorio donde hay que poner los certificados y los ficheros de configuración

##Variables de entorno:
PROXY_PASS_URL : URL a la que se hará el forward
SERVER_NAME: Nombre del dominio del servidor


##Ficheros con los certificados necesarios
cert.pem: Certificado publico
chain.pem: CA certificadora
privkey.pem: Certificado privado

