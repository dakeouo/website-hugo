FROM klakegg/hugo:0.82.0-alpine

ARG HUGO_BASE_URL

COPY . /src
RUN apk add --no-cache git 
RUN git submodule init && git submodule update

WORKDIR /src
EXPOSE 1313

ENTRYPOINT hugo serve