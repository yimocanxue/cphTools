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



CMD bash

EXPOSE 22
