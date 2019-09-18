FROM alpine:3.8

MAINTAINER fortheday@126.com
# 更新源
RUN echo http://mirrors.ustc.edu.cn/alpine/v3.8/main > /etc/apk/repositories && \
	echo http://mirrors.ustc.edu.cn/alpine/v3.8/community >> /etc/apk/repositories
RUN apk update && apk upgrade

RUN apk add git nodejs npm nginx
RUN npm config set registry https://registry.npm.taobao.org --global
RUN npm -g i pm2

# 下载代码
#RUN mkdir /node && cd /node
#RUN git clone https://github.com/fortheday001/student_target.git
#WORKDIR "/node/student_target"

# 复制代码
RUN mkdir /student_target
COPY client /student_target/client
COPY server /student_target/server

# 部署后端
RUN cd /student_target/server && \
	rm -rf node_modules config.js && \
	cp config-example.js config.js && \
	npm i > /dev/null 2>&1

# 打包前端
RUN cd /student_target/client && \
	rm -rf node_modules && \
	npm i > /dev/null 2>&1 && \
	npm run build > /dev/null 2>&1

# 部署前端
RUN echo "pid \"logs/nginx.pid\";" >> /etc/nginx/nginx.conf
RUN echo "server {listen 80 default_server;location / {root /student_target/client/dist;try_files $uri $uri/ /index.html last;index index.html;}}" > /etc/nginx/conf.d/default.conf

EXPOSE 80

# 启动脚本
RUN echo -e "#!/bin/sh\npm2 start /student_target/server/index.js\nnginx -g \"daemon off;\"" > /student_target/docker-entrypoint.sh
RUN chmod +x /student_target/docker-entrypoint.sh

ENTRYPOINT ["/student_target/docker-entrypoint.sh"]
