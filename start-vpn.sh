#!/usr/bin/env bash

echo $VPN_PASSWORD | sudo openconnect \
	--background \
	--passwd-on-stdin \
	--protocol=anyconnect \
	--user=$VPN_USERNAME@vpn.colab.ciscops.net \
	 cpn-vpn-mkdqgqzprv.dynamic-m.com