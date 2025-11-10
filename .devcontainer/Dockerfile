# 使用 Ubuntu 22.04 基础镜像
FROM ubuntu:22.04

#安装vim
RUN apt-get update && \
    apt-get install -y vim git
# 安装必要工具：nasm（汇编器）和 dosbox（调试环境）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nasm \
    dosbox && \
    # 清理缓存以减小镜像体积
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /asm

# 启动时进入交互终端
CMD ["/bin/bash"]