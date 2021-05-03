FROM ubuntu:18.04

COPY ./build1.1.5.1-20141117.sh /tmp
RUN chmod +x /tmp/build1.1.5.1-20141117.sh

# true = include blockchain snapshot / false = starts from block 0
RUN /tmp/build1.1.5.1-20141117.sh true

EXPOSE 61143
#ENTRYPOINT /opt/cryptoescudo/cryptoescudod -datadir=/opt/cryptoescudo/data -daemon"]