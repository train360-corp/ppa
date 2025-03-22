# ppa

Train360, Corp. Archlinux PPA

## Add Signing Key

```shell
curl -fsSL https://train360-corp.github.io/ppa/packages/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/train360-corp-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/train360-corp-keyring.gpg] https://train360-corp.github.io/ppa/packages ./" | sudo tee /etc/apt/sources.list.d/train360-corp-packages.list
sudo apt update
```