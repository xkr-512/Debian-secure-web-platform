## Plateforme Web Debian sécurisée (VirtualBox)

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
- `configs/systemd/` : unités systemd (.service/.timer)
- `scripts/` : scripts bash
- `docs/proofs/` : preuves (sorties de commandes)

## Backups (srv-core)
- Script: `scripts/backup-configs.srv-core.sh`
- systemd: `configs/systemd/backup-configs.service` + `.timer`
- Restore test: extraction de `etc/nftables.conf` depuis la dernière archive vers `/tmp/restore-test/` (voir `docs/proofs/backup-restore-*`)

## VMs
- cli-admin : 192.168.56.12 (poste d’admin / tests)
- srv-core  : 192.168.56.10 (services internes + logs + backups)
- srv-web   : 192.168.56.11 (Nginx en frontal HTTPS + reverse proxy)

## Sécurité mise en place (résumé)
- SSH : clés uniquement (PasswordAuthentication no) + fail2ban sshd
- Firewall : nftables policy drop + ouverture minimale des ports
- Web : HTTPS autosigné + redirection HTTP→HTTPS + headers sécurité
- Reverse proxy : app.site1.lab → srv-core:8080 (interne)
- /admin : BasicAuth + fail2ban nginx-http-auth (ban automatique)

## Tests rapides (preuves dans docs/proofs)
- HTTP→HTTPS : `curl -I http://site1.lab`
- HTTPS OK : `curl -k -I https://site1.lab`
- Reverse proxy : `curl -k https://app.site1.lab/`
- /admin sans creds : `curl -k -I https://site1.lab/admin/` (401)
- /admin avec creds : `curl -k -u demo:*** https://site1.lab/admin/`
- Ban fail2ban : après plusieurs mauvais logins → IP bannie (voir proof)
