# 安装说明

0. 系统使用三个端口号
- 10070：API 的端口号
- 10080：数据库的端口号
- 10090：前端程序的端口号

1. 创建配置文件
- 到 client 目录下，复制 config-example.js 为 config.js 然后修改 config.js 中的配置
- 到 server 目录下，复制 config-example.js 为 config.js 然后修改 config.js 中的配置

2. 到根目录使用以下指令启动：
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