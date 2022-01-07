FROM alpine/terragrunt:1.1.2
# terraform: 1.1.2 terragrunt: 0.35.14

RUN apk update && \
        apk add --no-cache vault nodejs npm yarn python3 py3-pip jq curl docker-credential-ecr-login && \
        npm config set registry https://art-bobcat.autodesk.com/artifactory/api/npm/autodesk-npm-virtual/ && \
        yarn config set registry https://art-bobcat.autodesk.com/artifactory/api/npm/autodesk-npm-virtual/ && \
        npm install -g serverless fx && \
        pip install awscli && \
        rm -rf /root/.cache /root/.npm /var/cache/apk

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set image for Jenkins environment
ARG user=iacuser
ARG group=iacuser
ARG uid=1001
ARG gid=1001

ENV IACUSER_HOME /home/iacuser
RUN addgroup -g ${gid} ${group} && adduser -D -u ${uid} -G ${group} -h ${IACUSER_HOME} -s /bin/bash ${user}

RUN chown -R ${user}:${group} ${IACUSER_HOME}

USER ${user}
WORKDIR $IACUSER_HOME

CMD ["bash", "-l"]
