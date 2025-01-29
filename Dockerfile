# Stage 1: Builder
FROM filebrowser/filebrowser AS mailculatorf-builder

# Stage 2: Development
FROM filebrowser/filebrowser AS mailculatorf-dev

EXPOSE 80

# Stage 3: Production
FROM filebrowser/filebrowser AS mailculatorf-prod

EXPOSE 80
