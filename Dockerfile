FROM scratch
ARG TARGETPLATFORM
COPY $TARGETPLATFORM/SecureElections /usr/bin/SecureElections
COPY config/config.yaml /etc/secureelections/config.yaml
ENTRYPOINT ["/usr/bin/SecureElections"]
