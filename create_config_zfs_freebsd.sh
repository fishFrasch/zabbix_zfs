#/usr/bin/bash
#mkdir -p /usr/local/etc/zabbix64/zabbix_agentd.conf.d/
#touch /usr/local/etc/zabbix64/zabbix_agentd.conf.d/zfs_degraded.conf
#echo -n > /usr/local/etc/zabbix64/zabbix_agentd.conf.d/zfs_degraded.conf

mkdir -p /usr/local/etc/zabbix/zabbix_agentd.conf.d/
touch /usr/local/etc/zabbix/zabbix_agentd.conf.d/zfs_degraded.conf
echo -n > /usr/local/etc/zabbix/zabbix_agentd.conf.d/zfs_degraded.conf

cat << EOF >> /usr/local/etc/zabbix/zabbix_agentd.conf.d/zfs_degraded.conf
UnsafeUserParameters=1
UserParameter=zfs.pool.discovery,/sbin/zpool list -H -o name | sed -e '$ ! s/\(.*\)/{"{#POOLNAME}":"\1"},/' | sed -e '$ s/\(.*\)/{"{#POOLNAME}":"\1"}]}/' | sed -e '1 s/\(.*\)/{ \"data\":[\1/'
UserParameter=zfs.zpool.health[*],/sbin/zpool list -H -o health \$1
EOF

#sed -i -e 's/# Include=\/usr\/local\/etc\/zabbix64\/zabbix_agentd.conf.d\/\*.conf/Include=\/usr\/local\/etc\/zabbix64\/zabbix_agentd.conf.d\/\*.conf/' /usr/local/etc/zabbix64/zabbix_agentd.conf

sh -c "echo Include=\/usr\/local\/etc\/zabbix\/zabbix_agentd.conf.d\/\*.conf >>/usr/local/etc/zabbix64zabbix_agentd.conf"
sh -c "echo Include=\/usr\/local\/etc\/zabbix\/zabbix_agentd.conf.d\/\*.conf >>/usr/local/etc/zabbix7/zabbix_agentd.conf"
sh -c "echo Include=\/usr\/local\/etc\/zabbix\/zabbix_agentd.conf.d\/\*.conf >>/usr/local/etc/zabbix72/zabbix_agentd.conf"

/usr/local/etc/rc.d/zabbix_agentd restart
