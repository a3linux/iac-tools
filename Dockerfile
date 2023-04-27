FROM docker.io/alpine/terragrunt:1.4.6
# terraform: 1.4.6 terragrunt: 0.45.4

RUN apk update && \
        apk add --no-cache vault nodejs npm yarn python3 py3-pip jq curl docker-credential-ecr-login gcc musl-dev python3-dev libffi-dev openssl-dev cargo make && \
        pip install --upgrade pip && \
        pip install azure-cli && \
        pip install awscli && \
        npm install -g serverless fx && \
        rm -rf /root/.cache /root/.npm /var/cache/apk

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set image for Jenkins environment
ARG user=iacuser
ARG group=iacuser
ARG uid=1000
ARG gid=1000

ENV IACUSER_HOME /home/iacuser
RUN addgroup -g ${gid} ${group} && adduser -D -u ${uid} -G ${group} -h ${IACUSER_HOME} -s /bin/bash ${user}

RUN chown -R ${user}:${group} ${IACUSER_HOME}

USER ${user}
WORKDIR $IACUSER_HOME

CMD ["bash", "-l"]
