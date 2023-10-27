#!/bin/bash

# Assign default HCL theme to master by running settheme.sh script in background.
./settheme.sh &

# Start keycloak using default entrypoint defined by Bitnami.
BITNAMI_SCRIPTS_DIR=/opt/bitnami/scripts/keycloak
$BITNAMI_SCRIPTS_DIR/entrypoint.sh $BITNAMI_SCRIPTS_DIR/run.sh
