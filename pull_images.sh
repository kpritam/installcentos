#!/bin/bash

OPENSHIFT_VERSION=v3.7.0-rc.0

docker pull docker.io/openshift/openvswitch:$OPENSHIFT_VERSION
docker pull docker.io/openshift/origin-haproxy-router:$OPENSHIFT_VERSION
docker pull docker.io/openshift/origin-deployer:$OPENSHIFT_VERSION
docker pull docker.io/openshift/origin:$OPENSHIFT_VERSION
docker pull docker.io/openshift/origin-docker-registry:$OPENSHIFT_VERSION
docker pull docker.io/openshift/origin-pod:$OPENSHIFT_VERSION
docker pull docker.io/openshift/node:$OPENSHIFT_VERSION
docker pull docker.io/openshift/origin-service-catalog:latest

docker pull docker.io/phkadam2008/jenkins-slave-sbt-centos7:latest
docker pull docker.io/phkadam2008/openshift-jenkins:2.91
docker pull docker.io/cockpit/kubernetes:latest
docker pull docker.io/ansibleplaybookbundle/ansible-service-broker:latest

docker pull quay.io/coreos/etcd:latest
docker pull registry.fedoraproject.org/f26/etcd:latest
docker pull registry.access.redhat.com/rhel7/etcd:latest