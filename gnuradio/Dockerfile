FROM uhd
MAINTAINER Ralf-Philipp Weinmann <ralf@comsecuris.com>
RUN apt-get update
WORKDIR /home/user/src

# install GNURadio deps
RUN apt-get install -y libcppunit-dev libpython-dev swig

# screw PyBOMBS
RUN git clone https://github.com/gnuradio/gnuradio.git
WORKDIR /home/user/src/gnuradio
RUN git checkout v3.7.8 && git checkout -b v3.7.8 && git submodule init && git submodule update
RUN mkdir build && cd build && cmake -DENABLE_DEFAULT=OFF -DENABLE_PYTHON=ON -DENABLE_GR_UTILS=ON -DENABLE_GR_UHD=ON -DENABLE_GR_FILTER=ON -DENABLE_INTERNAL_VOLK=ON -DENABLE_VOLK=ON -DENABLE_GNURADIO_RUNTIME=ON -DENABLE_GR_FFT=ON -DENABLE_GR_BLOCKS=ON -DENABLE_GR_ANALOG=ON .. && make -j8 install
RUN ldconfig
