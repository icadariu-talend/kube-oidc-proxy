# Copyright Jetstack Ltd. See LICENSE for details.
FROM alpine:latest as stage
RUN apk add --no-cache sudo \
    && adduser --disabled-password --no-create-home --uid 10001 scratchuser \
    && echo "scratchuser ALL=(ALL) NOPASSWD: /usr/bin/kube-oidc-proxy" > /etc/sudoers.d/scratchuser

FROM scratch
LABEL description="OIDC reverse proxy authenticator based on Kubernetes"

COPY --from=stage /bin/sh /bin/sh
COPY --from=stage /etc/passwd /etc/passwd
COPY --from=stage /etc/sudoers.d/scratchuser /etc/sudoers.d/scratchuser
USER scratchuser

COPY ./bin/kube-oidc-proxy /usr/bin/kube-oidc-proxy

# Run the entry point with sudo to elevate permissions
ENTRYPOINT ["sudo", "/usr/bin/kube-oidc-proxy"]
