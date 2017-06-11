# Tower Event
----
构建镜像
```
docker-compose build
```

启动服务
```
docker-compose up -d
```

初始化数据表
```
docker-compose run web rake db:migrate db:seed
```

访问地址：`http://localhost:3000`（如果是用的 `boot2docker`，则使用 `boot2docker ip` 输出的 `IP` 地址替换 `localhost`）
