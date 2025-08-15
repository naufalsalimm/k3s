# ---> Backup
``` bash
k3s etcd-snapshot save --etcd-snapshot-dir=/backup/
```
``` bash
cat /var/lib/rancher/k3s/server/token
```
> K10a756afaa65c99227811fa31378560a77349c1898ee0cc74b1d64cae38a12e88b::server:4b9fd00082e9a9d3b5706c56ebde1137
``` bash
cp -r /var/lib/rancher/k3s/storage/pvc-* /backup/
```
# ---> Uninstall
``` bash
sudo /usr/local/bin/k3s-uninstall.sh
sudo rm -rf /etc/rancher /var/lib/rancher /etc/systemd/system/k3s*
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
```

# ---Install
``` bash
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--cluster-init --disable traefik" sh -
```
# ---> Restore 
``` bash
systemctl stop k3s
```
``` bash
k3s server \
  --cluster-reset \
  --cluster-reset-restore-path=<PATH-TO-SNAPSHOT>
  --token=<BACKED-UP-TOKEN-VALUE>
```
``` bash
cp -r /backup/pvc-* /var/lib/rancher/k3s/storage/
```
``` bash
systemctl start k3s
```
# ---> Debug
``` bash
sudo journalctl -u k3s -b -f
```
