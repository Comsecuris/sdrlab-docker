FROM uhd
MAINTAINER Ralf-Philipp Weinmann <ralf@comsecuris.com>
RUN apt-get update
WORKDIR /home/user/src
COPY CHECKSUMS CHECKSUMS
# install Yate dependencies, also wget to download the tarballs
RUN apt-get install -y wget libgsm1-dev libspeex-dev
# obtain Yate and YateBTS tarballs
RUN wget http://yate.null.ro/tarballs/yate6/yate-6.0.0-1.tar.gz && wget http://yate.null.ro/tarballs/yatebts6/yate-bts-6.0.0-1.tar.gz
# verify checksums
RUN sha256sum -c CHECKSUMS && tar -xzf yate-6.0.0-1.tar.gz && tar -xzf yate-bts-6.0.0-1.tar.gz
# build and install Yate
RUN cd yate && ./configure && make && make install
# build and install YateBTS
RUN cd yate-bts && ./configure && make && make install
# kalibrate, which we find quite indispensable
RUN git clone http://github.com/ttsou/kalibrate-uhd.git
RUN cd kalibrate-uhd && autoreconf -i && ./configure && make install
