FROM nginx:alpine

# Copia os arquivos do site para o local correto
COPY index.html /usr/share/nginx/html/
COPY logo.png /usr/share/nginx/html/

# Remove a configuração padrão
RUN rm /etc/nginx/conf.d/default.conf

# Cria a nova configuração na porta 5656
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
