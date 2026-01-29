### Tailscale

Tailscale is a zero-config VPN that works on any device.

```shell
# Enable port forwarding for exit node
printf '%s\n' 'net.ipv4.ip_forward = 1' 'net.ipv6.conf.all.forwarding = 1' | sudo tee /etc/sysctl.d/99-tailscale.conf && sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
```

Note: to use the local network when using exit node, run `sudo tailscale set --advertise-routes 10.0.0.0/25` (with your subnet), but _Don't_ approve the route in the UI.
This will make the route work when using exit node, but not normally.

Make sure to go to [machines](https://login.tailscale.com/admin/machines) and select `Disable key expiry` next to the device!

### Optionally, also set [dns settings](https://login.tailscale.com/admin/dns) to route to the Pi Hole.

1. Copy the Tailscale IP from the Pi Hole [machine page](https://login.tailscale.com/admin/machines)
2. Set `Global nameservers` to the copied IP
   1. Add nameserver -> custom
   2. Paste
   3. Optionally `Use with exit node`
   4. Save
3. Enable `Override DNS servers` to make sure clients use the new DNS settings
