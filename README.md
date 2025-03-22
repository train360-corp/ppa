# ppa

```shell
curl -fsSL https://train360-corp.github.io/ppa/packages/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/train360-corp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/train360-corp-archive-keyring.gpg] https://train360-corp.github.io/ppa/packages ./" | sudo tee /etc/apt/sources.list.d/packages.list
sudo apt update
```