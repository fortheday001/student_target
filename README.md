# 安装说明

0. 系统启动之后，需要占用 10090 、10080、 7000 三个系统端口
- 10090 ：客户端 APP 的访问端口
- 7000 ：服务器端接口的访问端口
- 10080：数据库端口

1. 需要安装 docker-compose （自行百度安装）
    安装之后，可以在根目录执行以下指令构建容器：

2. 安装了 docker-compose 之后，可以使用以下指令启动：
~~~
docker-compose up -d
~~~

指令说明：
~~~
docker-compose up -d   			# 创建所有容器并在后台运行
docker-compose stop  		    # 停止所有容器
docker-compose down             # 删除所有容器
docker-compose ps     			# 查看当前这个集群中的容器的状态
~~~

3. 导入数据库
启动系统之后，需要手动连接 10080 端口的 MySQL 服务器，
然后在 student_target（已经创建好） 数据库中导入 server/student_target.sql 文件