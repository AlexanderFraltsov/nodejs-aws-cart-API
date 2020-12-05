FROM node:12-alpine
WORKDIR /app

# Dependencies
COPY package*.json ./
RUN npm install

# Build
COPY . .
RUN npm run build

# App
USER node
ENV port=8080
EXPOSE 8080

ENTRYPOINT ["node", "dist/main.js"]