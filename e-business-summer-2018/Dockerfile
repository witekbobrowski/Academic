# Witek Bobrowski
# Dockerfile for e-business course
#
# https://github.com/witekbobrowski/e-business-summer-2018
#

FROM ubuntu

LABEL maintainer = "Witek Bobrowski"

# Install Scala.
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    default-jdk \
    scala

# Install sbt.
RUN echo "deb https://dl.bintray.com/sbt/debian /" | \
    tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver \
    hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 && \
    apt-get update && apt-get install -y \
    sbt

# Install MySQL.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    mysql-server \
    mysql-client

# Expose ports.
EXPOSE 9000

# Setup project folder.
RUN mkdir /app

# Define working directory.
WORKDIR /app

COPY ./ ./
RUN sbt update
