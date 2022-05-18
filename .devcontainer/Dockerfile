# this image is built and updated weekly
# https://github.com/cse-labs/codespaces-images
FROM ghcr.io/cse-labs/k3d:latest

# for resolving k3d local registry
RUN apt-get update && apt-get install -y \
    libnss-myhostname

# some images require specific values
ARG USERNAME=vscode
ENV PATH $PATH:/home/${USERNAME}/.dapr/bin