FROM node:20-alpine as build
WORKDIR /app
ENV NODE_OPTIONS="--max-old-space-size=8192"
ENV HUSKY=0

COPY package*.json ./
RUN npm install --legacy-peer-deps
COPY . .
RUN npm run build

# Production Stage
FROM nginx:alpine
COPY --from=build /app/dist/angular-conduit /usr/share/nginx/html
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]