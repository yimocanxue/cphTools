FROM nginx:alpine

MAINTAINER David <xuh@cn-etc.com>

# 主配置文件
COPY nginx.conf /etc/nginx/
# 默认主页配置
COPY nginx.vh.example.conf /etc/nginx/conf.d/default.conf

ARG PHP_UPSTREAM=php-fpm

# fix a problem--#397, change application source from dl-cdn.alpinelinux.org to aliyun source.
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash \
    && addgroup -S www \
  	&& adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G www www \
    && echo "upstream php-upstream { server ${PHP_UPSTREAM}:9000; }" > /etc/nginx/conf.d/upstream.conf


EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
