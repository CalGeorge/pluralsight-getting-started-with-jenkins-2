FROM jenkins/jenkins:lts

USER root
WORKDIR /root

RUN apt-get update \
    # Install Maven
    && apt-get install -y maven \
    # Install PhatomJS dependancies
    && apt-get install -y build-essential chrpath libssl-dev libxft-dev \
    && apt-get install -y libfreetype6 libfreetype6-dev \
    && apt-get install -y libfontconfig1 libfontconfig1-dev \
    # Install npm
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs \
    # Cleanup apt-get installs
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install PhantomJS
ENV PHANTOM_JS phantomjs-1.9.8-linux-x86_64

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 \
    && tar xvjf $PHANTOM_JS.tar.bz2 \
    && mv $PHANTOM_JS /usr/local/share \
    && ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin \
    && rm -f *.tar*

USER jenkins