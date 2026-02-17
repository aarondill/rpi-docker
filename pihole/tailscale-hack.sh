#!/bin/sh
while true; do
  if ! ip monitor dev tailscale0 | head -n1 2>/dev/null; then
    sleep 5 # the interface doesn't exist yet, wait a bit and try again
  fi
  echo "Setting tailscale0 netmask"
  ifconfig tailscale0 netmask 255.192.0.0
done
