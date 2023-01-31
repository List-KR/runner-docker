FROM ubuntu

USER root

WORKDIR /
COPY init.sh /init.sh
RUN chmod +x /init.sh && bash /init.sh

USER runner
COPY init_runner.sh /home/runner/init_runner.sh
RUN chmod +x /home/runner/init_runner.sh && bash /home/runner/init_runner.sh