#!/bin/bash
echo Script para el examen de redes
sleep 2
yum -y install postfix
yum -y install dovecot
yum -y install httpd
yum -y install vsftpd
yum -y install nfs-utils
yum -y install nfs-utils-lib
yum -y install portmap
yum -y install bind
yum -y install git
service iptables stop
mkdir /root/Escritorio/Arch_Originales
cp /etc/httpd/conf/httpd.conf /root/Escritorio/Arch_Originales/
cp /etc/hosts /root/Escritorio/Arch_Originales/
cp /etc/dhcp/dhcpd.conf /root/Escritorio/Arch_Originales/
cp /etc/rsyslog.conf /root/Escritorio/Arch_Originales/
echo recuerda cambiar el RunLevel en /etc/inittab y ponerlo en lo que te pidan
sleep 6
cd /root/Escritorio/
mkdir BK1
mkdir BK2
cd BK1/
wget https://github.com/LystSky/SV1-de-redes/archive/master.zip
unzip master.zip
cd SV1-de-redes-master/
cat dhcpd.bk > /etc/httpd/conf/httpd.conf
cat hosts.bk > /etc/hosts
cat httpd.bk > /etc/dhcp/dhcpd.conf
cd rsyslog.bk > /etc/rsyslog.conf
cd /root/Escritorio/BK1
wget https://github.com/LystSky/SV2-de-redes/archive/master.zip
unzip master.zip
cd SV2-de-redes-master/
cp /etc/vsftpd/vsftpd.conf /root/Escritorio/Arch_Originales/
cp /etc/exports /root/Escritorio/Arch_Originales/
cp /etc/named.conf /root/Escritorio/Arch_Originales/
cp /etc/rsyslog.conf /root/Escritorio/Arch_Originales/
cp /etc/resolv.conf /root/Escritorio/Arch_Originales/
cat vsftpd.bk > /etc/vsftpd/vsftpd.conf
touch /etc/vsftpd/chroot_list
setsebool -P ftp_home_dir=1
groupadd FTP
mkdir /home/Programador
mkdir /home/Analista
echo creando los usuarios
useradd -G FTP -c UsuarioFTP -s /sbin/nologin -d /home/Programador Programador1
useradd -G FTP -c UsuarioFTP -s /sbin/nologin -d /home/Programador Programador2
useradd -G FTP -c UsuarioFTP -s /sbin/nologin -d /home/Analista Analista1
useradd -G FTP -c UsuarioFTP -s /sbin/nologin -d /home/Analista Analista2
cd /var/
mkdir Programadores
mkdir Analista
chmod 777 Programadores/
chmod 777 Analista/
cat exports.bk > /etc/exports
exportfs -r
exportfs -v
service rpcbind restart
service nfs restart
echo se terminó de configurar el NFS
sleep 5
cat /root/Escritorio/Mibackup/named.bk > /etc/named.conf
cd /var/named/
touch noshutdown.cl.zone
touch noshutdown.cl.inver
cp /var/named/noshutdown.cl.zone /root/Escritorio/Arch_Originales/
cp /var/named/noshutdown.cl.inver /root/Escritorio/Arch_Originales/
cat noshutdown.cl.inver.bk > /var/named/noshutdown.cl.inver
cat noshutdown.cl.zone.bk > /var/named/noshutdown.cl.zone
cat /root/Escritorio/Mibackup/resolv.bk > /etc/resolv.conf
service named restart
echo el DNS está listo
sleep 5
cat rsyslog.bk > /etc/rsyslog.conf
service rsyslog restart
echo Gracias por su paciencia
sleep 5
echo Recuerda esta configuracion esta pensado para un servidor con la IP 172.16.1.10 si vas a usar mira el script y dirigete hacia donde estan los archivos modificados y cambia a la ip que necesites...
sleep 10
yum -y install nfs-utils
yum -y install nfs-utils-lib
yum -y install portmap
cd /home/
mkdir Almacen
mkdir Traspaso
service rpcbind restart
service nfs restart
mount 172.16.1.10:/var/Programadores /home/Traspaso/
mount 172.16.1.10:/var/Analista /home/Almacen/
service rpcbind restart
service nfs restart
service rsyslog restart
service httpd restart
service httpd restart
service dhcpd restart
service vsftpd restart
service rpcbind restart
service nfs restart
service rpcbind restart
service nfs restart
service named restart
service rsyslog restart
