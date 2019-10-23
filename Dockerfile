FROM gui-apps-base:18.04
MAINTAINER Gabriel Ionescu <gabi.ionescu+dockerthings@protonmail.com>

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        apt-transport-https \
        apt-utils \
        gpg-agent \
        software-properties-common \
        wget \
        sudo \
        pcmanfm \
        git \
        subversion \
 && add-apt-repository -y ppa:ondrej/php \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        php7.2 \
        php7.2-cli \
 && wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - \
 && echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        sublime-text \
 && apt-get clean -y \
 && apt-get autoclean -y \
 && apt-get autoremove -y

COPY install/sublimetext /usr/bin/sublimetext
RUN chmod +x /usr/bin/sublimetext

# SET USER
USER $DOCKER_USERNAME

# ENTRYPOINT
ENTRYPOINT ["/usr/bin/sublimetext"]

