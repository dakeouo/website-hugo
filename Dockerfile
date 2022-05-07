FROM klakegg/hugo:0.82.0-alpine

COPY . /src
RUN apk add --no-cache git && git submodule init && git submodule update

WORKDIR /src
EXPOSE 1313

CMD ["server"]