# pgyvpn
蒲公英VPN最小镜像，目前仅支持amd64

# 食用方式
```
docker run -d \
  --restart=always \
  --device=/dev/net/tun \
  --net=host \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_ADMIN \
  --env PGY_USERNAME=蒲公英用户名 \
  --env PGY_PASSWORD=蒲公英密码 \
  --name pgyvpn \
  benzbrake/pgyvpn
```