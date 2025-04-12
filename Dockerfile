FROM ntop/ntopng:latest

RUN apt-get update && \
    apt-get -y install curl

# Download the official "fritzdump.sh" from ntopng github
RUN curl --output /fritzdump.sh https://raw.githubusercontent.com/ntop/ntopng/refs/heads/dev/tools/fritzdump.sh


# Modify the command to allow passing $NTOP_CONFIG
RUN sed -i -e 's/ntopng -i -/ntopng "$@" $NTOP_CONFIG -/g' fritzdump.sh

# Externalize the FRITZBOX_HOST, FRITZUSER, FRITZPWD parameters as env parameters 
RUN sed -i -e 's;FRITZIP=http://fritz.box;FRITZIP=${FRITZBOX_HOST:-http://fritz.box};g' fritzdump.sh 
RUN sed -i '/FRITZUSER=$1/d' fritzdump.sh
RUN sed -i '/FRITZPWD=$2/d' fritzdump.sh


RUN echo '#!/bin/bash\n/etc/init.d/redis-server start' | cat - fritzdump.sh > /run.sh && \
    chmod +x /run.sh

EXPOSE 3000

ENTRYPOINT ["/run.sh"]