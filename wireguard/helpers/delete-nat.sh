#!/bin/bash
IPT="/usr/sbin/iptables"
 
IN_FACE="eth1"                   # NIC connected to the internet
WG_FACE="wg0"                    # WG NIC 
SUB_NET="<>"            # WG IPv4 sub/net aka CIDR
FOROGH_SUB_NET="<>"            # WG IPv4 sub/net aka CIDR
WG_PORT="41194"                  # WG udp port
 
# IPv4 rules #
$IPT -t nat -D POSTROUTING -s $SUB_NET -o $IN_FACE -j MASQUERADE
$IPT -t nat -D POSTROUTING -s $FOROGH_SUB_NET -o $IN_FACE -j MASQUERADE
$IPT -D INPUT -i $WG_FACE -j ACCEPT
$IPT -D FORWARD -i $IN_FACE -o $WG_FACE -j ACCEPT
$IPT -D FORWARD -i $WG_FACE -o $IN_FACE -j ACCEPT
$IPT -D INPUT -i $IN_FACE -p udp --dport $WG_PORT -j ACCEPT
