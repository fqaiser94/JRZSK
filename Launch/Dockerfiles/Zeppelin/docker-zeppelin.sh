#!/bin/bash

export ZEPPELIN_HOME=/opt/zeppelin
export ZEPPELIN_CONF_DIR="${ZEPPELIN_HOME}/conf"
/opt/zeppelin/bin/zeppelin.sh "${ZEPPELIN_CONF_DIR}"
