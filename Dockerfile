# Install the app dependencies in a full Node docker image
FROM registry.access.redhat.com/ubi8/nodejs-16:latest AS build

ENV NODE_ENV production

# Copy package.json, and optionally package-lock.json if it exists
COPY --chown=1001:0 package.json package-lock.json* ./

# Install app dependencies
RUN \
  if [ -f package-lock.json ]; then npm ci; \
  else npm install; \
  fi

COPY --chown=1001:0 . .

RUN npm run build

FROM --platform=linux/amd64 registry.access.redhat.com/ubi8/nginx-120
# COPY --chown=1001:1001 nginx.conf /etc/nginx/nginx.conf
COPY --chown=1001:0 nginx.conf "${NGINX_CONF_PATH}"
# COPY --from=build /usr/src/app/dist/ng-poi-map /usr/share/nginx/html
COPY --chown=1001:0 --from=build /opt/app-root/src/build .

EXPOSE 8080

CMD ["/bin/sh",  "-c", "exec nginx -g 'daemon off;'"]
