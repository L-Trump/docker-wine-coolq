# docker-wine-coolq

![Build](https://github.com/CoolQ/docker-wine-coolq/workflows/Build/badge.svg) [![GitHub release](https://img.shields.io/github/release/coolq/docker-wine-coolq.svg)](https://github.com/CoolQ/docker-wine-coolq/releases) ![GitHub](https://img.shields.io/github/license/coolq/docker-wine-coolq.svg) [![Docker pulls](https://img.shields.io/docker/pulls/coolq/wine-coolq.svg)](https://hub.docker.com/r/coolq/wine-coolq) ![Image Size](https://img.shields.io/microbadger/image-size/coolq/wine-coolq.svg)

**2020-7-29 由于技术限制，酷Q on Docker 未来可能将无法使用。建议使用 Windows 10 / Windows Server 2016 及以上版本的系统运行 酷Q。**

----

docker-wine-coolq 可以使你通过 Wine 在 Docker 容器中运行 酷Q Air 或 酷Q Pro。本项目仅对 x86_64 平台提供支持，**暂不支持**树莓派、路由器等 Arm 架构硬件。

即使该 dockerfile 仓库使用 GPL 发布，其中下载的软件仍然遵循其最终用户使用许可协议，请确认同意协议后再进行下载使用。

随着版本更新，wine 的 酷Q 并不保证总是可用。若你遇到不可用问题，在严格按照下述步骤执行后仍可复现，请在 [社区](https://cqp.cc/b/issue) 反馈。

## 下载使用

如果你在服务器上使用 `docker` 或者和 docker 兼容的服务，只需执行：

```bash
docker pull coolq/wine-coolq
mkdir coolq && cd coolq
docker run --rm -p 9000:9000 -v `pwd`:/home/user/coolq coolq/wine-coolq
```

即可运行一个 wine-coolq 实例。运行后，访问 `http://你的IP:9000` 可以打开一个 VNC 页面，输入 `MAX8char` 作为密码后即可看到一个 酷Q Air 已经启动。

酷Q 和其数据文件会保存在容器内的 `/home/user/coolq` 文件夹下，映射到主机上则为上述命令第二步创建的文件夹。调整 `-v` 的参数可以改变主机映射的路径。

## 常用示例

### 使用酷Q Pro

```bash
# 请先自行删除老的 coolq 目录
mkdir coolq
docker run --name=coolq -d -p 9000:9000 -v `pwd`/coolq:/home/user/coolq -e COOLQ_URL=http://dlsec.cqp.me/cqp-full coolq/wine-coolq
```

### 设置 VNC 密码

```bash
docker run --name=coolq -d -p 9000:9000 -v `pwd`/coolq:/home/user/coolq -e VNC_PASSWD=12345678 coolq/wine-coolq
```

## 环境变量

在创建 docker 容器时，使用以下环境变量，可以调整容器行为。

* **`VNC_PASSWD`** 设置 VNC 密码。注意该密码不能超过 8 个字符。
* **`COOLQ_ACCOUNT`** 设置要登录 酷Q 的帐号。在第一次手动登录后，你可以勾选“快速登录”功能以启用自动登录，此后， docker 容器启动或 酷Q 异常退出时，便会自动为你登录该帐号。
* **`COOLQ_URL`** 设置下载 酷Q 的地址，默认为 `http://dlsec.cqp.me/cqa-tuling`，即 酷Q Air 图灵版。请确保下载后的文件能解压出 `酷Q Air/CQA.exe` 或 `酷Q Pro/CQP.exe`

