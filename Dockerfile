FROM ubuntu:18.04

ARG HttpProxy
ARG HttpsProxy
ARG NoProxy

ENV http_proxy $HttpProxy
ENV https_proxy $HttpsProxy
ENV no_proxy $NoProxy

# Install Oracle Java 8:

#RUN apt-get update
#RUN apt-get install -y software-properties-common
#RUN add-apt-repository ppa:webupd8team/java
#RUN apt-get update
#RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
#RUN apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default
#RUN apt-get clean all

# The PPA above has been discontinued - see http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html
# For this reason, need to download the JRE and install it the manual way;
# https://askubuntu.com/questions/56104/how-can-i-install-sun-oracles-proprietary-java-jdk-6-7-8-or-jre#answer-56119

COPY ./jre-8u221-linux-x64.tar.gz /

RUN mkdir -p /usr/lib/jvm && \
    tar -xvf jre-8u221-linux-x64.tar.gz -C /usr/lib/jvm/ && \
    update-alternatives --install /usr/bin/java java /usr/lib/jvm/jre1.8.0_221/bin/java 0

RUN apt-get update && \
    apt-get install -y wget unzip

# Install ReadyAPI:
# https://support.smartbear.com/readyapi/docs/general-info/install/install-headless.html
RUN wget -P /usr/src/ "http://dl.eviware.com/ready-api/2.6.0/ReadyAPI-x64-2.6.0.sh" && \
    chmod +x /usr/src/ReadyAPI-x64-2.6.0.sh && \
    /usr/src/ReadyAPI-x64-2.6.0.sh -q -console -dir /opt/ready-api

# Install ReadyAPI License Manager:
# https://support.smartbear.com/readyapi/docs/general-info/licensing/headless/floating.html
RUN wget -P /usr/src/ "http://dl.eviware.com/ready-api/license-manager/ready-api-license-manager.zip" && \
    unzip /usr/src/ready-api-license-manager.zip -d /opt

COPY ./expect /
RUN apt-get install -yq expect
