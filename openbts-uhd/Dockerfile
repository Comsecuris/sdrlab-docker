FROM uhd
MAINTAINER Ralf-Philipp Weinmann <ralf@comsecuris.com>
RUN apt-get update
WORKDIR /home/user/src

# install OpenBTS deps
RUN apt-get install -y libortp-dev libsqlite3-dev libreadline-dev libzmq3-dev libosip2-dev psmisc sqlite3 libtool-bin

# kalibrate, which we find quite indispensable
RUN git clone http://github.com/ttsou/kalibrate-uhd.git
RUN cd kalibrate-uhd && autoreconf -i && ./configure && make install
RUN git clone https://github.com/anatol/google-coredumper
RUN cd google-coredumper && autoreconf -i && ./configure && make install
RUN git clone https://github.com/RangeNetworks/liba53.git
RUN cd liba53 && perl -i -pe 's|/usr/|/usr/local/|g' Makefile && make install
RUN git clone https://github.com/RangeNetworks/openbts.git
RUN cd openbts/ && git submodule init && git submodule update && sh autogen.sh && ./configure --with-uhd && make -j8 install
RUN git clone https://github.com/RangeNetworks/smqueue
RUN cd smqueue && git submodule init && git submodule update && sh autogen.sh && ./configure && make -j8 install
RUN git clone https://github.com/RangeNetworks/subscriberRegistry.git
RUN cd subscriberRegistry && git submodule init && git submodule update && sh autogen.sh && ./configure && make -j8 install
WORKDIR /OpenBTS
RUN ldconfig && sqlite3 -init /etc/OpenBTS/OpenBTS.example.sql /etc/OpenBTS/OpenBTS.db ".quit" 
