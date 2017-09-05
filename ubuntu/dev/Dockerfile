FROM rucker/ubuntu-baseimage:latest

ARG user=$USER

# Configure user
RUN useradd $user --create-home -g sudo
RUN passwd -d $user
