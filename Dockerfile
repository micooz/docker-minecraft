# Base system is the latest version of ubuntu.
FROM ubuntu:latest
MAINTAINER Micooz <micooz@hotmail.com>

# Make sure we don't get notifications we can't answer during building.
ENV DEBIAN_FRONTEND noninteractive

# Download and install everything from the repos.
RUN apt-get update
RUN apt-get --yes upgrade
RUN apt-get --yes install software-properties-common vim
RUN sudo apt-add-repository --yes ppa:webupd8team/java; apt-get --yes update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    apt-get --yes install curl oracle-java8-installer

# Add setting files
COPY settings /data/

# Add pre-downloaded binary jar
COPY ./bin/minecraft_server.1.8.8.jar /data/minecraft_server.jar

# Add an entry command
COPY ./scripts/start.sh /start.sh

# Fix all permissions
RUN chmod +x /start.sh

# 25565 is for minecraft
EXPOSE 25565

# /data contains static files and database
VOLUME ["/data"]

# /start runs it.
CMD    ["/start.sh"]