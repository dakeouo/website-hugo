FROM klakegg/hugo:0.82.0-alpine as build

COPY . /src
RUN apk add --no-cache git 
RUN git submodule init && git submodule update
WORKDIR /src
RUN hugo

FROM nginx:alpine

COPY --from=build /src/public /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
EXPOSE 80