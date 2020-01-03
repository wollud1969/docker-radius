FROM freeradius/debian9
MAINTAINER Wolfgang Hottgenroth <wolfgang.hottgenroth@icloud.com>

ARG RADDB="/opt/freeradius/etc/raddb"
ARG RADDB_DIST="/opt/freeradius/etc/raddb.dist"
ARG MYCONF="/opt/freeradius/etc/myconf"

RUN \
  mkdir $MYCONF && \
  mkdir $MYCONF/logs && \
  mkdir $MYCONF/certs && \
  mv $RADDB/certs/ca.pem $MYCONF/certs && \
  mv $RADDB/certs/dh $MYCONF/certs && \
  mv $RADDB/certs/server.key $MYCONF/certs && \
  mv $RADDB/certs/server.pem $MYCONF/certs && \
  mv $RADDB $RADDB_DIST && \
  mkdir $RADDB 
  
COPY radiusd.conf $RADDB
COPY clients.conf $MYCONF
COPY users $MYCONF

EXPOSE 1812/udp
CMD ["/opt/freeradius/sbin/radiusd", "-fl stdout" ]

