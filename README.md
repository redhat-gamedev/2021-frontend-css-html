# Shipwars Client

React application served using NGINX. Connects to the Shipwars WebSocket server.

## Requirements

- Node.js v14.3
- Yarn v1.x
- Source-to-Image v1.1.13 or newer

## Build, Run, and Push

Use the included script to invoke Source-to-Image:

```bash
# Optional environment variables that can be passed to the build
export QUAY_USER=yourusername
export IMAGE_TAG=latest
export IMAGE_REPOSITORY=quay.io/$QUAY_USER/shipwars-client

# Builds the image as quay.io/$QUAY_USER/shipwars-client:latest
./scripts/build.sh
```

Run the image using the following command. You can visit http://localhost:8484
to play the game, if you have the game server running on http://localhost:8181.

```bash
docker run --rm -p 8484:8484 quay.io/$QUAY_USER/shipwars-client:latest
```

Push to quay.io using this command:

```bash
docker push quay.io/$QUAY_USER/shipwars-client:latest
```