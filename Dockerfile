# Use Nginx as base image
FROM nginx:alpine

# Copy index.html to nginx web root
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80