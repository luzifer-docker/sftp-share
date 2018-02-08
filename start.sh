#!/usr/local/bin/dumb-init /bin/bash
set -euo pipefail

COLOR_CYAN="\033[0;36m"
COLOR_PLAIN="\033[0m"

function info {
  echo -e "${COLOR_CYAN}$@${COLOR_PLAIN}"
}

function step {
    info "[$(date +%H:%M:%S)] $@"
}

step "Checking SSH host keys..."
for type in rsa dsa ecdsa ed25519; do
  if ! [ -e "/ssh/ssh_host_${type}_key" ]; then
    info "Generating /ssh/ssh_host_${type}_key..."
    ssh-keygen -f "/ssh/ssh_host_${type}_key" -N '' -t ${type} 2>&1 >/dev/null
  fi

  ln -sf "/ssh/ssh_host_${type}_key" "/etc/ssh/ssh_host_${type}_key"
done

step "Checking user for existence..."
if ( id ${USER} 2>/dev/null ); then
    info "INFO: User ${USER} already exists"
else
    info "INFO: User ${USER} does not exists, we create it"
    ENC_PASS=$(echo ${PASS} | openssl passwd -1 -stdin)
    useradd -d /data -m -p ${ENC_PASS} -u ${USER_UID} -s /bin/sh ${USER}
    echo
    info "User \"${USER}\" created with password \"${PASS}\"."
    echo
fi

step "Running SSHd..."
exec /usr/sbin/sshd -D
