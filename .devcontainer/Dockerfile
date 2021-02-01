# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.155.1/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
FROM ubuntu:20.04
LABEL maintainer="chris@weave.works"


# Options
ARG INSTALL_ZSH="true"
ARG UPGRADE_PACKAGES="false"
ARG ENABLE_NONROOT_DOCKER="true"
ARG SOURCE_SOCKET=/var/run/docker-host.sock
ARG TARGET_SOCKET=/var/run/docker.sock
ARG USE_MOBY="true"
ARG USERNAME=kapitan
ARG USER_UID=1000
ARG USER_GID=$USER_UID
# Customisations
ARG KIND_VERSION=0.9.0
ARG GH_VERSION=1.4.0
# Kapitan Jsonnet broken on 0.29.{3,4} https://github.com/kapicorp/kapitan/issues/641
ARG KAP_VERSION=0.29.2
ARG YTT_VERSION=0.31.0
ARG CONFTEST_VERSION=0.21.0

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
COPY library-scripts/*.sh /tmp/library-scripts/
RUN apt-get update \
    && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
    # Use Docker script from script library to set things up
    && /bin/bash /tmp/library-scripts/docker-debian.sh "${ENABLE_NONROOT_DOCKER}" "${SOURCE_SOCKET}" "${TARGET_SOCKET}" "${USERNAME}" \
    # Clean up
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/

# Install kubectl
RUN curl -sSL -o /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x /usr/local/bin/kubectl

# Install Helm
RUN curl -s "https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3" | bash -

# # [Optional] install
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends python3-pip

# install kind
RUN curl -sSL -o /usr/local/bin/kind "https://kind.sigs.k8s.io/dl/v$KIND_VERSION/kind-linux-amd64" \
    && chmod +x /usr/local/bin/kind

# install gh
RUN curl -sSL -o gh_${GH_VERSION}_linux_amd64.tar.gz "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz"  \
    && tar xvf gh_${GH_VERSION}_linux_amd64.tar.gz \
    && mv gh_${GH_VERSION}_linux_amd64/bin/gh /usr/local/bin/ \
    && chmod +x /usr/local/bin/gh \
    && rm gh_${GH_VERSION}_linux_amd64.tar.gz

# install kapitan
RUN curl -sSL -o /usr/local/bin/kapitan  "https://github.com/deepmind/kapitan/releases/download/v${KAP_VERSION}/kapitan-linux-amd64" \
    && chmod +x  /usr/local/bin/kapitan 

# install ytt
RUN curl -sSL -o /usr/local/bin/ytt  "https://github.com/vmware-tanzu/carvel-ytt/releases/download/v${YTT_VERSION}/ytt-linux-amd64" \
    && chmod +x  /usr/local/bin/ytt

#  install conftest
RUN curl -sSL -o conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz "https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz" \
    && tar xzf conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz \
    && mv conftest /usr/local/bin

ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD [ "sleep", "infinity" ]