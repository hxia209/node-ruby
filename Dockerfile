FROM ubi8/ruby-2.6

ENV NODEJS_VERSION=12 \
    NPM_RUN=start \
    NAME=nodejs \
    NPM_CONFIG_PREFIX=$HOME/.npm-global \
    PATH=$HOME/node_modules/.bin/:$HOME/.npm-global/bin/:$PATH

RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo \
    yum -y module reset nodejs && yum -y module enable nodejs:$NODEJS_VERSION && \
    INSTALL_PKGS="nodejs npm nodejs-nodemon nss_wrapper yarn" && \
    ln -s /usr/lib/node_modules/nodemon/bin/nodemon.js /usr/bin/nodemon && \
    yum remove -y $INSTALL_PKGS && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum -y clean all --enablerepo='*'

