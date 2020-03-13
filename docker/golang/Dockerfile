FROM golang:1.13.7-buster

WORKDIR /go/src/14web_service

ENV GO111MODULE=on

COPY /14web_service/go.mod /14web_service/go.sum ./

RUN apt-get update -qq && \
    apt-get install -y git && \
    go mod download

EXPOSE 8080
CMD [ "build/14web_service" ]