# dockerx-mirror-k8s

dockerx构建移植推送到自定义registry,避免避免到国外的低速拉取.

## 原理

- 用 [skopeo](https://github.com/containers/skopeo) 进行registry的读取镜像列表,并进行同步。直接在2个远程registry间进行复制同步,不需要占据大量本地磁盘空间。
- 建立定时任务