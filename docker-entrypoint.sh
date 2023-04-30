#!/bin/sh

PID_FILE=/app/tmp/pids/server.pid
if [ -f "$PID_FILE" ]; then
    rm -f "$PID_FILE"
fi
bin/rails server -b 127.0.0.1 -p ${DOCKER_WEB_PORT:-5000}
