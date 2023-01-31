FROM ubuntu

USER root

WORKDIR /
COPY init.sh /init.sh
RUN chmod +x /init.sh && bash /init.sh

USER runner
COPY --chown=runner init_runner.sh ~/init_runner.sh
RUN chmod +x ~/init_runner.sh && bash ~/init_runner.sh