FROM klakegg/hugo:0.82.0-alpine

COPY . /src
WORKDIR /src

EXPOSE 1313

CMD ["server"]