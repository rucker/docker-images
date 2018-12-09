FROM rucker/ubuntu-baseimage:latest

RUN apt-get update && apt-get install -y git-core htop sudo tmux tree vim

ARG user=$USER
RUN useradd $user --create-home -G sudo &&\
    passwd -d $user
