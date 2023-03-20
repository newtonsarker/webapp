FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    wget https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17%2B35/OpenJDK17-jdk_aarch64_linux_hotspot_17_35.tar.gz && \
    tar -xzf OpenJDK17-jdk_aarch64_linux_hotspot_17_35.tar.gz && \
    mv jdk-17+35 /usr/local/temurin-17 && \
    rm -rf OpenJDK17-jdk_aarch64_linux_hotspot_17_35.tar.gz

RUN apt -y upgrade

ENV JAVA_HOME /usr/local/temurin-17
ENV PATH $JAVA_HOME/bin:$PATH




CMD java -version

CMD ["mkdir", "/home/application"]
COPY ./app/build/install/app /home/application

ENTRYPOINT ["bash", "/home/application/bin/app"]

# EXPOSE 8080
# CMD ["bash", "/app/bin/app.sh"]
