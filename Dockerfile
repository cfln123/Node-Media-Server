FROM node:20-alpine3.17 AS node

FROM jrottenberg/ffmpeg:6.0-alpine313

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.name="node-media-server" \
      org.label-schema.description="A Node.js implementation of RTMP Server" \
      org.label-schema.usage="https://github.com/illuspas/Node-Media-Server#readme" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="https://github.com/illuspas/Node-Media-Server" \
      org.label-schema.vendor="illuspas" \
      org.label-schema.version="2.5.0" \
      maintainer="https://github.com/illuspas"

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm i

COPY . .

ENTRYPOINT [ "node" ]

CMD [ "bin/app.js" ]