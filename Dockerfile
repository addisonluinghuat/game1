# 1. Specify the base image
FROM nginx:alpine

RUN apk add --no-cache nodejs npm

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy Godot HTML5 export files into the nginx public folder
COPY build/ /usr/share/nginx/html/

# Render uses port 10000 by default for web services
# Update nginx to listen on port 10000 or configure Render port
RUN sed -i 's/listen 80;/listen 10000;/g' /etc/nginx/conf.d/default.conf

EXPOSE 10000

CMD ["nginx", "-g", "daemon off;"]
CMD ["node", "server.js"]