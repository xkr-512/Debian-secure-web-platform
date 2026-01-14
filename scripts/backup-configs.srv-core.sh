#!/usr/bin/env bash
set -euo pipefail

DEST="/backup/configs"
TS="$(date +%F_%H%M%S)"
ARCHIVE="${DEST}/srv-core-configs-${TS}.tar.gz"
LOG="/var/log/backup-configs.log"

{
  echo "=== Backup start: $(date -Is) ==="
  echo "Archive: ${ARCHIVE}"

  tar -czf "${ARCHIVE}" \
    /etc/ssh/sshd_config \
    /etc/nftables.conf \
    /etc/rsyslog.conf \
    /etc/hosts \
    /etc/hostname

  echo "Backup OK"
  echo "=== Backup end: $(date -Is) ==="
  echo
} | sudo tee -a "${LOG}" >/dev/null
