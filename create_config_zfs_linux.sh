#/usr/bin/bash
mkdir -p /etc/zabbix/zabbix_agentd.conf.d/
touch /etc/zabbix/zabbix_agentd.conf.d/zfs_degraded.conf
echo -n > /etc/zabbix/zabbix_agentd.conf.d/zfs_degraded.conf
cat << EOF >> /etc/zabbix/zabbix_agentd.conf.d/zfs_degraded.conf
UnsafeUserParameters=1
UserParameter=zfs.pool.discovery,/sbin/zpool list -H -o name | sed -e '$ ! s/\(.*\)/{"{#POOLNAME}":"\1"},/' | sed -e '$ s/\(.*\)/{"{#POOLNAME}":"\1"}]}/' | sed -e '1 s/\(.*\)/{ \"data\":[\1/'
UserParameter=zfs.zpool.health[*],/sbin/zpool list -H -o health \$1
EOF
systemctl restart zabbix-agent
