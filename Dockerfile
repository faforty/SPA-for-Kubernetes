FROM node:9.6.1 as builder
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH
COPY package*.json ./
RUN npm install --silent
COPY . /usr/src/app
RUN npm run build
 
FROM nginx:1.14.1-alpine
RUN apk add --no-cache jq
RUN rm -rf /etc/nginx/conf.d
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
COPY docker-entrypoint.sh generate_config_js.sh /
RUN chmod +x docker-entrypoint.sh generate_config_js.sh
 
CMD ["/docker-entrypoint.sh"]
# ENTRYPOINT ["/docker-entrypoint.sh"]