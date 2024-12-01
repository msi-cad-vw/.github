FROM quay.io/keycloak/keycloak:latest AS builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_HOSTNAME=https://msi-cad-vw-keycloak-555986620136.europe-west1.run.app
ENV KC_HOSTNAME_STRICT=false
ENV KC_HTTP_ENABLED=true
ENV KC_CACHE=local

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start"]
