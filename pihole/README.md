# PiHole on docker

## Setup

1. Install docker
2. Clone this repo
3. Run `docker-compose up -d`
4. Open http://0.0.0.0/admin in your browser
5. Import the teleporter zip file / setup blocklists

## Back up

The `./etc-pihole/` directory contains all the configuration files for PiHole.
Alternatively, you can use the teleporter from the admin page to back up the entire configuration.

## Lists to add (possibly outdated)

### Blocklists

```
BLOCK https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
BLOCK https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt
BLOCK https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts
BLOCK https://v.firebog.net/hosts/static/w3kbl.txt
BLOCK https://adaway.org/hosts.txt
BLOCK https://v.firebog.net/hosts/AdguardDNS.txt
BLOCK https://v.firebog.net/hosts/Admiral.txt
BLOCK https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt
BLOCK https://v.firebog.net/hosts/Easylist.txt
BLOCK https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts
ALLOW https://raw.githubusercontent.com/GoodnessJSON/PiHole-Whitelist/master/lists/whitelist.txt
```

### A list of custom domains

```
www.googleadservices.com	Exact allow Google Search Ad Links
peernetwork.netgear.com	Exact deny Netgear Phone Home
^.*\.split\.io$	Regex allow apclassroom
www.goooooooooooooooooooooooooooooooooooooooooooooooooooooooooogle.com	Exact deny Added from Query Log
time\..+	Regex allow Time Servers
smart.link	Exact allow 7-eleven links
```

## Tailscale

See the README in the [tailscale-docker](https://github.com/aarondill/tailscale-docker) repo for instructions on how to set up tailscale with a PiHole as the DNS.
