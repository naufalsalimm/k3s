# ---> Backup
`k3s etcd-snapshot save --etcd-snapshot-dir=/backup/`

`cat /var/lib/rancher/k3s/server/token`
> K10a756afaa65c99227811fa31378560a77349c1898ee0cc74b1d64cae38a12e88b::server:4b9fd00082e9a9d3b5706c56ebde1137

`cp -r /var/lib/rancher/k3s/storage/pvc-* /backup/`

# ---> Uninstall
`sudo /usr/local/bin/k3s-uninstall.sh`
sudo rm -rf /etc/rancher /var/lib/rancher /etc/systemd/system/k3s*
sudo systemctl daemon-reexec
sudo systemctl daemon-reload

# ---Install
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--cluster-init --disable traefik" sh -

# ---> Restore 
systemctl stop k3s

k3s server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT>
  --token=<BACKED-UP-TOKEN-VALUE>

cp -r /backup/pvc-* /var/lib/rancher/k3s/storage/

systemctl start k3s

# ---> Debug
sudo journalctl -u k3s -b -f

<code>```bash
echo hello
```</code>
