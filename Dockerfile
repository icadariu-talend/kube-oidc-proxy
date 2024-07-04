# Copyright Jetstack Ltd. See LICENSE for details.
FROM alpine:latest as stage

FROM scratch
LABEL description="OIDC reverse proxy authenticator based on Kubernetes"

COPY ./bin/kube-oidc-proxy /usr/bin/kube-oidc-proxy

# Run the entry point with sudo to elevate permissions
ENTRYPOINT ["/usr/bin/kube-oidc-proxy"]
