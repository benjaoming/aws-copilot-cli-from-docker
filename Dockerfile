FROM alpine:3.14
RUN apk add --no-cache bash curl
RUN curl -Lo copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-linux && chmod +x copilot && mv copilot /usr/local/bin/copilot

RUN mkdir /aws

WORKDIR /aws

ENTRYPOINT ["/usr/local/bin/copilot"]
