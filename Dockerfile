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

# Install Rust (Bash cannot find cargo command unless bash is not restarted)
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh -s -- -y

# Install packages with rootless
USER root
COPY init_runner.sh /home/runner/init_runner.sh
RUN chown runner /home/runner/init_runner.sh
USER runner
RUN chmod +x /home/runner/init_runner.sh && bash /home/runner/init_runner.sh
RUN rm /home/runner/init_runner.sh