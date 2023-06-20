# qqbot-docker
This project integrates nonebot and go-cqhttp into a Docker image.
## Usage
Please change "/path/to" to your path.
```Bash
git clone https://github.com/yang6world/qqbot-docker.git
```

```Bash
mv -a /path/to/qqbot-docker/nb2 /path/to/nb2
```
Or use 
```Bash
docker run -it -v /path/to/nb:/path/to/nb nonebot nb
```
to create a configuration file
### Docker
```Bash
docker build -t nonebot .
```

```Bash
docker run -d -it -v /path/to/nb2:/root/config/nb nonebot
```
### Docker Compose 
Please modify the docker-compose.yaml file to your requirements.
```Bash
docker-compose up -d
```



