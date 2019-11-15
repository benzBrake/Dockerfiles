# What is cloud torrent
Cloud torrent(@jpillora/cloud-torrent) is a a self-hosted remote torrent client, written in Go (golang). You start torrents remotely, which are downloaded as sets of files on the local disk of the server, which are then retrievable or streamable via HTTP.

# Usage
1.
```
$ docker run -d -p 3000:3000 -v /path/to/downloads:/downloads benzbrake/cloud-torrent
```

2.Using docker-compose. Download docker-compose.yml to /path/to/downloads and change the download directory.
```
$ cd /path/to/downloads
$ docker-compose up -d
```