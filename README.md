# Docker Pi

An attempt to containerize my Raspberry Pi setup.

## Setup

1. Install Docker and Docker Compose
2. Clone this repo
3. Configure environment variables in `.env` (see `.env.example`)
4. Run `./start.sh` to start all the containers
   - You can also run `docker-compose up` in each directory to start some of the containers

## Manual Setup

### Note

Some containers might need additional setup (i.e. Pi-hole). Check the README in each directory for more information.

### Auto-Mount Drive

This can't be containerized because it modifies the host file system.

The fstab entry attempts to mount the drive at boot time. The udev rule will run when the drive is plugged in to mount it using systemd.

Replace `<DRIVE UUID>` with the UUID of the drive you want to mount (from `blkid`).

```shell
> sudo blkid /dev/sda1
/dev/sda1: LABEL="Backup" UUID="<DRIVE UUID>" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="e430e9d2-01"
```

```fstab
# /etc/fstab
UUID=<DRIVE UUID> /backup ext4 defaults,nofail 0 0
```

```udev
# /etc/udev/rules.d/zz-backup.rules
# When the given usb becomes available, log and then start systemd mount (generated from fstab)
# Also restart the nfs server to ensure that the new drive is detected
ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_UUID}="<DRIVE UUID>", RUN+="/usr/bin/logger -t mount-usb-udev mounting the found backup", RUN+="/usr/bin/systemctl reload-or-restart --no-block -- backup.mount nfs-server.service"
```

### NFS

The NFS container doesn't seem to work due to the required kernel modules.

Install NFS on the host machine and configure `/etc/exports` to export the `/backup` directory.

```
# /etc/exports
/backup *(rw,sync,insecure,no_subtree_check,async,anonuid=1000,anongid=1000)
```

### Tailscale

Tailscale is a zero-config VPN that works on any device.

```shell
curl -fsSL https://tailscale.com/install.sh | sh # installs tailscale from package manager
sudo tailscale up --advertise-exit-node # starts tailscale and logs in
```

Make sure to go to [machines](https://login.tailscale.com/admin/machines) and select `Disable key expiry` next to the device!
