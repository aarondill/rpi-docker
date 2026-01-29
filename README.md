# Docker Pi

An attempt to containerize my Raspberry Pi setup.

## Setup

1. Install Docker and Docker Compose
2. Clone this repo
3. Configure environment variables in `.env` (see `.env.example`)
4. Run `./start.sh` to start all the containers
   - You can also run `docker-compose up` in each directory to start some of the containers

## Note

Some containers might need additional setup (i.e. Pi-hole). Check the README in each directory for more information.
