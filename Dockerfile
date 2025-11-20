FROM nginx:alpine

COPY index.html /usr/share/nginx/html/
COPY logo.png /usr/share/nginx/html/
COPY og-image.png /usr/share/nginx/html/
COPY favicon.ico /usr/share/nginx/html/
COPY favicon-16x16.png /usr/share/nginx/html/
COPY favicon-32x32.png /usr/share/nginx/html/
COPY apple-touch-icon.png /usr/share/nginx/html/

RUN rm /etc/nginx/conf.d/default.conf

RUN echo 'server { \
    listen 5656; \
    server_name _; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
    location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ { \
        expires 1y; \
        add_header Cache-Control "public, immutable"; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 5656

CMD ["nginx", "-g", "daemon off;"]
