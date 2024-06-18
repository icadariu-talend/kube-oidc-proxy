# Copyright Jetstack Ltd. See LICENSE for details.
FROM scratch
LABEL description="OIDC reverse proxy authenticator based on Kubernetes"

COPY ./bin/kube-oidc-proxy /usr/bin/kube-oidc-proxy

CMD ["/usr/bin/kube-oidc-proxy"]
