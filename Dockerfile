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

# Install Rust
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh -s -- -y
COPY init_rust.sh ~/init_rust.sh
RUN chmod +x ~/init_rust.sh && bash ~/init_rust.sh
RUN rm ~/init_rust.sh

# GitHub Action
COPY init_runner.sh ~/init_runner.sh
RUN chmod +x ~/init_runner.sh && bash ~/init_runner.sh
RUN rm ~/init_runner.sh