FROM mongo:3.4.6

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
    apt-get update -yqq && \
    apt-get install -yq iputils-ping && \
    apt-get install -yq openssh-server && \
    mkdir -p /var/run/sshd && \
    sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    echo root:root | chpasswd && \
    apt-get install -yq vim


ARG MDB_RS_NAME
ARG MDB_PRIMARY_HOST
ARG MDB_PRIMARY_PORT
ARG MDB_SEC_1_HOST
ARG MDB_SEC_1_PORT
ARG MDB_SEC_2_HOST
ARG MDB_SEC_2_PORT
ARG MDB_SEC_3_HOST
ARG MDB_SEC_3_PORT
ARG MDB_SEC_4_HOST
ARG MDB_SEC_4_PORT
ARG MDB_SEC_5_HOST
ARG MDB_SEC_5_PORT
ARG MDB_ARBITER_HOST
ARG MDB_ARBITER_PORT


# 植入环境变量
RUN echo "MDB_RS_NAME=${MDB_RS_NAME}\nexport MDB_RS_NAME\n" \
    "MDB_PRIMARY_HOST=${MDB_PRIMARY_HOST}\nexport MDB_PRIMARY_HOST\n" \
    "MDB_PRIMARY_PORT=${MDB_PRIMARY_PORT}\nexport MDB_PRIMARY_PORT\n" \
    "MDB_SEC_1_HOST=${MDB_SEC_1_HOST}\nexport MDB_SEC_1_HOST\n" \
    "MDB_SEC_1_PORT=${MDB_SEC_1_PORT}\nexport MDB_SEC_1_PORT\n" \
    "MDB_SEC_2_HOST=${MDB_SEC_2_HOST}\nexport MDB_SEC_2_HOST\n" \
    "MDB_SEC_2_PORT=${MDB_SEC_2_PORT}\nexport MDB_SEC_2_PORT\n" \
    "MDB_SEC_3_HOST=${MDB_SEC_3_HOST}\nexport MDB_SEC_3_HOST\n" \
    "MDB_SEC_3_PORT=${MDB_SEC_3_PORT}\nexport MDB_SEC_3_PORT\n" \
    "MDB_SEC_4_HOST=${MDB_SEC_4_HOST}\nexport MDB_SEC_4_HOST\n" \
    "MDB_SEC_4_PORT=${MDB_SEC_4_PORT}\nexport MDB_SEC_4_PORT\n" \
    "MDB_SEC_5_HOST=${MDB_SEC_5_HOST}\nexport MDB_SEC_5_HOST\n" \
    "MDB_SEC_5_PORT=${MDB_SEC_5_PORT}\nexport MDB_SEC_5_PORT\n" \
    "MDB_ARBITER_HOST=${MDB_ARBITER_HOST}\nexport MDB_ARBITER_HOST\n" \
    "MDB_ARBITER_PORT=${MDB_ARBITER_PORT}\nexport MDB_ARBITER_PORT\n" >> /etc/profile 



COPY mdb-rs-setup.sh /
RUN chmod +x /mdb-rs-setup.sh

CMD /mdb-rs-setup.sh

EXPOSE 22