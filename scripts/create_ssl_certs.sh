#!/bin/sh

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config"
set -eo pipefail
[[ $DOKKU_TRACE ]] && set -x
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common-functions"
source "$PLUGIN_CORE_AVAILABLE_PATH/common/functions"
source "$PLUGIN_CORE_AVAILABLE_PATH/common/property-functions"
source "$PLUGIN_AVAILABLE_PATH/config/functions"
if [[ -f "$PLUGIN_AVAILABLE_PATH/docker-options/functions" ]]; then
  source "$PLUGIN_AVAILABLE_PATH/docker-options/functions"
fi

postgres_service_dir="$1"

dokku_log_verbose_quiet "ciao"
dokku_log_verbose_quiet "$postgres_service_dir"

cd "$postgres_service_dir"
mkdir certs && cd certs
openssl req -new -newkey rsa:4096 -x509 -days 365000 -nodes -out server.crt -keyout server.key -batch
