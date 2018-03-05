# Witek Bobrowski
# Dockerfile for e-business course
#
# https://github.com/witekbobrowski/e-business-summer-2018
#

FROM ubuntu

LABEL maintainer = "Witek Bobrowski"

# Install Scala
RUN apt-get update
RUN apt-get install apt-transport-https -y
RUN apt-get install default-jdk -y
RUN apt-get install scala -y

# Install sbt
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
RUN apt-get update
RUN apt-get install sbt -y

# Setup Project
RUN mkdir /app
WORKDIR /app
COPY ./ ./
RUN sbt update
