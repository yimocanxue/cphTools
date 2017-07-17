# cphTools
基于docker的Node.js/PHP开发环境工具包

# 使用方法

## 1、提前在本机安装好docker、docker-compose

## 2、 clone项目到本地

`$ git clone git@github.com:yimocanxue/cphTools.git`

## 3、修改依赖环境变量

```
$ cd cphTools
$ cp env .env  # 按需修改.env里的变量

```

## 4、启动服务

```
$ docker-compose up -d nginx mysql memcached

```

OK,至此php的开发运行环境搭建完成。

