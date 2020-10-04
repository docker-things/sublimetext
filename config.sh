#!/bin/bash

# Command used to launch docker
DOCKER_CMD="`which docker`"

# Where to store the backups
BACKUP_PATH=""

# Where to store the communication pipes
FIFO_PATH="/tmp/docker-things/fifo"

# The name of the docker image
PROJECT_NAME="sublimetext"

# Meta to set in the .desktop file
APP_GENERIC_NAME="Text Editor"
APP_CATEGORIES="TextEditor;Development;"
APP_MIME_TYPE="text/plain;"
APP_PARAM="%F"

# BUILD ARGS
BUILD_ARGS=(
    )

# LAUNCH ARGS
RUN_ARGS=(
    -e DISPLAY=$DISPLAY
    -v /tmp/.X11-unix:/tmp/.X11-unix

    -v $XAUTHORITY:/tmp/.Xauthority
    -e XAUTHORITY=/tmp/.Xauthority

    --memory="4g"
    --cpu-shares=1024

    -v $(pwd)/data:/home/sublimetext
    -v /media:/media
    -v $HOME:$HOME

    --rm
    -d
    )
