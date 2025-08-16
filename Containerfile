FROM golang:alpine AS build
ARG VERSION=main

RUN set -x \
  \
  && apk add --no-cache \
    git \
    make \
  \
  && git clone --depth 1 -b $VERSION https://github.com/cgwalters/kvm-device-plugin.git \
  && cd kvm-device-plugin \
  && make build

FROM alpine:latest

COPY --from=build /go/kvm-device-plugin/cmd/kvm/kvm /usr/bin/device-plugin-kvm
CMD ["/usr/bin/device-plugin-kvm"]