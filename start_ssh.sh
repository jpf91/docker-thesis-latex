#!/bin/sh

KEY_RSA="/etc/ssh/keys/ssh_host_rsa_key"
KEY_ECDSA="/etc/ssh/keys/ssh_host_ecdsa_key"
KEY_ED25519="/etc/ssh/keys/ssh_host_ed25519_key"

if [ ! -f "$KEY_RSA" ] ; then
    ssh-keygen -f "$KEY_RSA" -N '' -t rsa
fi

if [ ! -f "$KEY_ECDSA" ]; then
    ssh-keygen -f "$KEY_ECDSA" -N '' -t rsa
fi

if [ ! -f "$KEY_ED25519" ]; then
    ssh-keygen -f "$KEY_ED25519" -N '' -t rsa
fi

exec /usr/sbin/sshd -De
