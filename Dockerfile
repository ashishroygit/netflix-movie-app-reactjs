# Multi-stage build for Netflix Movie App
FROM node:18-alpine AS build

WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci --only=production

COPY . .
RUN npm run build

# Runtime-only: uses dist/ produced by build stage
FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/ /usr/share/nginx/html/
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD wget -qO- http://127.0.0.1/ || exit 1
