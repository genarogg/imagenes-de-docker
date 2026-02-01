# saber si wireguardian (wg) esta funcionado

wg show

# verificar la ip asignada por wg
ip a show wg0

# verificar que esta llegando por ese puerto (en el servidor)

tcpdump -i any port 8000 -> se debe de cambiar el puerto por el que se quiera escuchar
tcpdump -i eth0 port 8000 -> interfas por la que se escucha


# los Endpoint en los archivos de conexion 