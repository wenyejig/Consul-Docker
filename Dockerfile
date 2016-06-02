FROM ubuntu:14.04
MAINTAINER wench <wenyejig@gmail.com>
ENV REFRESHED_AT 2016-06-02
ENV CONSUL_VERSION=0.6.4

RUN apt-get -qqy update
RUN apt-get -qqy install curl unzip

ADD https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip /tmp/consul.zip
RUN cd /usr/sbin && unzip /tmp/consul.zip && chmod +x /usr/sbin/consul && rm  /tmp/consul.zip

ADD https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_web_ui.zip  /tmp/webui.zip
RUN cd /tmp/ && unzip -n webui.zip -d webui && mv /tmp/webui/ /webui/

ADD consul.json /config/

EXPOSE 53/udp 8380 8301 8301/udp 8302 8302/udp 8400 8500

VOLUME ["/data"]

ENTRYPOINT ["/usr/sbin/consul","agnet","-config-dir=/config"]
CMD []
