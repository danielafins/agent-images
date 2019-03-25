FROM alpine AS builder

MAINTAINER mark.prichard@appdynamics.com

ARG APPD_AGENT_VERSION 
ARG APPD_AGENT_SHA256

RUN apk --no-cache add unzip

COPY analytics-agent-${APPD_AGENT_VERSION}.zip /
RUN if [ "x${APPD_AGENT_SHA256}" != "x" ]; then \ 
 echo "${APPD_AGENT_SHA256} *analytics-agent-${APPD_AGENT_VERSION}.zip" >> appd_checksum \
    && sha256sum -c appd_checksum \
    && rm appd_checksum \
    && unzip -oq analytics-agent-${APPD_AGENT_VERSION}.zip -d /tmp; \
   else \
     unzip -oq analytics-agent-${APPD_AGENT_VERSION}.zip -d /tmp; \
   fi

FROM openjdk:8-jre-alpine
RUN apk update && apk upgrade
COPY --from=builder /tmp /opt/appdynamics

ENV ANALYTICS_AGENT_HOME /opt/appdynamics/

COPY updateAnalyticsAgentConfig.sh /opt/appdynamics/updateAnalyticsAgentConfig.sh
RUN chmod +x /opt/appdynamics/updateAnalyticsAgentConfig.sh

COPY startup.sh /opt/appdynamics/startup.sh
RUN chmod +x /opt/appdynamics/startup.sh

EXPOSE 9090

WORKDIR ${ANALYTICS_AGENT_HOME}
CMD "/opt/appdynamics/startup.sh"
