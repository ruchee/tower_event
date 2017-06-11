![one](https://raw.github.com/ruchee/tower_event/master/.github/one.jpg)
![two](https://raw.github.com/ruchee/tower_event/master/.github/two.jpg)

----
安装 Gems
```
bundle install
```

打包全部 Gems 到项目目录（这个步骤的目的是节省 Docker 镜像构建的时间）
```
bundle package --all
```

安装前端依赖
```
yarn
```

构建镜像
```
docker-compose build
```

启动服务
```
docker-compose up -d
```

初始化数据
```
docker-compose run web rake db:migrate db:seed
```

访问地址：`http://localhost:3000`

如果是用的 `boot2docker`，则使用 `boot2docker ip` 输出的 `IP` 地址替换 `localhost`

----
