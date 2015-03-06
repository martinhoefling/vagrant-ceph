#!/bin/bash -eux

CLUSTER_NODES="ceph-admin ceph-mon1 ceph-osd1 ceph-osd2 ceph-osd3 ceph-mds1"

cd /home/ceph
mkdir cluster
cd cluster

for node in ${CLUSTER_NODES}; do
    ssh ${node} exit
done

#ceph-deploy purgedata ${CLUSTER_NODES}
#ceph-deploy forgetkeys
#ceph-deploy install ${CLUSTER_NODES}

ceph-deploy new --cluster-network 192.168.1.0/24 --public-network 192.168.1.0/24  ceph-mon1
ceph-deploy mon create-initial
echo "osd pool default size = 2" >> ./ceph.conf

ceph-deploy admin ceph-admin

for i in {1..3}; do
    ceph-deploy disk zap ceph-osd${i}:sdb

    # create does prepare and activate in one step
    #ceph-deploy osd prepare ceph-osd${i}:sdb
    #ceph-deploy osd activate ceph-osd${i}:sdb

    ceph-deploy osd create ceph-osd${i}:sdb
done

ceph-deploy mds create ceph-mds1
