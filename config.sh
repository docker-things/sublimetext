#!/bin/bash

# Command used to launch docker
DOCKER_CMD="`which docker`"

# Where to store the backups
BACKUP_PATH=""

# Where to store the communication pipes
FIFO_PATH="/tmp/docker-things/fifo"

# The name of the docker image
PROJECT_NAME="sublimetext"

# BUILD ARGS
BUILD_ARGS=(
    )

# LAUNCH ARGS
RUN_ARGS=(
    -e DISPLAY=$DISPLAY
    -v /tmp/.X11-unix:/tmp/.X11-unix

    -v $XAUTHORITY:/tmp/.Xauthority
    -e XAUTHORITY=/tmp/.Xauthority

    --memory="2g"
    --cpu-shares=1024

    -v $(pwd)/data/cache:/home/$(whoami)/.cache
    -v $(pwd)/data/codeintel:/home/$(whoami)/.codeintel
    -v $(pwd)/data/config/sublime-text-3:/home/$(whoami)/.config/sublime-text-3
    -v $(pwd)/data/config/pacmanfm:/home/$(whoami)/.config/pacmanfm
    -v $(pwd)/data/config/libfm:/home/$(whoami)/.config/libfm

    -v $(pwd)/data/Projects:/home/$(whoami)/Projects

    -v /media:/media
    -v $HOME/Desktop:$HOME/Desktop
    -v $HOME/Downloads:$HOME/Downloads
    -v $HOME/Documents:$HOME/Documents
    -v $HOME/docker:$HOME/docker
    -v $HOME/.docker-things:$HOME/.docker-things

    --rm
    -d
    )
