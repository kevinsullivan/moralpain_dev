FROM python:3.13-slim-bookworm
LABEL org.opencontainers.image.description="MoralPain development container"

ARG DEBIAN_FRONTEND=noninteractive
ARG YQ_VERSION=4.2.0
ARG GH_VERSION=2.87.2
ARG SAM_VERSION=1.133.0
ARG OPENAPI_GENERATOR_VERSION=7.11.0
ARG FLUTTER_VERSION=3.32.1

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    PYTHONIOENCODING=utf-8 \
    SHELL=/bin/bash \
    OPENAPI_GENERATOR_VERSION=${OPENAPI_GENERATOR_VERSION}

SHELL ["/bin/bash", "-c"]
USER root

# ----- Base tools -----
RUN apt-get update --fix-missing && \
    apt-get install --no-install-recommends --assume-yes \
    build-essential \
    curl \
    git \
    git-lfs \
    openssh-client \
    gnupg2 \
    graphviz \
    less \
    libconfig-dev \
    libffi-dev \
    libssl-dev \
    locales \
    lsb-release \
    pkg-config \
    software-properties-common \
    unzip \
    vim \
    wget \
    zip \
    sudo && \
    sed -i '/en_US.UTF-8/s/^# //' /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# ----- Amazon Corretto 21 + Maven (system-wide) -----
# Java required by openapi-generator-cli and Lambda functions.
RUN curl -fsSLo /tmp/corretto.gpg https://apt.corretto.aws/corretto.key && \
    gpg --dearmor -o /usr/share/keyrings/corretto.gpg /tmp/corretto.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/corretto.gpg] https://apt.corretto.aws stable main" \
        > /etc/apt/sources.list.d/corretto.list && \
    apt-get update && \
    apt-get install --no-install-recommends --assume-yes java-21-amazon-corretto-jdk maven && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/corretto.gpg
ENV JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto

# ----- Claude Code CLI (system-wide) -----
RUN curl -fsSL https://claude.ai/install.sh | bash

# ----- yq (system-wide, architecture-aware) -----
RUN ARCH=$(dpkg --print-architecture) && \
    case "$ARCH" in \
      amd64) YQ_ARCH=amd64 ;; \
      arm64) YQ_ARCH=arm64 ;; \
      *) echo "Unsupported arch: $ARCH" && exit 1 ;; \
    esac && \
    curl -fsSLo /tmp/yq.tar.gz "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_${YQ_ARCH}.tar.gz" && \
    tar -xzf /tmp/yq.tar.gz -C /tmp && \
    mv /tmp/yq_linux_${YQ_ARCH} /usr/local/bin/yq && \
    chmod +x /usr/local/bin/yq && \
    rm -f /tmp/yq.tar.gz

# ----- GitHub CLI (system-wide, architecture-aware) -----
RUN ARCH=$(dpkg --print-architecture) && \
    case "$ARCH" in \
      amd64) GH_ARCH=amd64 ;; \
      arm64) GH_ARCH=arm64 ;; \
      *) echo "Unsupported arch: $ARCH" && exit 1 ;; \
    esac && \
    curl -fsSLo /tmp/gh.tar.gz "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${GH_ARCH}.tar.gz" && \
    tar -xzf /tmp/gh.tar.gz -C /tmp && \
    mv /tmp/gh_${GH_VERSION}_linux_${GH_ARCH}/bin/gh /usr/local/bin/gh && \
    chmod +x /usr/local/bin/gh && \
    rm -rf /tmp/gh.tar.gz /tmp/gh_${GH_VERSION}_linux_${GH_ARCH}

# ----- Flutter SDK (system-wide) -----
RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git /opt/flutter && \
    /opt/flutter/bin/flutter precache && \
    /opt/flutter/bin/flutter config --no-analytics
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"

# ----- Create non-root user and workspace -----
RUN useradd -m -s /bin/bash dev && \
    usermod -aG sudo dev && \
    echo 'dev ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/dev && \
    chmod 0440 /etc/sudoers.d/dev && \
    mkdir -p /home/dev/app && chown -R dev:dev /home/dev/app && \
    chown -R dev:dev /opt/flutter

# Make the workspace path safe for Git even if mounted by host
RUN git config --global --add safe.directory /home/dev/app && \
    git config --global --add safe.directory /opt/flutter

# ----- Switch to dev for user-scoped installs -----
USER dev
WORKDIR /home/dev

ENV PATH="/home/dev/.local/bin:/usr/local/bin:${PATH}"

# ----- openapi-generator-cli (user-local, pinned via OPENAPI_GENERATOR_VERSION env) -----
RUN mkdir -p /home/dev/.local/bin && \
    curl -fsSLo /home/dev/.local/bin/openapi-generator-cli \
    https://raw.githubusercontent.com/OpenAPITools/openapi-generator/v${OPENAPI_GENERATOR_VERSION}/bin/utils/openapi-generator-cli.sh && \
    chmod +x /home/dev/.local/bin/openapi-generator-cli

# ----- AWS CLI v2 (user-local, architecture-aware) -----
RUN ARCH=$(dpkg --print-architecture) && \
    case "$ARCH" in \
      amd64) AWS_ARCH=x86_64 ;; \
      arm64) AWS_ARCH=aarch64 ;; \
      *) echo "Unsupported arch: $ARCH" && exit 1 ;; \
    esac && \
    curl -fsSLo /tmp/awscliv2.zip "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_ARCH}.zip" && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install --bin-dir /home/dev/.local/bin --install-dir /home/dev/.local/lib/aws-cli && \
    rm -rf /tmp/aws /tmp/awscliv2.zip
ENV SAM_CLI_TELEMETRY=0

# ----- AWS SAM CLI (user-local, architecture-aware) -----
RUN ARCH=$(dpkg --print-architecture) && \
    case "$ARCH" in \
      amd64) SAM_ARCH=x86_64 ;; \
      arm64) SAM_ARCH=arm64 ;; \
      *) echo "Unsupported arch: $ARCH" && exit 1 ;; \
    esac && \
    curl -fsSLo /tmp/samcli.zip "https://github.com/aws/aws-sam-cli/releases/download/v${SAM_VERSION}/aws-sam-cli-linux-${SAM_ARCH}.zip" && \
    unzip -q /tmp/samcli.zip -d /tmp/sam-installation && \
    /tmp/sam-installation/install --bin-dir /home/dev/.local/bin --install-dir /home/dev/.local/lib/aws-sam-cli && \
    rm -rf /tmp/sam-installation /tmp/samcli.zip

# ----- Sceptre (user-local) -----
RUN pip install --user --no-cache-dir 'sceptre>=3,<4' 'networkx<3.2' 'sceptre-sam-handler==0.3.1'

# Workspace
WORKDIR /home/dev/app

# Keep the devcontainer running so VS Code can attach
CMD ["sleep", "infinity"]
