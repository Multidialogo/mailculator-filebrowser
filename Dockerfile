# Stage 1: Builder
FROM filebrowser/filebrowser AS mailculatorf-builder

COPY .env.test etc/filebrowser/.test
COPY filebrowser.service /etc/systemd/system/filebrowser.service

# Stage 2: Development
FROM filebrowser/filebrowser AS mailculatorf-dev

COPY .env.dev etc/filebrowser/.env
COPY filebrowser.service /etc/systemd/system/filebrowser.service

EXPOSE 80

# Stage 3: Production
FROM filebrowser/filebrowser AS mailculatorf-prod

COPY .env.prod etc/filebrowser/.env
COPY filebrowser.service /etc/systemd/system/filebrowser.service

EXPOSE 80
