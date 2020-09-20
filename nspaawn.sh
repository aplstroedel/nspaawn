#!/usr/bin/env bash

if [[ ! $(id -u) == 0 ]]
then
 echo 'run this script as root please'
 exit
fi

OPTIND=1
while getopts "ipsn:b:m:r:h" options
do
 case "$options" in
 i) init=true;;
 p) prepare=true;;
 s) start=true;;
 n) name=$OPTARG;;
 b) bridge=$OPTARG;;
 m) macvlan=$OPTARG;;
 r) release=$OPTARG;;
 h) printf '%s\n' '
  i) init
  p) prepare
  s) start
  n) name
  b) bridge
  m) macvlan
  r) release
  h) help
  1. initiate a machine like this: sudo ./nspaawn -i -n c1 -r jessie.
  2. go and remove /var/lib/machine/c1/etc/securetty manually.
  3. change root password after using: sudo ./nspaawn -p -n c1.
  4. exit the container by pressing ^+]]].
  5. boot back into the machine like this: sudo ./nspaawn -s -n c1 -b br0.
 ';;
 esac
done

dest=/var/lib/machines

if [[ "$init" == true && "$name" && "$release" ]]    # nspaawn -i -n c1 -r jessie -b br0
then
 mkdir "$dest/$name"
 debootstrap --arch=amd64 "$release" "$dest/$name"
elif [[ "$prepare" == true && "$name" ]]    # nspaawn -p -n c1
then
 systemd-nspawn -D "$dest/$name"
elif [[ "$start" && "$name" && "$bridge" ]]    # nspaawn -s -n c1 -b br0
then
 systemd-nspawn -D "$dest/$name" --network-bridge="$bridge" -b
elif [[ "$start" == true && "$name" && "$bridge" && "$macvlan" ]]    # nspaawn -s -n c1 -b br0 -m br0.10
then
 systemd-nspawn -D "$dest/$name" --network-bridge="$bridge" --network-macvlan="$macvlan" -b
fi
