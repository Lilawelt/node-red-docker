FROM debian:latest AS base

RUN apt update && \
    apt install -y \
        bash \
        build-essential \
        curl \
        nodejs \
        npm \
        unattended-upgrades

RUN npm install -g --unsafe-perm node-red
RUN useradd -m nodered -s /bin/bash -u 1000

COPY entrypoint.sh /home/nodered/
RUN chmod 755 /home/nodered/entrypoint.sh

# Put the default flows in to warn if the directory isn't mounted
COPY flows.json /data/flows.json

USER nodered

# Expose the listening port of node-red
EXPOSE 1880

# Set environment var for script
ENV FLOWS=flows.json

# And run
ENTRYPOINT "/home/nodered/entrypoint.sh"

