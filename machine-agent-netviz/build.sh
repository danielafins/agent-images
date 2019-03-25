#!/usr/bin/env bash

docker build --build-arg APPD_AGENT_VERSION=$1 --build-arg  APPD_AGENT_SHA256=$2 -t appdynamics/machine-agent-netviz:$1 --no-cache  .