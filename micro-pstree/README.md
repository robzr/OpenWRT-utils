# micro-pstree
Micro implementation of pstree for OpenWRT

- Written in busybox ash, only 381 bytes
- Optional argument for root PID
```
root@gw:~# pstree 885
885 /usr/sbin/dropbear -F -P /var/run/dropbear.1.pid -p 22 -K 300
L- 21757 /usr/sbin/dropbear -F -P /var/run/dropbear.1.pid -p 22 -K 300
    L- 21758 -bash
        L- 25305 screen
            L- 25306 SCREEN
                |- 25307 /bin/bash
                |   L- 32414 /bin/sh /usr/sbin/pstree 885
                L- 25309 /bin/bash
```
