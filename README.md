# Ceph Vagrant test setup

## Overview

This repo contains a vagrant setup of a ceph setup. By default the following nodes are created:

* admin node
* mon node
* 3 osd nodes
* mds node

Each node has
* Ceph installed, ceph and ceph-deploy
* Ceph user, with ssh key, can login to all other nodes
* a 10G storage /dev/sdb
* all other hosts in /etc/hosts

## Requirements

* Vagrant (tested with 1.7.3)
* VirtualBox
* RAM > 6G

## Gettin' Started

* Starting all instances: ```vagrant up```
* SSH into ceph-admin: ```vagrant ssh ceph-admin```
* Set up manually or via script: ```/vagrant/scripts/create_ceph_cluster.sh```
