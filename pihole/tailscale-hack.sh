#!/bin/sh
set_netmask(){
  # ifconfig tailscale0 netmask 255.192.0.0
  addr=$(ip -4 addr show dev tailscale0 2>/dev/null | awk '/inet/{print $2}' | cut -d/ -f1)
  [ -n "$addr" ] || return 0 # There's no ipv4 address
  echo "Setting tailscale0 netmask"
  ip -4 addr del "$addr/32" dev tailscale0
  ip -4 addr add "$addr/10" dev tailscale0
}
set_netmask 2>/dev/null
while true; do
  echo "Startup"
  if ! ip -4 monitor dev tailscale0 | head -n1; then
    echo "ip monitor failed, does the interface exist?"
    sleep 5 # the interface doesn't exist yet, wait a bit and try again
  fi
  set_netmask
done
