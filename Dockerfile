FROM ubuntu

USER root

# Install packages with root
WORKDIR /
COPY init.sh /init.sh
RUN chmod +x /init.sh && bash /init.sh
RUN rm /init.sh

# Create account and switch
RUN useradd --create-home runner
USER runner

# Install packages with rootless
USER root
COPY init_runner.sh /home/runner/init_runner.sh
RUN chown runner /home/runner/init_runner.sh
USER runner
RUN chmod +x /home/runner/init_runner.sh && bash /home/runner/init_runner.sh
RUN rm /home/runner/init_runner.sh

# Install GitHub Runner as a service
USER root
RUN chmod +x /home/runner/svc.sh && bash /home/runner/svc.sh install runner
USER runner
