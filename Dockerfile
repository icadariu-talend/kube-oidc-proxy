# Copyright Jetstack Ltd. See LICENSE for details.
FROM alpine:latest as stage
RUN adduser --disabled-password --no-create-home --uid 10001 scratchuser

FROM scratch
LABEL description="OIDC reverse proxy authenticator based on Kubernetes"

COPY --from=stage /etc/passwd /etc/passwd
USER scratchuser

COPY ./bin/kube-oidc-proxy /usr/bin/kube-oidc-proxy

ENTRYPOINT ["/usr/bin/kube-oidc-proxy"]
