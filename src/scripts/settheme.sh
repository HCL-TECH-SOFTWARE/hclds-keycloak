#!/bin/sh

BIND_ADDRESS="${KEYCLOAK_BIND_ADDRESS:-$(hostname --fqdn)}"
HTTP_PORT="${KEYCLOAK_HTTP_PORT:-8080}"
RELATIVE_PATH="${KEYCLOAK_HTTP_RELATIVE_PATH:-"/"}"

KEYCLOAK_HOST=http://$BIND_ADDRESS:$HTTP_PORT$RELATIVE_PATH
KEYCLOAK_DEFAULT_THEME=hcl

echo "Running script to set default theme"
# Wait until Keycloak API endpoint is available
# Try to connect to the keycloak server if it has started or not.
SET_THEME_COMMAND="./kcadm.sh update realms/master \
    --server $KEYCLOAK_HOST \
    --realm master \
    --user $KEYCLOAK_ADMIN \
    --password $KEYCLOAK_ADMIN_PASSWORD \
    -s loginTheme=$KEYCLOAK_DEFAULT_THEME"

until $SET_THEME_COMMAND > /dev/null; do
    echo "Waiting for the Keycloak Server to start"
    sleep 10
done