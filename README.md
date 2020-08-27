# nspaawn
systemd-nspawn wrapper

instructions:
- git clone https://github.com/aplstroedel/nspaawn.git
- cd nspaawn
- chmod +x nspawn
- sudo nspaawn [name] [release]

note:
- first time it will just open a shell, you should change the password from the root account then.
- you might need to remove /etc/securetty first from the container directory if you can not login with the root account.
- next time you run the nspaawn, you will boot into the container and are able to login with your new password.
