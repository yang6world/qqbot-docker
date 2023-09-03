# qqbot-docker
This project integrates nonebot and go-cqhttp into a Docker image.
## Usage
Please change "/path/to" to your path.
```Bash
git clone https://github.com/yang6world/qqbot-docker.git
```

```Bash
cd qqbot-docker
```


### Docker
```Bash
docker build -t nonebot .
```

```Bash
docker run -it -v /path/to:/path/to -w /path/to/nb nonebot nb
```
to create a configuration file

```Bash
docker run --name=nonebot --network=host -d -it -v /path/to/nb:/path/to/nb -w /path/to/nb nonebot
```
### Docker Compose 
Please modify the docker-compose.yaml file to your requirements.
```Bash
docker-compose up -d
```



