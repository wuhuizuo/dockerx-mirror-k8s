FROM quay.io/skopeo/stable:v1.2.0

# Add jq
RUN yum -y update && yum -y install jq && yum -y clean all && rm -rf /var/cache/dnf/* /var/log/dnf* /var/log/yum*

# Add docker cli
COPY --from=docker.io/library/docker:19.03.12 /usr/local/bin/docker /usr/local/bin/

# Add buildx plugin from github
RUN mkdir -p /root/.docker/cli-plugins/ && \
    curl -sLo /root/.docker/cli-plugins/docker-buildx https://github.com/docker/buildx/releases/download/v0.4.2/buildx-v0.4.2.linux-amd64 && \
    chmod a+x /root/.docker/cli-plugins/*

# Add scripts
COPY mirror.sh entrypoint.sh /

RUN chmod a+x /mirror.sh /entrypoint.sh
 
# ENV SRC_REGISTRY SRC_USERNAME SRC_PASSWORD DEST_REGISTRY DEST_USERNAME DEST_PASSWORD
# ENV DEST_ORG_OVERRIDE

ENTRYPOINT ["/entrypoint.sh"]
