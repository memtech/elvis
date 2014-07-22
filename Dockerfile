FROM node:0.10.28
MAINTAINER Daniel Pritchett <dpritchett@gmail.com>

# upload hubot
ADD       .   /opt/memtech-hubot
WORKDIR   /opt/memtech-hubot
RUN       npm install

ENTRYPOINT bin/hubot
