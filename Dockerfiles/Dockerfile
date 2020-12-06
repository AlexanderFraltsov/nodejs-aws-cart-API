# Base
FROM node:12.20.0-alpine3.9 as base

WORKDIR /app

# Dependencies
COPY package*.json ./
RUN npm install

# Build
WORKDIR /app
COPY . .
RUN npm run build

# couchbase sdk requirements
RUN apk update && apk add curl bash && rm -rf /var/cache/apk/*

# install node-prune
RUN curl -sfL https://install.goreleaser.com/github.com/tj/node-prune.sh | bash -s -- -b /usr/local/bin
RUN npm prune --production
RUN /usr/local/bin/node-prune

# App
FROM node:12.20.0-alpine3.9 AS application

COPY --from=base /app/node_modules ./node_modules
COPY --from=base /app/dist ./dist

USER node
ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["node", "dist/main.js"]
