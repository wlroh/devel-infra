#!/bin/bash

# Checks
if [ -z "${DEFAULT_SERVER_IP}" ]; then
  printf "\n  =======¡ERROR!======="
  printf "\n  Variable 'DEFAULT_SERVER_IP' it's necessary\n"
  exit 0
fi

if [ -z "${DEFAULT_SERVER_PORT}" ]; then
  printf "\n  =======¡ERROR!======="
  printf "\n  Variable 'DEFAULT_SERVER_PORT' it's necessary\n"
  exit 0
fi

if [ -z "${ANOTHER_SERVER_IP}" ]; then
  printf "\n  =======¡ERROR!======="
  printf "\n  Variable 'ANOTHER_SERVER_IP' it's necessary\n"
  exit 0
fi

if [ -z "${ANOTHER_SERVER_PORT}" ]; then
  printf "\n  =======¡ERROR!======="
  printf "\n  Variable 'ANOTHER_SERVER_PORT' it's necessary\n"
  exit 0
fi

if [ -z "${ANOTHER_SERVER_PATH}" ]; then
  printf "\n  =======¡ERROR!======="
  printf "\n  Variable 'ANOTHER_SERVER_PATH' it's necessary\n"
  exit 0
fi


# Global variables
[ -z "${PROXY_HTTP_PORT}" ] && export PROXY_HTTP_PORT=80

# Start with default certbot conf
sed -i "s/{http_port}/${PROXY_HTTP_PORT}/" /etc/nginx/conf.d/default.conf
nginx -g "daemon on;"

# Show input enviroment variables
printf "\n  ======================================="
printf "\n  =          INPUT VARIABLES            ="
printf "\n  ======================================="
printf "\n"

printf "\n  Config NGINX:"
printf "\n    - HTTP Port: %s" "${PROXY_HTTP_PORT}"
printf "\n    - Default Server IP: %s" "${DEFAULT_SERVER_IP}"
printf "\n    - Default Server Port: %s" "${DEFAULT_SERVER_PORT}"
printf "\n    - Another Server IP: %s" "${ANOTHER_SERVER_IP}"
printf "\n    - Another Server Port: %s" "${ANOTHER_SERVER_PORT}"
printf "\n    - Another Server Path: %s" "${ANOTHER_SERVER_PATH}"

# Create index.html
mkdir -p /var/www/html
cat> /var/www/html/index.html<<EOF
Reverse Proxy Server is Running...
EOF

# Load nginx conf files
rm /etc/nginx/conf.d/*
cp /default_nginx_conf/* /etc/nginx/conf.d
sed -i "s:{http_port}:${PROXY_HTTP_PORT}:g" /etc/nginx/conf.d/*
sed -i "s:{default_server_ip}:${DEFAULT_SERVER_IP}:g" /etc/nginx/conf.d/*
sed -i "s:{default_server_port}:${DEFAULT_SERVER_PORT}:g" /etc/nginx/conf.d/*
sed -i "s:{another_server_ip}:${ANOTHER_SERVER_IP}:g" /etc/nginx/conf.d/*
sed -i "s:{another_server_port}:${ANOTHER_SERVER_PORT}:g" /etc/nginx/conf.d/*
sed -i "s:{another_server_path}:${ANOTHER_SERVER_PATH}:g" /etc/nginx/conf.d/*

# Restart nginx service
printf "\n"
printf "\n  ======================================="
printf "\n  =         START REVERSE PROXY         ="
printf "\n  ======================================="
printf "\n\n"
nginx -s reload

# nginx logs
tail -f /var/log/nginx/*.log
