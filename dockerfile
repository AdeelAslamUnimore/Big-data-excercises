# Use Ubuntu as the base image
FROM ubuntu:20.04

# Update package lists and install necessary tools
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk scala python3 curl wget vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a directory named "BDMG" inside the container
WORKDIR /BDMG

# Create a directory Nimbus and download Apache Storm
RUN mkdir Nimbus
WORKDIR Nimbus
RUN wget https://dlcdn.apache.org/storm/apache-storm-2.5.0/apache-storm-2.5.0.tar.gz
RUN tar -xvf apache-storm-2.5.0.tar.gz

# Download your own storm.yaml file
RUN wget -O storm.yaml https://raw.githubusercontent.com/AdeelAslamUnimore/Big-data-excercises/Streaming/storm.yaml

RUN mv storm.yaml /BDMG/Nimbus/apache-storm-2.5.0/conf
# Go back to the BDMG directory
WORKDIR /BDMG

# Repeat the same process for Supervisor
RUN mkdir Sup
WORKDIR Sup
RUN wget https://dlcdn.apache.org/storm/apache-storm-2.5.0/apache-storm-2.5.0.tar.gz
RUN tar -xvf apache-storm-2.5.0.tar.gz
RUN wget -O storm.yaml https://raw.githubusercontent.com/AdeelAslamUnimore/Big-data-excercises/Streaming/storm.yaml
RUN mv storm.yaml /BDMG/Sup/apache-storm-2.5.0/conf

# Repeat the process for zookeeper
WORKDIR /BDMG
RUN mkdir Zookeeper
WORKDIR Zookeeper
RUN wget https://dlcdn.apache.org/zookeeper/zookeeper-3.8.3/apache-zookeeper-3.8.3-bin.tar.gz
RUN tar -xvf apache-zookeeper-3.8.3-bin.tar.gz
RUN wget -O zoo.cfg https://raw.githubusercontent.com/AdeelAslamUnimore/Big-data-excercises/Streaming/zoo.cfg
RUN mv zoo.cfg /BDMG/Zookeeper/apache-zookeeper-3.8.3-bin/conf

# Expose ports 2181, 2182, 9092, and Storm Nimbus Thrift port 6627, and port 80


EXPOSE 2181 2182 9092 6627 80 8090 6700 6701 6702 6703

# Set the working directory to /BDMG
WORKDIR /BDMG

# Define an entry point to run a shell
ENTRYPOINT ["/bin/sh", "-c", "echo 'Container is running...'; sleep infinity"]

