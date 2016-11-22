#!/usr/bin/env bash

# 删除旧镜像
docker rmi syuukawa/thymeleaf:latest 2> /dev/null

# 重新下载源代码
rm -rf thymeleaf_layout/
git clone https://github.com/syuukawa/thymeleaf_layout.git

# 重新构建镜像
mvn -f thymeleaf_layout/pom.xml clean package -U
mvn -f thymeleaf_layout/pom.xml docker:build
mvn -f thymeleaf_layout/pom.xml clean -q

# 压缩源代码目录
if [ -f src.zip ]; then
    rm -rf src.zip
fi
zip -r src.zip thymeleaf_layout/ -q
rm -rf thymeleaf_layout/ 2> /dev/null

exit 0
