ANALYTICS_AGENT_PROPERTIES="${1}/conf/analytics-agent.properties"

replaceText () {

	sed -i "s|$1|$2|g" $3
}

PROTOCOL="http"

if [ "${CONTROLLER_SSL_ENABLED}" = "true" ]; then
    PROTOCOL="https"
fi

replaceText 'ad.agent.name=analytics-agent1' "ad.agent.name=analytics-${APPLICATION_NAME}" $ANALYTICS_AGENT_PROPERTIES

replaceText 'ad.controller.url=http://localhost:8090' "ad.controller.url=$PROTOCOL://${CONTROLLER_HOST}:${CONTROLLER_PORT}" $ANALYTICS_AGENT_PROPERTIES

replaceText 'http.event.endpoint=http://localhost:9080' "http.event.endpoint=${EVENT_ENDPOINT}" $ANALYTICS_AGENT_PROPERTIES

replaceText 'http.event.name=customer1' "http.event.name=${ACCOUNT_NAME}" $ANALYTICS_AGENT_PROPERTIES

replaceText 'http.event.accountName=analytics-customer1' "http.event.accountName=${GLOBAL_ACCOUNT_NAME}" $ANALYTICS_AGENT_PROPERTIES

replaceText 'http.event.accessKey=your-account-access-key' "http.event.accessKey=${ACCOUNT_ACCESS_KEY}" $ANALYTICS_AGENT_PROPERTIES

if [ "x${PROXY_HOST}" != "x" ]; then
    replaceText 'http.event.proxyHost=' "http.event.proxyHost=${PROXY_HOST}" $ANALYTICS_AGENT_PROPERTIES
fi

if [ "x${PROXY_PORT}" != "x" ]; then
    replaceText 'http.event.proxyPort=' "http.event.proxyPort=${PROXY_PORT}" $ANALYTICS_AGENT_PROPERTIES
fi
