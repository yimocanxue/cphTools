FROM debian:jessie

MAINTAINER David xu <xuh@cn-etc.com>


# 更换apt源到163镜像源
RUN echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" > /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list && \
    apt-get update -yq && \
    apt-get install -yq iputils-ping && \
    apt-get install -yq openssh-server && \
    mkdir -p /var/run/sshd && \
    sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    apt-get install -yq vim curl



#######################
# 安装node
#######################

ARG WP_INSTALL_NODE=false

RUN if [ ${WP_INSTALL_NODE} != false ]; then \
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash && \
  echo "" >> ~/.bashrc && \
  echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
  echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc && \
  . ~/.bashrc && \
  export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node && \
  nvm install v${WP_INSTALL_NODE} && \
  nvm use v${WP_INSTALL_NODE} && \
  nvm alias v${WP_INSTALL_NODE} && \

  # 更换淘宝源和常用工具
  npm config set registry https://registry.npm.taobao.org && \
  npm install -g grunt-cli \

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
  gem install sass --pre && \
  sass -v \
;fi


# ssh 登录密码
ARG SSH_ROOT_PWD
RUN if [ -n "${SSH_ROOT_PWD}" ]; then \
    echo root:${SSH_ROOT_PWD} | chpasswd  \
;fi


# 免密码登录
ARG LOCAL_SSH_KEY
RUN if [ -n "${LOCAL_SSH_KEY}" ]; then \
    mkdir -p /root/.ssh && \
    echo ${LOCAL_SSH_KEY} > /root/.ssh/authorized_keys \
;fi



# 暴露端口
ARG WP_WEB_PORT=3000
EXPOSE 22
EXPOSE ${WP_WEB_PORT}

COPY startup.sh /
RUN chmod +x /startup.sh

WORKDIR /var/www

CMD /startup.sh
