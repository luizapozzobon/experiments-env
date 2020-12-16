FROM pytorch/pytorch:1.4-cuda10.1-cudnn7-runtime

WORKDIR /workspace

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# No bytecode
ENV PYTHONDONTWRITEBYTECODE 1
# No log buffering
ENV PYTHONUNBUFFERED 1

# Exposing some ports
EXPOSE 8890

# gcloud, gsutil
RUN apt update && apt upgrade -y
RUN apt install -y curl bash
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin

# Node.js (so jupyter widgets work)
RUN apt-get update -yq \
    && apt-get -yq install curl gnupg ca-certificates \
    && curl -L https://deb.nodesource.com/setup_12.x | bash \
    && apt-get update -yq \
    && apt-get install -yq \
        dh-autoreconf \
        ruby=1:2.5.* \
        ruby-dev=1:2.5.* \
        nodejs

# Enabling jupyter extensions and plugins
RUN jupyter nbextension enable --py widgetsnbextension
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager 

COPY . . 

CMD bash
