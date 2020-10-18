FROM openresty/openresty:1.17.8.2-5-alpine

EXPOSE 8080/tcp
EXPOSE 8081/tcp

COPY access-restrictor/lua/ /lua
RUN \
  mkdir -p /config && \
  echo "{}" > /config/rate_limited_uris.json && \
  mkdir -p /state && \
  echo "{}" > /state/last_access.json
COPY access-restrictor/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

RUN chmod 777 -R /state /config

# self check configuration
RUN \
  cp /usr/local/openresty/nginx/conf/nginx.conf /usr/local/openresty/nginx/conf/nginx.orig  && \
  sed s/target/localhost/ -i /usr/local/openresty/nginx/conf/nginx.conf && \
  nginx -t && \
  mv /usr/local/openresty/nginx/conf/nginx.orig /usr/local/openresty/nginx/conf/nginx.conf
