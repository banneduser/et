#!/bin/bash

# Probe is a tool for viewing the state of an ad-hoc et cluster
# There are currently no arguments it accepts. You can just run 'probe'.

local_ram=$(free -m | grep Mem | awk '{print $2}')
upstream=$(ssh default@$UPSTREAM -p 8022 "uname -a")
upstream_ram=$(ssh default@$UPSTREAM -p 8022 "free -m | grep Mem")
upstream_ram=$(echo $upstream_ram|awk '{print $2}')
batstat=$(ssh default@$UPSTREAM -p 8022 "termux-battery-status" | jq -r ".percentage")
data_stores=$(ssh default@$UPSTREAM -p 8022 "du -hs .et/backups/")

echo "Machine hostname: $HOSTNAME"
echo ''
echo 'Connections: '
echo "'up' ($UPSTREAM)" 
echo $upstream | awk '{print "\tOS: " $1}'
echo $upstream | awk '{print "\tHostname: " $2}'
echo $upstream | awk '{print "\tKernel: " $3}'
echo "	Upstream RAM:" $upstream_ram"M"
echo "	Processor count:" $(ssh default@$UPSTREAM -p 8022 "cat /proc/cpuinfo" | grep processor | wc -l)
echo "	Battery state: $batstat%"
echo "  	Stashed data: $data_stores"
