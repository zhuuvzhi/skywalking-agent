FROM frolvlad/alpine-java:jdk8-slim

LABEL maintainer="alex.zhu@gmail.com"

ENV SKYWALKING_VERSION=8.0.0

ADD https://mirrors.bfsu.edu.cn/apache/skywalking/${SKYWALKING_VERSION}/apache-skywalking-apm-${SKYWALKING_VERSION}.tar.gz /

RUN tar -zxvf apache-skywalking-apm-${SKYWALKING_VERSION}.tar.gz && \
    mv apache-skywalking-apm-bin skywalking && \
    mv /skywalking/agent/optional-plugins/apm-trace-ignore-plugin* /skywalking/agent/plugins/ && \
    rm -f apache-skywalking-apm-${SKYWALKING_VERSION}.tar.gz
    echo -e "\n# Ignore Path" >> /skywalking/agent/config/agent.config && \
    echo "# see https://github.com/apache/skywalking/blob/v6.2.0/docs/en/setup/service-agent/java-agent/agent-optional-plugins/trace-ignore-plugin.md" >> /skywalking/agent/config/agent.config && \
    echo 'trace.ignore_path=${SW_IGNORE_PATH:/health}' >> /skywalking/agent/config/agent.config
    
RUN apk --no-cache add tzdata  && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone
