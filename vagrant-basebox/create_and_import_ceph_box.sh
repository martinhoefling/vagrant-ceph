#!/bin/bash
vagrant up
vagrant package --output ceph.box
vagrant box add ceph ceph.box
