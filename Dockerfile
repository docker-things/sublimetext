FROM gui-apps-base:21.04
MAINTAINER Gabriel Ionescu <gabi.ionescu+dockerthings@protonmail.com>

RUN echo "\n > REMOVE HOST USER\n" \
 && rm -rf /home/$DOCKER_USERNAME \
 \
 && grep -v $DOCKER_USERNAME /etc/passwd > /etc/passwd.new \
 && rm -f /etc/passwd \
 && mv /etc/passwd.new /etc/passwd \
 \
 && grep -v $DOCKER_USERNAME /etc/group > /etc/group.new \
 && rm -f /etc/group \
 && mv /etc/group.new /etc/group \
 \
 && rm -f /etc/sudoers.d/$DOCKER_USERNAME \
 \
 && echo "\n > CREATE USER\n" \
 && mkdir -p /home/sublimetext \
 && echo "sublimetext:x:$DOCKER_USERID:$DOCKER_GROUPID:sublimetext,,,:/home/sublimetext:/bin/bash" >> /etc/passwd \
 && echo "sublimetext:x:$DOCKER_USERID:" >> /etc/group \
 && mkdir -p /etc/sudoers.d \
 && echo "sublimetext ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/sublimetext \
 && chmod 0440 /etc/sudoers.d/sublimetext \
 && chown $DOCKER_USERID:$DOCKER_GROUPID -R /home/sublimetext \
 && chmod 777 -R /home/sublimetext \
 \
 && echo "\n > INSTALL DEPENDENCIES\n" \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        apt-transport-https \
        apt-utils \
        gpg-agent \
        software-properties-common \
        wget \
        sudo \
        libgl1 \
 && echo "\n > INSTALL DEV UTILITIES\n" \
 && apt-get install -y --no-install-recommends \
        git \
        subversion \
        golang \
# && add-apt-repository -y ppa:ondrej/php \
# && apt-get update \
# && apt-get install -y --no-install-recommends \
#        php7.2 \
#        php7.2-cli \
 \
 && echo "\n > INSTALL SUBLIME TEXT\n" \
 && wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - \
 && echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        sublime-text \
 \
 && echo "\n > CLEANUP\n" \
 && apt-get purge -y \
        software-properties-common \
        gpg-agent \
 && apt-get clean -y \
 && apt-get autoclean -y \
 && apt-get autoremove -y

COPY install/sublimetext /usr/bin/sublimetext
RUN chmod +x /usr/bin/sublimetext

# SET USER
WORKDIR /home/sublimetext
USER sublimetext

# ENTRYPOINT
ENTRYPOINT ["/usr/bin/sublimetext"]

