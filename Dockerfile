FROM ubuntu:18.04

# Setup system deps
RUN apt-get update
RUN apt-get -y install wget build-essential curl rsync tar python3.8 python3-pip git libfontconfig1
RUN apt-get remove nodejs
# Setup Node
ENV NODE_VERSION 16.18.0
ENV NPM_VERSION 8.19.2

RUN git clone https://github.com/creationix/nvm.git /.nvm
RUN echo "source /.nvm/nvm.sh" >> /etc/bash.bashrc
RUN /bin/bash -c 'source /.nvm/nvm.sh && nvm install $NODE_VERSION && nvm use $NODE_VERSION && nvm alias default $NODE_VERSION && ln -s /.nvm/versions/node/v$NODE_VERSION/bin/node /usr/local/bin/node && ln -s /.nvm/versions/node/v$NODE_VERSION/bin/npm /usr/local/bin/npm'

# Setup dockerize
RUN pip3 install git+https://github.com/larsks/dockerize


# Copy package.json
COPY ./package.json /app/
WORKDIR /app/

# Install node deps
RUN npm install --production

# Copy script
COPY ./index.js /app/


CMD ["npm", "run", "create"]
