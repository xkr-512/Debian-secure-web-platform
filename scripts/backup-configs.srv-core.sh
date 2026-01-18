#!/usr/bin/env bash
set -euo pipefail

DEST="/backup/configs"
TS="$(date +%F_%H%M%S)"
ARCHIVE="${DEST}/srv-core-configs-${TS}.tar.gz"
LOG="/var/log/backup-configs.log"

# S'assure que le dossier de destination existe
mkdir -p "$DEST"

{
  echo "=== Backup start: $(date -Is) ==="
  echo "Archive: ${ARCHIVE}"

  tar -czf "${ARCHIVE}" \
    /etc/ssh/sshd_config \
    /etc/ssh/sshd_config.d \
    /etc/nftables.conf \
    /etc/rsyslog.conf \
    /etc/hosts \
    /etc/hostname

  echo "Backup OK"
  echo "=== Backup end: $(date -Is) ==="
  echo
} >> "${LOG}" 2>&1
