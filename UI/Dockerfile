FROM alpine

ARG UI_VERSION
ENV API_URL http://sensu-lb:8080
ENV NODE_ENV production
ENV PORT 5000

WORKDIR /
RUN apk add --no-cache ca-certificates yarn git
RUN git clone --depth=1 --single-branch --branch v${UI_VERSION} https://github.com/sensu/web.git

WORKDIR /web
RUN yarn install

CMD ["yarn", "node", "scripts", "serve"]