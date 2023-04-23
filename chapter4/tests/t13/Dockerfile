FROM --platform=$BUILDPLATFORM node:16-alpine

# Get the app from the Github.
WORKDIR /build
RUN apk update && \
  apk --no-cache add curl unzip && \
  curl -o flatris.zip -L https://github.com/udaltsovra/flatris/archive/refs/heads/main.zip && \
  unzip flatris.zip

# Build it.
WORKDIR /build/flatris-main
RUN yarn install && \
  yarn build

# Run,
EXPOSE 3000
ENTRYPOINT ["yarn", "start"]
