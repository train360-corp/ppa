# ppa

```shell
curl -s --compressed "https://train360-corp.github.io/ppa/packages/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/train360-corp-ppa-key.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/train360-corp-packages.list "https://train360-corp.github.io/ppa/packages/packages.list"
sudo apt update
```

```shell
curl -fsSL https://train360-corp.github.io/ppa/packages/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/train360-corp-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/train360-corp-keyring.gpg] https://train360-corp.github.io/ppa/packages ./" | sudo tee /etc/apt/sources.list.d/packages.list
sudo apt update
```