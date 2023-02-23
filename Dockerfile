ARG  UBUNTU_VERSION=rolling
FROM ubuntu:${UBUNTU_VERSION}

USER root

# Install packages with root
WORKDIR /
COPY init.sh /init.sh
RUN chmod +x /init.sh && bash /init.sh
RUN rm /init.sh

# Create account and switch
RUN adduser --create-home --disabled-password --gecos '' runner
RUN adduser runner sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER runner

# Install packages with rootless
USER root
COPY init_runner.sh /home/runner/init_runner.sh
RUN chown runner /home/runner/init_runner.sh
USER runner
RUN chmod +x /home/runner/init_runner.sh && bash /home/runner/init_runner.sh
RUN rm /home/runner/init_runner.sh