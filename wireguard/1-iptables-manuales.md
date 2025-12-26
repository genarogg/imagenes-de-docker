## Nota: ya que esta en salida de host(para que funcion con la red del vps y no la de docker)

# paquete para persistencia de iptables

apt-get install iptables-persistent

# Permitir tráfico WireGuard → Internet

iptables -I DOCKER-USER 1 -i wg0 -o eth0 -j ACCEPT

# Permitir tráfico de respuesta Internet → WireGuard

iptables -I DOCKER-USER 2 -i eth0 -o wg0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# NAT de salida (obligatorio para navegar)

iptables -t nat -I POSTROUTING 1 -s 10.8.0.0/24 -o eth0 -j MASQUERADE

###########################################################################
(cambiar puerto por deseado) (se cambia la interfaz de wg)

# DNAT: exponer el puerto 3000 

iptables -t nat -I PREROUTING 1 -i eth0 -p tcp --dport 8000 \
 -j DNAT --to-destination 10.8.0.4:8000

# Permitir forward hacia el cliente WG

iptables -I FORWARD 1 -p tcp -d 10.8.0.4 --dport 8000 -j ACCEPT
iptables -I FORWARD 2 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Luego guardas

netfilter-persistent save
