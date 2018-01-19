FROM gnuradio-usrp1
MAINTAINER Ralf-Philipp Weinmann <ralf@comsecuris.com>
RUN apt-get update
WORKDIR /home/user/src
COPY CHECKSUMS CHECKSUMS
# install Yate dependencies, also wget to download the tarballs
RUN apt-get install -y wget libgsm1-dev libspeex-dev
# obtain Yate and YateBTS tarballs
RUN wget http://yate.null.ro/tarballs/yate6/yate-6.0.0-1.tar.gz http://yate.null.ro/tarballs/yatebts6/yate-bts-6.0.0-1.tar.gz http://yate.null.ro/tarballs/yatebts5/yate-bts-5.0.0-1.tar.gz
# verify checksums
RUN sha256sum -c CHECKSUMS && tar -xzf yate-6.0.0-1.tar.gz && tar -xzf yate-bts-5.0.0-1.tar.gz
# build and install Yate
RUN cd yate && ./configure --enable-usrp && make -j8 && make install
# build and install YateBTS
RUN cd yate-bts && ./configure && make -j8 && make install
# Auxilliary tools
RUN wget http://ttsou.github.com/kalibrate/kal-v0.4.1.tar.bz2
RUN tar -xjf kal-v0.4.1.tar.bz2 && cd kal-v0.4.1 && autoreconf -i && PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig ./configure && make
RUN git clone http://github.com/ttsou/kalibrate-uhd.git
RUN cd kalibrate-uhd && autoreconf -i && ./configure && make
RUN cp kal-v0.4.1/src/kal /usr/local/bin/kal-usrp1 && cp kalibrate-uhd/src/kal /usr/local/bin/kal-uhd
