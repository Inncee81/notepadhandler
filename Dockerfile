# syntax = docker/dockerfile:1.2
FROM node:14

ARG ENV

WORKDIR /usr/src/notepadhandler

COPY package*.json ./
COPY .npmrc ./

#debug
RUN --mount=type=secret,id=GH_TOKEN export GH_TOKEN=`cat /run/secrets/GH_TOKEN`; if [ "$ENV" = "debug" ] ; then npm install ; else  npm ci --only=production; fi

COPY . .

EXPOSE 8080

CMD [ "node", "src/server.js" ]
