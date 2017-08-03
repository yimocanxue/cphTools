FROM phusion/baseimage:0.9.22

MAINTAINER David xu <xuh@cn-etc.com>

#######################
# 更换apt源到163镜像源
#######################

RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get update -yq && \
    apt-get install -yq iputils-ping



#######################
# 安装node
#######################

ARG WP_INSTALL_NODE=false
#RUN if [ ${WP_INSTALL_NODE} != false ]; then \
  # 这里使用阿里云tnvm替代nvm
#  curl -O https://raw.githubusercontent.com/aliyun-node/tnvm/master/install.sh && \
#  sed -i 's/--no-check-certificate/ /g' install.sh && \
#  chmod +x install.sh && \
#  ./install.sh && \
#  echo "" >> ~/.bashrc && \
#  echo 'export TNVM_DIR="/root/.tnvm"' >> ~/.bashrc && \
#  echo '[ -s "$TNVM_DIR/tnvm.sh" ] && . "$TNVM_DIR/tnvm.sh" ' >> ~/.bashrc && \
#  . ~/.bashrc && \
#  rm -f install.sh && \
  # 安装node
#  tnvm install node-v${WP_INSTALL_NODE} && \
#  tnvm use node-v${WP_INSTALL_NODE} && \

  # 更换npm源
#  npm config set registry https://registry.npm.taobao.org　&& \
  # 安装grunt-cli/gulp bower等
#  npm install -g grunt-cli　gulp bower vue-cli \
#;fi

RUN if [ ${WP_INSTALL_NODE} != false ]; then \
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash && \
  echo "" >> ~/.bashrc && \
  echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
  echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc && \
  . ~/.bashrc && \
  export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node && \
  nvm install v${WP_INSTALL_NODE} && \
  nvm use v${WP_INSTALL_NODE} && \
  nvm alias v${WP_INSTALL_NODE}  \

;fi

#######################
# 安装sass
#######################

ARG WP_INSTALL_SASS=false
RUN if [ ${WP_INSTALL_SASS} = true ]; then \
  # 更换apt源到163镜像源
  apt-get -y install ruby && \
  # 更换gem源
  gem sources --remove http://rubygems.org/ && \
  gem sources --remove https://rubygems.org/ && \
  gem sources -a https://ruby.taobao.org/ && \
  gem sources -l && \
  gem install sass && \
  sass -v \
;fi

# 暴露端口
ARG WP_WEB_PORT=3000
ARG WP_WEB_TO_LOCAL=3000
EXPOSE [22,${WP_WEB_PORT}]

CMD bash
