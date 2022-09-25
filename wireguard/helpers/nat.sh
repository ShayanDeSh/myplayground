#!/bin/bash
IPT="/usr/sbin/iptables"
 
IN_FACE="eth1"                   # NIC connected to the internet
WG_FACE="wg0"                    # WG NIC 
SUB_NET="<>"            # WG IPv4 sub/net aka CIDR
FOROGH_SUB_NET="<>"            # WG IPv4 sub/net aka CIDR
WG_PORT="41194"                  # WG udp port
 
## IPv4 ##
$IPT -t nat -I POSTROUTING 1 -s $SUB_NET -o $IN_FACE -j MASQUERADE
$IPT -t nat -I POSTROUTING 1 -s $FOROGH_SUB_NET -o $IN_FACE -j MASQUERADE
$IPT -I INPUT 1 -i $WG_FACE -j ACCEPT
$IPT -I FORWARD 1 -i $IN_FACE -o $WG_FACE -j ACCEPT
$IPT -I FORWARD 1 -i $WG_FACE -o $IN_FACE -j ACCEPT
$IPT -I INPUT 1 -i $IN_FACE -p udp --dport $WG_PORT -j ACCEPT