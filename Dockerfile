FROM frolvlad/alpine-java:jdk8-slim

LABEL maintainer="alex.zhu@gmail.com"

ENV SKYWALKING_VERSION=8.1.0
ADD https://www.apache.org/dyn/closer.cgi/skywalking/${SKYWALKING_VERSION}/apache-skywalking-apm-es7-${SKYWALKING_VERSION}.tar.gz /

RUN tar -zxvf apache-skywalking-apm-es7-${SKYWALKING_VERSION}.tar.gz && \
    mkdir -p skywalking/agent
    mv apache-skywalking-apm-bin-es7/agent/* skywalking/agent/ && \
    rm -f apache-skywalking-apm-* &&\
    echo -e "\n# Ignore Path" >> /skywalking/agent/config/agent.config && \
    echo "# see https://github.com/apache/skywalking/blob/v6.2.0/docs/en/setup/service-agent/java-agent/agent-optional-plugins/trace-ignore-plugin.md" >> /skywalking/agent/config/agent.config && \
    echo 'trace.ignore_path=${SW_IGNORE_PATH:/health}' >> /skywalking/agent/config/agent.config
    
RUN apk --no-cache add tzdata  && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone
