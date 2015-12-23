FROM objectuser/basejava
MAINTAINER https://github.com/objectuser/angular-test

RUN \
  apt-get update \
  && apt-get upgrade -y

# Support for various NPM dependencies
RUN apt-get install -y vim git wget libfreetype6 libfontconfig bzip2 make g++ \
  build-essential libssl-dev python

# Support for running Chrome headless
RUN apt-get install -y xvfb

RUN useradd -m tester
ADD install-node.sh /home/tester/
RUN chmod +x /home/tester/install-node.sh
ADD install-chrome.sh /home/tester/
RUN chmod +x /home/tester/install-chrome.sh

# Install Google Chrome
RUN /home/tester/install-chrome.sh

USER tester
WORKDIR /home/tester

VOLUME /app

# Install Node.JS
RUN /home/tester/install-node.sh

CMD cd /app && ./test.sh
