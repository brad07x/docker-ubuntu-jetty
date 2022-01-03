#
# Dockerfile for Ubuntu + Jetty Web Server
#

# Based on brad07x/ubuntu-java (multiarch)
FROM brad07x/ubuntu-java:11.0.8

# Image Metadata
LABEL org.opencontainers.image.authors="bstevens@havensight.net" \
      org.opencontainers.image.created="2022-01-02T22:53:43-05:00" \
      org.opencontainers.image.source="https://github.com/brad07x/docker-ubuntu-jetty" \
      org.opencontainers.image.documentation="https://github.com/brad07x/docker-ubuntu-jetty" \
      org.opencontainers.image.version="0.1.0-alpha" \
      org.opencontainers.image.title="Unofficial Sismics Ubuntu Jetty Image" \
      org.opencontainers.image.description="Unofficial Sismics Ubuntu Jetty Image"

# Download and install Jetty
ENV JETTY_VERSION 9.4.36.v20210114
RUN wget -nv -O /tmp/jetty.tar.gz \
    "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${JETTY_VERSION}/jetty-distribution-${JETTY_VERSION}.tar.gz" \
    && tar xzf /tmp/jetty.tar.gz -C /opt \
    && mv /opt/jetty* /opt/jetty \
    && useradd jetty -U -s /bin/false \
    && chown -R jetty:jetty /opt/jetty
WORKDIR /opt/jetty
RUN chmod +x bin/jetty.sh

# Init configuration
COPY opt /opt
EXPOSE 8080
ENV JETTY_HOME /opt/jetty
ENV JAVA_OPTIONS -Xmx512m

# Set the default command to run when starting the container
CMD ["bin/jetty.sh", "run"]
