FROM debian:wheezy

RUN apt-get update \
  && apt-get install -y mongodb \
  wget make g++ autoconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev python

RUN wget https://github.com/git/git/archive/v2.4.5.tar.gz
RUN tar xzf v2.4.5.tar.gz
RUN echo "cd git-2.4.5 && make configure && ./configure --prefix=/usr && make all && make install" > build_git
RUN sh build_git

RUN git clone https://github.com/joyent/node.git

RUN echo "cd node && git checkout v0.11.13-release && ./configure && make && make install" > build_node

RUN sh build_node

RUN rm build_git
RUN rm -Rf git-2.4.5
RUN rm build_node
RUN rm -Rf node

RUN apt-get remove -y \
  wget make g++ autoconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev python

RUN git --version
RUN node --version
