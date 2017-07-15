FROM php:5.6.31-fpm

MAINTAINER David xu <xuh@cn-etc.com>


#
# 更换apt源到163镜像源,然后安装 "curl", "libmemcached-dev", "libpq-dev", "libjpeg-dev",
#         "libpng12-dev", "libfreetype6-dev", "libssl-dev", "libmcrypt-dev"和必选扩展
RUN echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" > /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list && \
    apt-get update -yqq && \
    apt-get install -y --no-install-recommends \
        curl \
        libmemcached-dev \
        libz-dev \
        libpq-dev \
        libjpeg-dev \
        libpng12-dev \
        libfreetype6-dev \
        libssl-dev \
        libmcrypt-dev && \
    # 安装mcrypt扩展
    docker-php-ext-install mcrypt && \
    # 安装pdo_mysql扩展
    docker-php-ext-install mysqli && \
    docker-php-ext-install pdo_mysql && \
    # 安装pdo_pgsql扩展
    docker-php-ext-install pdo_pgsql && \
    # 安装gd库
    docker-php-ext-install gd && \
    docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-jpeg-dir=/usr/lib \
        --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd 



#####################################以下为可选扩展##############################################

ARG PHP_CONF_PATH=/usr/local/etc/php/conf.d/

####################
# SOAP
####################
ARG INSTALL_SOAP=false
RUN if [ ${INSTALL_SOAP} = true ]; then \
    apt-get install -y libxml2-dev php-soap && \
    docker-php-ext-install soap \
;fi


####################
# xDebug
####################
ARG INSTALL_XDEBUG=false
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
    apt-get install -y php5-xdebug && \
    echo "zend_extension=/usr/lib/php5/20131226/xdebug.so" > ${PHP_CONF_PATH}docker-php-ext-xdebug.ini \
;fi
# 配置远程debug
COPY ./xdebug.ini ${PHP_CONF_PATH}xdebug.ini


###################
# Swoole:
# PHP的异步、并行、高性能网络通信引擎，使用纯C语言编写，提供了PHP语言的异步多线程服务器，
# 异步TCP/UDP网络客户端，异步MySQL，异步Redis，数据库连接池，AsyncTask，消息队列，毫秒定时器，
# 异步文件读写，异步DNS查询。 Swoole内置了Http/WebSocket服务器端/客户端、Http2.0服务器端。
# 除了异步IO的支持之外，Swoole为PHP多进程的模式设计了多个并发数据结构和IPC通信机制，可以大大简化
# 多进程并发编程的工作。其中包括了并发原子计数器，并发HashTable，Channel，Lock，进程间通信IPC等丰富的功能特性。
# Swoole2.0支持了类似Go语言的协程，可以使用完全同步的代码实现异步程序。PHP代码无需额外增加任何关键词，
# 底层自动进行协程调度，实现异步。
# Swoole可以广泛应用于互联网、移动通信、企业软件、云计算、网络游戏、物联网（IOT）、车联网、智能家居等领域。
# 使用PHP+Swoole作为网络通信框架，可以使企业IT研发团队的效率大大提升，更加专注于开发创新产品。
# 
####################

ARG INSTALL_SWOOLE=false
RUN if [ ${INSTALL_SWOOLE} = true ]; then \
    pecl install swool && \
    docker-php-ext-enable swoole \
;fi



####################
# opcode
####################

ARG INSTALL_OPCACHE=false
RUN if [ ${INSTALL_OPCACHE} = true ]; then \
    docker-php-ext-install opcache \
;fi
# Copy opcache configration
COPY ./opcache.ini ${PHP_CONF_PATH}opcache.ini


####################
# Exif:
####################

ARG INSTALL_EXIF=false
RUN if [ ${INSTALL_EXIF} = true ]; then \
    docker-php-ext-install exif \
;fi



####################
# Mysqli:
####################
ARG INSTALL_MYSQLI=false
RUN if [ ${INSTALL_MYSQLI} = true ]; then \
    docker-php-ext-install mysqli \
;fi



#####################
# PHP Memcached:
#####################

ARG INSTALL_MEMCACHED=false
# 这里为了避免下载失败，已经提前在php:5.6.31-fpm的容器中编译好了，直接拷贝进去即可
ADD ./ext/igbinary.so /usr/local/lib/php/extensions/no-debug-non-zts-20131226/
ADD ./ext/memcached.so /usr/local/lib/php/extensions/no-debug-non-zts-20131226/
RUN if [ ${INSTALL_MEMCACHED} = true ]; then \
    # 安装方式1、pecl方式
    #pecl install memcached-2.2.0 && \
    #docker-php-ext-enable memcached \
    
    # 安装方式2、下载源文件编译安装
    # 安装igbinary扩展
    #curl -fSL http://pecl.php.net/get/igbinary-1.2.1.tgz -o igbinary-1.2.1.tgz && \
    #tar xf igbinary-1.2.1.tgz && \
    #cd igbinary-1.2.1 && \
    #phpize && \
    #./configure && \
    #make && make install && \
    #echo "extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/igbinary.so" > ${PHP_CONF_PATH}docker-php-ext-igbinary.ini && \
    #cd .. && rm -rf * && \
    # 安装memcached扩展
    #curl -fSL http://pecl.php.net/get/memcached-2.2.0.tgz -o memcached-2.2.0.tgz && \
    #tar xf memcached-2.2.0.tgz && \
    #cd memcached-2.2.0 && \
    #phpize && \
    #./configure -enable-memcached -enable-memcached-igbinary -enable-memcached-json -with-zlib-dir -prefix=/usr/local/phpmemcached --disable-memcached-sasl && \
    #make && make install && \
    #echo "extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/memcached.so" > ${PHP_CONF_PATH}docker-php-ext-memcached.ini && \
    #cd .. && rm -rf * \

    # 安装方式3、直接拷贝编译好的扩展文件
    echo "extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/igbinary.so" > ${PHP_CONF_PATH}docker-php-ext-igbinary.ini && \
    echo "extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/memcached.so" > ${PHP_CONF_PATH}docker-php-ext-memcached.ini  \
;fi



#####################
# bcmath:
#####################

ARG INSTALL_BCMATH=false
RUN if [ ${INSTALL_BCMATH} = true ]; then \
    docker-php-ext-install bcmath \
;fi

#####################
# MongoDB:
#####################

ARG INSTALL_MONGO=false
RUN if [ ${INSTALL_MONGO} = true ]; then \
    pecl install mongodb && \
    docker-php-ext-enable mongodb \
;fi

######################
# ZipArchive:
######################

ARG INSTALL_ZIP_ARCHIVE=false
RUN if [ ${INSTALL_ZIP_ARCHIVE} = true ]; then \
    docker-php-ext-install zip \
;fi


######################
# PHP REDIS EXTENSION FOR PHP 5
######################

ARG INSTALL_PHPREDIS=false
RUN if [ ${INSTALL_PHPREDIS} = true ]; then \
    pecl install -o -f redis && \
    rm -rf /tmp/pear && \
    docker-php-ext-enable redis  \
;fi

######################
# 国际化扩展
######################

ARG INSTALL_INTL=false
RUN if [ ${INSTALL_INTL} = true ]; then \
    apt-get install -y zlib1g-dev libicu-dev g++ && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl \
;fi


######################
# LDAP:
######################

ARG INSTALL_LDAP=false
RUN if [ ${INSTALL_LDAP} = true ]; then \
    apt-get update -yqq && \
    apt-get install -y libldap2-dev && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap \
;fi

# php配置文件
ADD ./cph.ini ${PHP_CONF_PATH}
# 覆盖默认的php-fpm配置文件
ADD ./php-fpm-www.conf /usr/local/etc/php-fpm.d/www.conf

RUN usermod -u 1000 www-data 

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000




