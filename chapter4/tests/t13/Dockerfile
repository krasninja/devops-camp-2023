# -----------------------------------------------
# The image contains Flatris web game:
# https://github.com/udaltsovra/flatris
#
# You can build it like this:
# docker build -t krasninja/devops-camp:0.1.0 --rm --force-rm --build-arg .
# -----------------------------------------------

ARG VERSION=16-alpine
FROM --platform=$BUILDPLATFORM node:$VERSION

# Get the app from the Github.
WORKDIR /build
RUN apk update && \
  apk --no-cache add curl unzip && \
  curl -o flatris.zip -L https://github.com/krasninja/flatris/archive/refs/heads/main.zip && \
  unzip flatris.zip

# Build it.
WORKDIR /build/flatris-main
RUN yarn install && \
  yarn build

# Run.
EXPOSE 3000
ENTRYPOINT ["yarn", "start"]
