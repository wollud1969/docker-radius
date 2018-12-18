FROM freeradius/debian9
MAINTAINER Wolfgang Hottgenroth <wolfgang.hottgenroth@icloud.com>

ARG RADDB="/opt/freeradius/etc/raddb"
ARG MYCONF="/opt/freeradius/etc/myconf"

RUN \
  mkdir $MYCONF && \
  mv $RADDB/mods-config/files/authorize $MYCONF && \
  ln -s $MYCONF/authorize $RADDB/mods-config/files/authorize && \
  mv $RADDB/clients.conf $MYCONF && \
  ln -s $MYCONF/clients.conf $RADDB/clients.conf && \
  mkdir $MYCONF/certs && \
  sed -i -e "s,^certdir.\+$,certdir = "$MYCONF"/certs," $RADDB/radiusd.conf && \
  sed -i -e "s,^cadir.\+$,cadir = "$MYCONF"/certs," $RADDB/radiusd.conf && \
  mv $RADDB/certs/ca.pem $MYCONF/certs && \
  mv $RADDB/certs/dh $MYCONF/certs && \
  mv $RADDB/certs/server.key $MYCONF/certs && \
  mv $RADDB/certs/server.pem $MYCONF/certs && \
  sed -i -e "s/^\s\+private_key_password/# private_key_password/" $RADDB/mods-available/eap 
  
