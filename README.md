# nspaawn
systemd-nspawn wrapper

instructions:
- git clone https://github.com/aplstroedel/nspaawn.git
- cd nspaawn
- chmod +x ./nspaawn.sh

how to:
  1. initiate a machine like this: sudo ./nspaawn.sh -i -n c1 -r jessie.
  2. go and remove /var/lib/machine/c1/etc/securetty manually.
  3. change root password after using: sudo ./nspaawn.sh -p -n c1.
  4. exit the container by pressing ^+]]].
  5. boot back into the machine like this: sudo ./nspaawn.sh -s -n c1 -b br0.
