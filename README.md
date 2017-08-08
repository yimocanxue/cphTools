# cphTools
基于docker的Node.js/PHP开发环境工具包

# 准备工作

## 1、提前在本机安装好docker、docker-compose

## 2、设置docker image的镜像源【可选】

Linux:
```
$ curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://b5f28ff7.m.daocloud.io
```

MacOS:
右键点击桌面顶栏的 docker 图标，选择 Preferences ，在 Daemon 标签（Docker 17.03 之前版本为 Advanced 标签）下的 Registry mirrors 列表中加入下面的镜像地址:`http://b5f28ff7.m.daocloud.io Copy`
点击 Apply & Restart 按钮使设置生效。`

## 3、新建工作目录

这里假设工作目录为/work:

```
$ cp /work && cd /work

```

## 4、克隆cphTool

```
$ git clone git@github.com:yimocanxue/cphTools.git

```

## 5、修改依赖环境变量

```
$ cd cphTools
$ cp env .env  # 按需修改.env里的变量

```

## 6、导入命令别名【可选】

```
$ ./aliases.sh
$ source ~/.${SHELL##*/}rc

```

## 7、启动服务

```
$ docker-compose up -d nginx mysql memcached

```

至此基于cphTool的Node/php开发环境准备完成。


# Node开发环境】

Node开发环境主要依赖服务为：workspace(node/grunt/sass)、redis、mongo。

## 1、在工作目录下新建或clone已存在项目

这里假设项目已存在，直接克隆即可

```
$ cd /work
$ git clone ssh://xxxxx/abc.git

```

## 2、启动容器

Node环境只要启动workspace容器即可，它会自动关联启动redis/mongo。

```
$ cd cphTools
$ dps up -d workspace

```

## 3、安装依赖并启动应用

```
$ workspace 		# 进入workspace容器
$ cd /var/www/abc   # 这里的目录abc即上一步项目目录名
$ npm install
$ grunt
```
OK,应用环境已部署完毕并启动应用，可以开始开发工作

# PHP开发环境

PHP开发环境主要依赖服务： Nginx、php-fpm、mysql、memcached/redis等。









