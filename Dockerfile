FROM node:14-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json package-lock.json /usr/src/app/
RUN npm install && npm cache clean --force
COPY . /usr/src/app
RUN npm run build

ENV IP=0.0.0.0
ENV PORT=80

CMD [ "node", "bin/server/server.js" ]

HEALTHCHECK  --interval=5m --timeout=3s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:80/healthz || exit 1

EXPOSE 80
