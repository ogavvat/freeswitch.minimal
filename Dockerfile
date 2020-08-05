FROM debian:buster

RUN apt-get update && apt-get install -y git autoconf libtool-bin make g++ pkg-config \
	  zlib1g-dev libsqlite3-dev libcurl4-openssl-dev libpcre3-dev libspeexdsp-dev \
    uuid-runtime uuid-dev libjpeg-dev libtiff-dev libssl-dev yasm

WORKDIR /usr/src/
RUN git clone https://github.com/signalwire/freeswitch.git -bv1.10 freeswitch
WORKDIR ./freeswitch

COPY ./build/modules.conf ./
RUN cat modules.conf
RUN git config pull.rebase true \
    && ./bootstrap.sh -j \
    && ./configure -C --enable-portable-binary --disable-dependency-tracking \
    --host=$(DEB_HOST_GNU_TYPE) --build=$(DEB_BUILD_GNU_TYPE) \
    --prefix=/usr --localstatedir=/var --sysconfdir=/etc \
    --disable-core-libedit-support

RUN make \
    && make install

COPY ./etc_freeswitch/ /etc/freeswitch/
COPY ./usr_share_freeswitch_scripts/ /usr/share/freeswitch/scripts/
COPY ./etc_fs_cli.conf/fs_cli.conf /etc/

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]

# Install sngrep
# RUN apt-get install -y curl
RUN echo "deb http://packages.irontec.com/debian buster main" > /etc/apt/sources.list.d/sngrep.list \
    && curl http://packages.irontec.com/public.key | apt-key add - 
RUN apt-get install -y sngrep


