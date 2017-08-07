#!/bin/bash

#####################################
# 本脚本的作用在于在宿主机上导入一些常用命令
#####################################

SSHPORT=2222
RCFILE=~/.bashrc
CURRENTPATH=$(cd `dirname $0`; pwd)

[ "${SHELL}" = /bin/zsh ] && { RCFILE=~/.zshrc ;}
[ ! -e ${RCFILE} ] && {
    echo "# create by cphTool" > ${RCFILE};
}

echo "" >> ${RCFILE} && \
echo "# cphTool command alias" >> ${RCFILE} && \
echo "alias dps=\"docker-compose\"" >> ${RCFILE} && \
echo "alias workspace=\"ssh -p ${SSHPORT} root@127.0.0.1\"" >> ${RCFILE} && \
# 连接到redis
echo "alias _redis=\"cd ${CURRENTPATH} && docker-compose exec redis redis-cli\"" >> ${RCFILE} && \
# 连接到mongo数据库，命令前面加下划线是为了避免和本机mongo客户端命令冲突
echo "alias _mongo=\"cd ${CURRENTPATH}  && docker-compose exec mongo mongo\"" >> ${RCFILE} && \

# 启动应用run appName(文件夹名称)
echo "run() {"  >> ${RCFILE} && \
echo "    ssh -p ${SSHPORT} root@127.0.0.1 \"ps -ef | grep 'bin/www' |grep -v grep | cut -c 10-16 | xargs kill -9\""  >> ${RCFILE} && \
echo "    ssh -p ${SSHPORT} root@127.0.0.1 \"ps -ef | grep grunt |grep -v grep | cut -c 10-16 | xargs kill -9\""  >> ${RCFILE} && \
echo "    ssh -p ${SSHPORT} root@127.0.0.1 " '"cd /var/www/$1 && grunt"'  >> ${RCFILE} && \
echo "}" >> ${RCFILE}

# 导入后记得执行以下source ~/.${SHELL##*/}rc
