#!/bin/bash

yum install -y epel-release

yum install -y git wget zile nano net-tools ansible
yum install -y docker
yum install -y python-cryptography pyOpenSSL.x86_64
yum install -y java-1.8.0-openjdk-headless

## WORKAROUND as per https://github.com/openshift/openshift-ansible/issues/3111
## TODO: yum install ansible
yum install -y "@Development Tools" python2-pip openssl-devel python-devel
pip install -Iv ansible==2.3.0.0

systemctl restart docker
systemctl enable docker

./pull_images.sh