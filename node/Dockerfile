FROM node:6.11.1

MAINTAINER David xu <xuh@cn-etc.com>

# SASS:

ARG INSTALL_SASS=false
RUN if [ ${INSTALL_SASS} = true ]; then \
  # 更换apt源到163镜像源
  echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" > /etc/apt/sources.list && \
  echo "deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list && \
  echo "deb http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list && \
  echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list && \
  echo "deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list && \
  echo "deb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list && \
  echo "deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list && \
  echo "deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list && \
  apt-get update -yqq && \
  apt-get -y install ruby-full && \

  # 更换gem源
  gem sources --remove http://rubygems.org/ && \
  gem sources --remove https://rubygems.org/ && \
  gem sources -a https://ruby.taobao.org/ && \
  gem sources -l && \
  gem install sass && \
  sass -v \
;fi


# 更换NPM源
RUN npm config set registry https://registry.npm.taobao.org 

ARG INSTALL_GRUNT=false
RUN if [ ${INSTALL_GRUNT} = true ]; then \
  npm install -g grunt-cli \
;fi


CMD ["node","--help"]
