# Projet 1 — Plateforme Web Debian sécurisée (VirtualBox)

## Objectif
Déployer une mini-infrastructure : serveur socle + serveur web + poste admin.
Sécurité, web (vhosts/HTTPS/reverse proxy), logs centralisés, sauvegardes automatisées.

## Architecture (3 VMs)
- **srv-core** : socle sécurité + centralisation logs + sauvegardes
- **srv-web** : Nginx (vhosts, HTTPS, reverse proxy)
- **cli-admin** : poste d’administration/tests

## Plan d’adressage (Host-Only 192.168.56.0/24)
- srv-core : 192.168.56.10
- srv-web  : 192.168.56.11
- cli-admin: 192.168.56.12

## Contenu du dépôt
- `configs/` : configurations (ssh, nftables, nginx, rsyslog…)
- `systemd/` : unités systemd (.service/.timer)
- `scripts/` : scripts bash
- `docs/proofs/` : preuves (sorties de commandes)
