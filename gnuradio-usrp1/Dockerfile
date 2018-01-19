FROM uhd
MAINTAINER Ralf-Philipp Weinmann <ralf@comsecuris.com>
RUN apt-get update
WORKDIR /home/user/src

# install deps for sdcc (bison, flex), downloading source (wget) and GNU Radio
RUN apt-get install -y wget libcppunit-dev libpython-dev swig libusb-dev libgsl0-dev libaudio-dev bison flex

# USRP1 support is a frigging rabbit hole
# First of all, to be able to even have libusrp, we need to go all the way back to GNU Radio 3.4.2
RUN git clone https://github.com/gnuradio/gnuradio.git
WORKDIR /home/user/src/gnuradio
RUN git checkout v3.4.2 && git checkout -b v3.4.2 && git submodule init && git submodule update

WORKDIR /home/user/src
# to be able to build libusrp, we are missing the asx8051 compiler in Debian which we bring back by compiling sdcc 2.x from source
# sdcc 2.9.0 has build issues because they reimplemented getline() without proper configure checking
# downgrade to 2.7.0 to build this sucker
RUN wget https://ayera.dl.sourceforge.net/project/sdcc/sdcc/2.7.0/sdcc-src-2.7.0.tar.bz2
COPY CHECKSUMS CHECKSUMS
RUN sha256sum -c CHECKSUMS && tar xjf sdcc-src-2.7.0.tar.bz2

WORKDIR /home/user/src/sdcc
RUN ./configure --disable-ucsim --disable-packihx \
                --disable-gbz80-port --disable-z80-port --disable-avr-port --disable-ds390-port \
                --disable-ds400-port --disable-pic-port --disable-pic16-port \
                --disable-xa51-port --disable-hc08-port
RUN make
RUN make install

WORKDIR /home/user/src/gnuradio
# braindead idiosyncracies that can be resolved by massaging configure parameters correctly
RUN sh bootstrap && LDFLAGS="-lboost_system -lboost_filesystem -lboost_program_options" ./configure --with-boost-thread=boost_thread --with-boost-unit-test-framework=boost_unit_test_framework --disable-grc --enable-usrp --disable-usrp2 --disable-doxygen
# hackety-hack-hack: fix unresolved symbol intptr_t by augmenting config.h
RUN echo '#include <stdint.h>' >> config.h
# build it and install it
RUN make -j8 && make install
RUN echo /usr/local/lib64 > /etc/ld.so.conf.d/gnuradio.conf
RUN ldconfig
