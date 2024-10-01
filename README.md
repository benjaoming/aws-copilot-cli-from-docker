# aws-copilot-cli-from-docker
An experiment to run AWS copilot from within a Docker container

## Using it

Clone this repo, then:

```
# Build the docker image
docker build -t copilot:latest .

# Add the following line to your shell environment.
# For instance for bash:
echo "alias copilot='docker run --rm -ti -v ~/.aws:/root/.aws -v \$(pwd):/aws copilot:latest'" >> ~/.bashrc

# Restart your shell
# Then try out the command:
copilot
```

## Another approach

Found this, it seems like AWS team likes some Fedora/Redhat thing, so it's much easier to build:

```
FROM amazon/aws-cli:2.11.2

RUN curl -Lo copilot https://github.com/aws/copilot-cli/releases/download/v1.26.0/copilot-linux && chmod +x copilot && mv copilot /usr/local/bin/copilot
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm" && yum install -y session-manager-plugin.rpm

ENTRYPOINT ["/usr/local/bin/copilot"]
```
