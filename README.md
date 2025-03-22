# ppa

```shell
curl -s --compressed "https://train360-corp.github.io/ppa/packages/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/train360-corp-ppa-key.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/train360-corp-packages.list "https://train360-corp.github.io/ppa/packages/packages.list"
sudo apt update
```