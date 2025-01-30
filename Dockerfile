# Stage 1: Builder
FROM filebrowser/filebrowser AS mailculatorf-builder

COPY .filebrowser.json.test /.filebrowser.json
COPY filebrowser.db.test /filebrowser.db

# Stage 2: Development
FROM filebrowser/filebrowser AS mailculatorf-dev

COPY .filebrowser.json.dev /.filebrowser.json
COPY filebrowser.db.dev /filebrowser.db

EXPOSE 80

# Stage 3: Production
FROM filebrowser/filebrowser AS mailculatorf-prod

COPY .filebrowser.json.prod /.filebrowser.json
COPY filebrowser.db.prod /filebrowser.db

EXPOSE 80
