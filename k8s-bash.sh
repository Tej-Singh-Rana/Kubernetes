#!/bin/bash
#script for k8s bash completion
echo "On process......"
sudo yum install bash-completion -y
sleep 2
echo "source <(kubectl completion bash)" >> /root/.bashrc
source /root/.bashrc
