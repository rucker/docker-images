FROM rucker/ubuntu-baseimage

ARG user=$USER

# Configure user
RUN useradd $user --create-home -g sudo
RUN passwd -d $user

