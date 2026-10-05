FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --silent
COPY . ./
RUN npm run build

# Stage 2 - production 
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
