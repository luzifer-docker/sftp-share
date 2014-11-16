#!/bin/bash

ENC_PASS=$(perl -e 'print crypt($ARGV[0], "password")' ${PASS})

if ( id ${USER} ); then
  echo "FATAL: User ${USER} already exists"
  exit 1
fi

useradd -d /data -m -p ${ENC_PASS} -s /bin/false ${USER}

exec /usr/sbin/sshd
