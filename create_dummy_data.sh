#!/bin/bash

BASE_URL="http://localhost:8080/api/users"
ADMIN_USERNAME="admin"
ADMIN_PASSWORD="admin"
ADMIN_BEARER_TOKEN="TODO"

curl -i -X POST "http://localhost:8080/api/auth/login" \
    -H "Content-Type: application/json" \
    -d '{
        "username": "${ADMIN_USERNAME}",
        "password": "${ADMIN_PASSWORD}",
    }'

# Loop to create 20 users
for i in {1..20}; do
    USERNAME="user$i"
    PASSWORD="password$i"

    # Create user via the API using basic authentication
    curl -i -X POST "$BASE_URL" \
        -H "Authorization: Bearer ${ADMIN_BEARER_TOKEN}" \
        -H "Content-Type: application/json" \
        -d '{
            "username": "'"$USERNAME"'",
            "password": "'"$PASSWORD"'",
            "dir": [
                "./users/'"$i"'/sent",
                "./users/'"$i"'/outbox",
                "./users/'"$i"'/failure"
            ]
        }'
done
