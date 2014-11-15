# Elvis is on the docker hub!
# to run your own pre-built copy try
# docker pull dpritchett/elvis:latest

FROM node:0.10.28
MAINTAINER Daniel Pritchett <dpritchett@gmail.com>

# Install deps
RUN apt-get update -qq
RUN apt-get install ruby -qy

# convenient stuff
RUN apt-get install tmux tree ack-grep -qy

# cache the deps in a docker layer
ADD       package.json  /apps/elvis/package.json
ADD       node_modules  /apps/elvis/node_modules
WORKDIR   /apps/elvis
RUN       npm install

# upload the rest of the bot code
ADD       .   /apps/elvis

# Fail the build if elvis is dead
RUN       bin/smoke_test.rb
