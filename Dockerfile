FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get install -y nodejs npm rsync
USER jenkins