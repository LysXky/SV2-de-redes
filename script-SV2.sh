#!/bin/bash
echo Esto es un script para el servidor 2 con los servicios de FTP - NFS - DNS -Rsyslog configurados...
sleep 7
echo Se instalarán ahora los paquetes que necesita este servidor...
sleep 5
#FTP
yum -y install vsftpd
#NFS
yum -y install nfs-utils
yum -y install nfs-utils-lib
yum -y install portmap
#DNS
yum -y install bind
yum -y install git
echo paquetes instalados...
sleep 3
mkdir /root/Escritorio/Mibackup
git clone https://github.com/LystSky/SV2-de-redes.git /root/Escritorio/Mibackup
echo se descargó de GitHub las configuraciones para las maquinas...
sleep 5
echo por favor espere...
sleep 5
echo se realizará un Backup de sus configuraciones originales para que pueda dejar todo como estaba...
sleep 7
echo la carpeta quedará en el escritorio
sleep 5
mkdir /root/Escritorio/Arch_Originales
cp /etc/vsftpd/vsftpd.conf /root/Escritorio/Arch_Originales/
cp /etc/exports /root/Escritorio/Arch_Originales/
cp /etc/named.conf /root/Escritorio/Arch_Originales/
cp /etc/rsyslog.conf /root/Escritorio/Arch_Originales/
cp /etc/resolv.conf /root/Escritorio/Arch_Originales/
echo comenzará la copia de los archivos de GitHub
cat /root/Escritorio/Mibackup/vsftpd.bk > /etc/vsftpd/vsftpd.conf
touch /etc/vsftpd/chroot_list
service vsftpd restart
setsebool -P ftp_home_dir=1
groupadd FTP
echo creando las carpetas para los usuarios que solicitaron
sleep 5
mkdir /home/Programador
mkdir /home/Analista
echo creando los usuarios
useradd -G FTP -c UsuarioFTP -s /sbin/nologin -d /home/Programador Programador1
useradd -G FTP -c UsuarioFTP -s /sbin/nologin -d /home/Programador Programador2
useradd -G FTP -c UsuarioFTP -s /sbin/nologin -d /home/Analista Analista1
useradd -G FTP -c UsuarioFTP -s /sbin/nologin -d /home/Analista Analista2
echo se terminó las configuraciones del FTP
sleep 5
#NFS*
service rpcbind restart
service nfs restart
cd /var/
mkdir Programadores
mkdir Analista
chmod 777 Programadores/
chmod 777 Analista/
cat /root/Escritorio/Mibackup/exports.bk > /etc/exports
exportfs -r
exportfs -v
service rpcbind restart
service nfs restart
echo se terminó de configurar el NFS
sleep 5
#DNS*
cat /root/Escritorio/Mibackup/named.bk > /etc/named.conf
cd /var/named/
touch noshutdown.cl.zone
touch noshutdown.cl.inver
cp /var/named/noshutdown.cl.zone /root/Escritorio/Arch_Originales/
cp /var/named/noshutdown.cl.inver /root/Escritorio/Arch_Originales/
cat /root/Escritorio/Mibackup/noshutdown.cl.inver.bk > /var/named/noshutdown.cl.inver
cat /root/Escritorio/Mibackup/noshutdown.cl.zone.bk > /var/named/noshutdown.cl.zone
cat /root/Escritorio/Mibackup/resolv.bk > /etc/resolv.conf
service named restart
echo el DNS está listo
sleep 5
#RSYSLOG*
cat /root/Escritorio/Mibackup/rsyslog.bk > /etc/rsyslog.conf
service rsyslog restart
logger "PEP2 de ASS"
echo revisa los log del SV1 para ver si te llegó el mensaje /var/log/message
sleep 10
echo Gracias por su paciencia
sleep 5
echo Recuerda esta configuracion esta pensado para un servidor con la IP 172.16.1.10 si vas a usar mira el script y dirigete hacia donde estan los archivos modificados y cambia a la ip que necesites...
sleep 20
