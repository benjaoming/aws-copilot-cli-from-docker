FROM public.ecr.aws/docker/library/golang:1.17 AS sm-build

RUN apt -y update && apt -y upgrade && apt -y install rpm tar gzip wget zip git && apt clean all

RUN mkdir /session-manager-plugin
WORKDIR /session-manager-plugin

RUN git clone --depth 1 https://github.com/aws/session-manager-plugin.git . -b mainline

RUN make release

RUN find

FROM alpine:3.14
# bash: so we can enter the container and debug
# curl: to fetch during build
# sudo: because session-manager plugin for copilot needs it
RUN apk add --no-cache bash curl sudo
RUN curl -Lo copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-linux && chmod +x copilot && mv copilot /usr/local/bin/copilot

COPY --from=sm-build /session-manager-plugin/bin/debian_386/debian/usr/local/sessionmanagerplugin/bin/session-manager-plugin /usr/local/bin/session-manager-plugin

RUN mkdir /aws
WORKDIR /aws

ENTRYPOINT ["/usr/local/bin/copilot"]
