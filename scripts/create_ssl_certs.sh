#!/bin/sh

source "$PLUGIN_CORE_AVAILABLE_PATH/common/functions"

postgres_service_dir="$1"

dokku_log_verbose_quiet "create ssl certs dir: $postgres_service_dir"

cd "$postgres_service_dir"
mkdir certs && cd certs
openssl req -new -newkey rsa:4096 -x509 -days 365000 -nodes -out server.crt -keyout server.key -batch
