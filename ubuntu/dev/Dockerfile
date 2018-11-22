FROM rucker/ubuntu-baseimage:latest

RUN apt-get update && apt-get install -y git-core htop sudo tmux tree vim

# Configure user
ARG user=$USER
#TODO groupadd #user, usermod -Ag $user $user
RUN useradd $user --create-home -g sudo
RUN passwd -d $user
RUN chown -R $user:$user /home/$user
