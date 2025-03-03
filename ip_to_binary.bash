#!/bin/bash

# 检查参数数量是否为1
if [ $# -ne 1 ]; then
    echo "Usage: $0 <IPv4 address>"
    exit 1
fi

# 获取IPv4地址
input_ipv4=$1

# 正则表达式判断是否为有效的IPv4地址
if [[ ! "$input_ipv4" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    echo "Error: Invalid IPv4 address format!"
    exit 1
fi

# 将IPv4地址分解为八位段数组
IFS='.' read -ra ip_segments <<< "$input_ipv4"

# 定义存储二进制结果的变量
binary_segments=""

# 遍历每个八位段进行验证和转换
for segment in "${ip_segments[@]}"; do
    # 检查八位段是否在0-255范围内
    if (( segment < 0 || segment > 255 )); then
        echo "Error: Each segment must be in the range 0-255."
        exit 1
    fi
    # 转换为二进制并补零至8位
    binary_part=$(printf "%08d" "$(bc <<< "obase=2;$segment")")
    binary_segments+="$binary_part."
done

# 去除最后一个多余的点
binary_segments=${binary_segments%\.}

# 输出结果
echo "IPv4地址转换为二进制: $binary_segments"
