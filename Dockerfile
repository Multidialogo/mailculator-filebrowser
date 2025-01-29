# Stage 1: Builder
FROM filebrowser/filebrowser AS mailculatorf-builder

# COPY .filebrowser.json.test /.filebrowser.json

# Stage 2: Development
FROM filebrowser/filebrowser AS mailculatorf-dev

COPY .filebrowser.json.dev /.filebrowser.json

EXPOSE 80

# Stage 3: Production
FROM filebrowser/filebrowser AS mailculatorf-prod

COPY .filebrowser.json.prod /.filebrowser.json

EXPOSE 80
