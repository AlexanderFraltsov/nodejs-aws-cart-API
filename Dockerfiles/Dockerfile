# Base
FROM node:12-alpine as base

WORKDIR /app

# Dependencies
COPY package*.json ./
RUN npm install

# Build
WORKDIR /app
COPY . .
RUN npm run build

# couchbase sdk requirements
RUN apk update && apk add yarn curl bash python g++ make && rm -rf /var/cache/apk/*

# install node-prune
RUN curl -sfL https://install.goreleaser.com/github.com/tj/node-prune.sh | bash -s -- -b /usr/local/bin

# remove development dependencies
RUN npm prune --production

# run node prune
RUN /usr/local/bin/node-prune


# App
FROM node:12-alpine AS application

COPY --from=base /app/package.json ./
COPY --from=base /app/dist ./dist

USER node
ENV port=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]
