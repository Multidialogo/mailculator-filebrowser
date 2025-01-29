
# MultiDialogo - MailCulator filebrowser

## Provisioning

This Dockerfile is designed to build and deploy the `mailculator filebrowser` application using three distinct stages:
1. Builder Stage
2. Development Stage
3. Production Stage

Each stage serves a specific purpose, and you can use them based on your needs.

### Stage 1: Builder

Purpose:
This stage is responsible for building the Go application, running tests, and preparing it for further stages (Development or Production).

Description:
- The base image used is `filebrowser:filebrowser`.

To build the image:
```bash
 docker build --no-cache -t mailculatorf-builder --target=mailculatorf-builder .
 ```

To introspect the builder image:

```bash
docker run -ti --entrypoint /bin/sh mailculatorf-builder
```

### Stage 2: Development

Purpose: This stage is used for local development.

Description:

The base image used is `filebrowser:filebrowser`.
To build the image:
```bash
docker build --no-cache -t mailculatorf-dev --target=mailculatorf-dev .
```

To run the development container:
```bash
docker run --rm -v$(pwd)/data:/srv -p 8080:80 mailculatorf-dev
```

Now you can access the filebrowser interface at: http://localhost:8080 .

### Stage 3: Production

Purpose: This stage is optimized for production deployment. It creates a minimal container to run the mailculator filebrowser binary in a secure and efficient environment.

Description:

The base image used is ???, which is a minimal image without unnecessary tools or packages.
The container is configured to run the mailculator filebrowser binary.
To build the image:
```bash
docker build --no-cache -t mailculatorf-prod --target=mailculatorf-prod .
```

To run the production container:
```bash
docker run --rm mailculatorf-prod
```
