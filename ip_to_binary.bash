#!/bin/bash

# 检查是否提供了IP地址作为参数
if [ $# -ne 1 ]; then
    echo "Usage: $0 <IPv4 address>"
    exit 1
fi

# 获取输入的IPv4地址
ip=$1

# 验证输入是否为有效的IPv4地址
if ! [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    echo "Error: Invalid IPv4 address format."
    exit 1
fi

# 将IPv4地址的每个部分转换为二进制
IFS='.' read -r -a octets <<< "$ip"  # 按点分隔IP地址为数组
binary_ip=""

for octet in "${octets[@]}"; do
    # 检查每个段是否在0-255范围内
    if ((octet < 0 || octet > 255)); then
        echo "Error: Each octet must be in the range 0-255."
        exit 1
    fi
    # 转换为二进制并补零到8位
    binary_octet=$(printf "%08d" "$(bc <<< "obase=2;$octet")")
    binary_ip+="$binary_octet."
done

# 去掉最后一个多余的点
binary_ip=${binary_ip%?}

# 输出二进制格式的IP地址
echo "$binary_ip"