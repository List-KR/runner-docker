FROM ubuntu

USER root

WORKDIR /
COPY init.sh /init.sh
RUN chmod +x /init.sh && bash /init.sh

COPY init_runner.sh /home/runner/init_runner.sh
RUN chown runner /home/runner/init_runner.sh
RUN rm /init.sh
USER runner
RUN chmod +x /home/runner/init_runner.sh && bash /home/runner/init_runner.sh
RUN rm /home/runner/init_runner.sh