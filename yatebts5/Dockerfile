FROM gnuradio-usrp1
MAINTAINER Ralf-Philipp Weinmann <ralf@comsecuris.com>

ENV PKG_CONFIG_PATH /usr/local/lib64/pkgconfig
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
WORKDIR /home/user/src
COPY CHECKSUMS CHECKSUMS

# Install Yate dependencies & wget to download the tarballs
RUN apt-get install -y wget libgsm1-dev libspeex-dev

# Obtain Yate and YateBTS tarballs
RUN wget http://yate.null.ro/tarballs/yate6/yate-6.0.0-1.tar.gz http://yate.null.ro/tarballs/yatebts5/yate-bts-5.0.0-1.tar.gz
# verify checksums
RUN sha256sum -c CHECKSUMS && tar -xzf yate-6.0.0-1.tar.gz && tar -xzf yate-bts-5.0.0-1.tar.gz

# Build and install Yate
RUN cd yate && ./configure --enable-usrp && make -j8 && make install
# build and install YateBTS
RUN cd yate-bts && ./configure && make -j8 && make install
# the FPGA bitstream for the USRP1 is copied into the wrong directory by YateBTS. Fix by symlinking
RUN cd /usr/local/share/usrp/rev4/ && ln -s /usr/local/lib/yate/server/bts/std_inband.rbf .

# Kalibrate for measuring and tuning the frequency offset against other GSM base stations
RUN wget http://ttsou.github.com/kalibrate/kal-v0.4.1.tar.bz2
RUN tar -xjf kal-v0.4.1.tar.bz2 && cd kal-v0.4.1 && autoreconf -i && ./configure && make
RUN git clone http://github.com/ttsou/kalibrate-uhd.git
RUN cd kalibrate-uhd && autoreconf -i && ./configure && make
RUN cp kal-v0.4.1/src/kal /usr/local/bin/kal-usrp1 && cp kalibrate-uhd/src/kal /usr/local/bin/kal-uhd

# Install Clock Tamer CLI tool (for USRP1)
RUN git clone https://github.com/myriadrf/clock-tamer && cd clock-tamer/host/tamer-spi/ && make && cp clock_tamer /usr/local/bin

# Install misc system tools (for debugging GPRS)
RUN apt-get -y install tcpdump net-tools psmisc

# Clean up
RUN mkdir -p tarballs && (mv *.tar.gz *.tar.bz2 *.tgz *.tbz2 tarballs || exit 0)
