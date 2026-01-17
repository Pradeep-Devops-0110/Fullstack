FROM node:20-bullseye AS build

WORKDIR /app
COPY package*.json ./

# Install build dependencies for sharp/node-sass
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    libc6-dev \
    libvips-dev \
    && npm install --legacy-peer-deps

COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]