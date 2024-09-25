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
