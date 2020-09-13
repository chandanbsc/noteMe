# Set the base image to Ubuntu
FROM ubuntu:18.04

# File Author / Maintainer
MAINTAINER Maintaner CK

# Update the default application repository sources list
RUN apt-get update && apt-get install -y \
    python3-dev \
    python3 \
    python3-pip \
    python3-setuptools \
    build-essential \
    python3-dev \
    git

# Set variables for project name, and where to place files in container.
ENV PROJECT=noteMe
ENV CONTAINER_HOME=/opt
ENV CONTAINER_PROJECT=$CONTAINER_HOME/$PROJECT

# Create application subdirectories
WORKDIR $CONTAINER_HOME
RUN mkdir logs

# Copy application source code to $CONTAINER_PROJECT
COPY . $CONTAINER_PROJECT

# Install Python dependencies
RUN pip3 install -r $CONTAINER_PROJECT/requirements.txt
RUN pip3 install gunicorn

# Expose the port
EXPOSE 8000

# Copy and set entrypoint
WORKDIR $CONTAINER_HOME
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
