FROM ubuntu:latest

# Upgrade, install packages
RUN apt-get update -qq && \
    apt-get upgrade -y
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y \
    locales tzdata

# Configure system
RUN echo "America/New_York" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN sed -i 's,# en_US.UTF-8 UTF-8,en_US.UTF-8 UTF-8,' /etc/locale.gen
RUN locale-gen
