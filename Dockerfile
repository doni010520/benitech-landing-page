FROM nginx:alpine

# Copia os arquivos do site
COPY index.html /usr/share/nginx/html/
COPY logo.png /usr/share/nginx/html/

# Configuração do Nginx para rodar na porta 5656
RUN echo 'server { \
    listen 5656; \
    server_name _; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
        try_files $uri $uri/ /index.html; \
    } \
    location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ { \
        expires 1y; \
        add_header Cache-Control "public, immutable"; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 5656

CMD ["nginx", "-g", "daemon off;"]
