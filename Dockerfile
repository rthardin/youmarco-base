FROM google/cloud-sdk
RUN sed -i -- 's/\"disable_updater\": true/\"disable_updater\": false/g' /google-cloud-sdk/lib/googlecloudsdk/core/config.json
RUN sed -i -- 's?\(deb http://security.debian.org/ jessie/updates main\)?#\1?' /etc/apt/sources.list
RUN apt-get install -y python-pip curl git xvfb net-tools
RUN gcloud components update -q app-engine-python app-engine-php app-engine-python app-engine-java
RUN curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb > google.deb
RUN dpkg -i google.deb; exit 0
RUN apt-get install -y -f
RUN rm -f google.deb
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -
RUN apt-get install -y nodejs
RUN npm config set registry http://registry.npmjs.org/
RUN npm install -g grunt-cli node-gyp
RUN node-gyp install
