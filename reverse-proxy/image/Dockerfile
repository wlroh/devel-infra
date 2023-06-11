FROM nginx:1.25-alpine

# Install required software
RUN apk update && \ 
    apk add bash \
            vim \
    rm -rf /var/cache/apk/*

# Default nginx conf
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./default_nginx_conf /default_nginx_conf

# Entrypoint
COPY ./entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh

CMD /usr/local/bin/entrypoint.sh
