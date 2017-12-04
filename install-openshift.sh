#!/bin/bash

## see: https://www.youtube.com/watch?v=-OOnGK-XeVY

DOMAIN=${DOMAIN:=openshift.tmt.org}
USERNAME=${USERNAME:=pritam}
PASSWORD=${PASSWORD:=pritam}

mkdir -p ~/workspace && cd ~/workspace
git clone http://github.com/openshift/openshift-ansible
git clone http://github.com/kpritam/installcentos

cat <<EOD > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 openshift ${DOMAIN}
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
EOD

cat /dev/zero | ssh-keygen -t rsa -q -N ""
touch ~/.ssh/authorized_keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

######################################################################################
## THIS IS HIGHLY INSECURE AND ONLY ACCEPTABLE IN DEVELOPMENT
echo 'INSECURE_REGISTRY="--insecure-registry 172.30.0.0/16"' >> /etc/sysconfig/docker
######################################################################################


#################################################################################
## THIS IS HIGHLY INSECURE AND ONLY ACCEPTABLE IN DEVELOPMENT
#echo 'INSECURE_REGISTRY="--insecure-registry"' >> /etc/sysconfig/docker
#################################################################################

########################################################################################################
#See: http://blog.hashbangbash.com/2014/11/docker-devicemapper-fix-for-device-or-resource-busy-ebusy/
cp -p /usr/lib/systemd/system/docker.service /usr/lib/systemd/system/docker.service.ORIGINAL
## NO, IT DOES NOT WORK:: sed 's/MountFlags=slave/MountFlags=private/' -i /usr/lib/systemd/system/docker.service
########################################################################################################


systemctl restart docker
systemctl enable docker

cd ~/workspace
cat installcentos/inventory.erb | sed "s/openshift.tmt.org/${DOMAIN}/g" > /tmp/installcentos-inventory.erb
ansible-playbook -i /tmp/installcentos-inventory.erb openshift-ansible/playbooks/byo/config.yml

#################################################################
##            PLEASE CHOOSE BETTER CREDENTIALS
##
## Note: make sure that the username you choose corresponds to
##       an existing username in the system. Also, make sure
##       that such user belongs to group docker, like below:
##
##       $ usermod -a -G docker pritam
##
htpasswd -b /etc/origin/master/htpasswd ${USERNAME} ${PASSWORD}
oc adm policy add-cluster-role-to-user cluster-admin pritam
#################################################################
