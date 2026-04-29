FROM node:20-alpine as build
WORKDIR /app
ENV NODE_OPTIONS="--max-old-space-size=8192"

COPY package*.json ./
RUN npm install --legacy-peer-deps --ignore-scripts
COPY . .
RUN npm run build

# Production Stage
FROM nginx:alpine
COPY --from=build /app/dist/angular-conduit /usr/share/nginx/html
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]