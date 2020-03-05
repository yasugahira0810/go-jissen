FROM golang:1.13.7-buster

WORKDIR /go/src/chitchat

ENV GO111MODULE=on

COPY /chitchat/go.mod /chitchat/go.sum ./

RUN apt-get update -qq && \
    apt-get install -y git && \
    go mod download

EXPOSE 8080
CMD [ "/bin/bash" ]