FROM ubuntu:latest

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ARG LiteLoaderQQNT
ARG LiteLoaderQQNTBot
ARG CPU_TYPE=amd64
ENV HOME="/root"
ENV PATH="$PATH:$HOME/.local/bin"
SHELL ["/bin/bash", "-c"]
WORKDIR /root/nonebot

RUN CPU_TYPE=$(uname -m) \
    && if [ "$CPU_TYPE" = "x86_64" ]; then \
        echo "Detected x86_64 CPU"; \
        export CPU_ARCH="amd64"; \
    elif [ "$CPU_TYPE" = "aarch64" ]; then \
        echo "Detected ARM64 CPU"; \
        export CPU_ARCH="arm64"; \
    else \
        echo "Unknown CPU type"; \
        export CPU_ARCH="unknown"; \
    fi

RUN \
  echo "**** 添加中文环境 ****" && \
  apt-get update && \
  #添加中文环境
  apt-get install -y \
    ttf-wqy-microhei \
    ttf-wqy-zenhei \
    xfonts-wqy && \
  apt-get install -y language-pack-zh-han* && \
  #add the langrage evn to the local
  echo "LANG=\"zh_CN.UTF-8\"" >> /etc/default/locale && \
  echo "LANGUAGE=\"zh_CN:zh\"" >> /etc/default/locale && \
  echo "LC_NUMERIC=\"zh_CN\"" >> /etc/default/locale && \
  echo "LC_TIME=\"zh_CN\"" >> /etc/default/locale && \
  echo "LC_MONETARY=\"zh_CN\"" >> /etc/default/locale && \
  echo "LC_PAPER=\"zh_CN\"" >> /etc/default/locale && \
  echo "LC_NAME=\"zh_CN\"" >> /etc/default/locale && \
  echo "LC_ADDRESS=\"zh_CN\"" >> /etc/default/locale && \
  echo "LC_TELEPHONE=\"zh_CN\"" >> /etc/default/locale && \
  echo "LC_MEASUREMENT=\"zh_CN\"" >> /etc/default/locale && \
  echo "LC_IDENTIFICATION=\"zh_CN\"" >> /etc/default/locale && \
  echo "LC_ALL=\"zh_CN.UTF-8\"" >> /etc/default/locale && \
  #add the langrage evn to /etc/environment
  echo "LANG=\"zh_CN.UTF-8\"" >> /etc/environment && \
  echo "LANGUAGE=\"zh_CN:zh\"" >> /etc/environment && \
  echo "LC_NUMERIC=\"zh_CN\"" >> /etc/environment && \
  echo "LC_TIME=\"zh_CN\"" >> /etc/environment && \
  echo "LC_MONETARY=\"zh_CN\"" >> /etc/environment && \
  echo "LC_PAPER=\"zh_CN\"" >> /etc/environment && \
  echo "LC_NAME=\"zh_CN\"" >> /etc/environment && \
  echo "LC_ADDRESS=\"zh_CN\"" >> /etc/environment && \
  echo "LC_TELEPHONE=\"zh_CN\"" >> /etc/environment && \
  echo "LC_MEASUREMENT=\"zh_CN\"" >> /etc/environment && \
  echo "LC_IDENTIFICATION=\"zh_CN\"" >> /etc/environment && \
  echo "LC_ALL=\"zh_CN.UTF-8\"" >> /etc/environment && \
  #add the langrage evn to .bashrc
  echo "LANG=\"zh_CN.UTF-8\"" >> /root/.bashrc && \
  echo "LANGUAGE=\"zh_CN:zh\"" >> /root/.bashrc && \
  echo "LC_NUMERIC=\"zh_CN\"" >> /root/.bashrc && \
  echo "LC_TIME=\"zh_CN\"" >> /root/.bashrc && \
  echo "LC_MONETARY=\"zh_CN\"" >> /root/.bashrc && \
  echo "LC_PAPER=\"zh_CN\"" >> /root/.bashrc && \
  echo "LC_NAME=\"zh_CN\"" >> /root/.bashrc && \
  echo "LC_ADDRESS=\"zh_CN\"" >> /root/.bashrc && \
  echo "LC_TELEPHONE=\"zh_CN\"" >> /root/.bashrc && \
  echo "LC_MEASUREMENT=\"zh_CN\"" >> /root/.bashrc && \
  echo "LC_IDENTIFICATION=\"zh_CN\"" >> /root/.bashrc && \
  echo "LC_ALL=\"zh_CN.UTF-8\"" >> /root/.bashrc && \
  #add the langrage evn to /etc/profile
  echo "LC_ALL=\"zh_CN.UTF-8\"" >> /etc/profile 
ENV LANG="zh_CN.UTF-8" \
    LANGUAGE="zh_CN:zh" \
    LC_ALL="zh_CN.UTF-8"
RUN locale-gen zh_CN.UTF-8 && \
    update-locale LANG=zh_CN.UTF-8
COPY install_linux.sh /root/nonebot
RUN \
  echo "**** 安装相关依赖 ****" && \
  apt-get install -y \
    curl \
    python3 \
    python3-pip \
    python3.10-venv \
    zbar* \
    jq \
    libatomic1 \
    nano \
    net-tools \
    netcat \
    wget \
    git \
    sudo && \
  apt-get install  -y \
    libnss3 \                                 
    libnspr4 \                                         
    libatk1.0-0 \                 
    libatk-bridge2.0-0 \                               
    libcups2 \                                    
    libatspi2.0-0 \                                
    libxcomposite1 \                                     
    libxdamage1 \                                      
    libxfixes3 \                                          
    libxrandr2 \ 
    libgbm1 \  
    libxkbcommon0 \    
    libpango-1.0-0 \    
    libcairo2 \  
    libasound2 && \ 
  apt-get install  -y ffmpeg && \
  echo "**** 安装 nonebot ****" && \
  python3 -m pip install --user pipx && \
  python3 -m pipx ensurepath && \
  mkdir -p /root/config && \
  /root/.local/bin/pipx install nb-cli
RUN \
  echo "**** 安装ntqq ****" && \
  wget https://dldir1.qq.com/qqfile/qq/QQNT/852276c1/linuxqq_3.2.5-21453_amd64.deb && \
  apt install ./linuxqq_3.2.5-21453_amd64.deb -y && \
  if [ -z ${LiteLoaderQQNT_RELEASE+x} ]; then \
    LiteLoaderQQNT_RELEASE=$(curl -sX GET https://api.github.com/repos/Mzdyl/LiteLoaderQQNT_Install/releases/latest \
      | awk '/tag_name/{print $4;exit}' FS='[""]' | sed 's|^v||'); \
  fi && \
  chmod +x ./install_linux.sh && \
  bash ./install_linux.sh


RUN \ 
  echo "**** 清理缓存 ****" && \
  apt-get clean && \
  rm -rf \
    /config/* \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /root/config/nb/*
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh
VOLUME [ "/root/nonebot","/opt/QQ", "/opt/LiteLoader" ]
CMD ["/startup.sh"]


# ports and volumes
EXPOSE 8080
