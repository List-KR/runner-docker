FROM ghcr.io/actions/actions-runner

USER root

WORKDIR /
COPY init.sh /init.sh
RUN chmod +x /init.sh && /init.sh

USER runner

RUN chmod +x ~/*