###################################################################
#	HCL Confidential
#
#	OCO Source Materials
#
#	Copyright HCL Technologies Limited 2023
#
#	The source code for this program is not published or otherwise
#	divested of its trade secrets, irrespective of what has been
#	deposited with the U.S. Copyright Office.
###################################################################

ARG TAG=22.0.1
ARG IMAGE=bitnami/keycloak:$TAG

FROM $IMAGE

# ARGUMENTS
ARG KEYCLOAK_DIR=/opt/bitnami/keycloak
ARG SERVICE_USER=keycloak
ARG SERVICE_USER_GROUP=keycloak
ARG ENTRYPOINT_SCRIPT_NAME=entrypoint.sh
ARG KEYCLOAK_BIN_DIR=$KEYCLOAK_DIR/bin

# ENVIRONMENT VARIABLES

ENV ENTRYPOINT_PATH=$KEYCLOAK_BIN_DIR/$ENTRYPOINT_SCRIPT_NAME
ENV KEYCLOAK_DEFAULT_THEME=hcl
ENV KEYCLOAK_EXTRA_ARGS=--import-realm
ENV KEYCLOAK_IMPORT=ignore
ENV KEYCLOAK_IMPORT_REALM_NAME=hcl
ENV KEYCLOAK_IMPORT_CLIENT_ID=common-services-oidc-client
ENV KEYCLOAK_IMPORT_REALM_NAME=hcl
ENV KEYCLOAK_IMPORT_CNX_CLIENT_ID=hcl-cnx-oidc-client
ENV KEYCLOAK_IMPORT_CNX_CLIENT_NAME="HCL Connections"
ENV KEYCLOAK_IMPORT_DX_CLIENT_ID=hcl-dx-oidc-client
ENV KEYCLOAK_IMPORT_DX_CLIENT_NAME="HCL DX"
ENV KEYCLOAK_IMPORT_LEAP_CLIENT_ID=hcl-leap-oidc-client
ENV EYCLOAK_IMPORT_LEAP_CLIENT_ID="HCL Leap"
ENV KEYCLOAK_IMPORT_HOSTNAME=localhost
ENV CNX_IMPORT_HOSTNAME=localhost
ENV DX_IMPORT_HOSTNAME=localhost
ENV LEAP_IMPORT_HOSTNAME=localhost

# ADD FILES TO CONTAINER
COPY --chown=$SERVICE_USER:$SERVICE_USER_GROUP src/scripts/ $KEYCLOAK_BIN_DIR
COPY --chown=$SERVICE_USER:$SERVICE_USER_GROUP src/themes/ $KEYCLOAK_DIR/themes
COPY --chown=$SERVICE_USER:$SERVICE_USER_GROUP src/data/import/ $KEYCLOAK_DIR/data/import

# Assign permissions for set theme script
RUN chmod +x $KEYCLOAK_BIN_DIR/settheme.sh

WORKDIR $KEYCLOAK_BIN_DIR
ENTRYPOINT $ENTRYPOINT_PATH

USER $SERVICE_USER

EXPOSE 8080
EXPOSE 8443
