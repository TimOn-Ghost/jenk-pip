FROM maven:latest
RUN apt update && apt install -y git docker.io openssh-client && apt-get clean
RUN echo "{ \"insecure-registries\" : [\"10.0.1.69:8123\"] }" > /etc/docker/daemon.json
COPY id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa