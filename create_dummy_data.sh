#!/bin/bash

rm -rf data/maildir/users/*

AUTH_URL="http://localhost:8080/api/login"
USER_CREATE_URL="http://localhost:8080/api/users"
ADMIN_USERNAME="admin"
ADMIN_PASSWORD="admin"

# Get the Bearer Token
ADMIN_AUTH_TOKEN=$(curl -s -X POST "${AUTH_URL}" \
    -H "Content-Type: application/json" \
    -d "{
        \"username\": \"${ADMIN_USERNAME}\",
        \"password\": \"${ADMIN_PASSWORD}\"
    }")

# Debug: Print token (comment out in production)
echo "Authentication Token: ${ADMIN_AUTH_TOKEN}"

# Check if token retrieval was successful
if [[ -z "${ADMIN_AUTH_TOKEN}" ]]; then
    echo "Failed to retrieve admin token. Exiting..."
    exit 1
fi

# Loop to create 20 users
for i in {1..100}; do
    JSON_PAYLOAD=$(cat <<EOF
{"what":"user","which":[],"data":{"scope":"","locale":"it","viewMode":"mosaic","singleClick":false,"sorting":{"by":"","asc":false},"perm":{"admin":false,"execute":false,"create":false,"rename":false,"modify":false,"delete":false,"share":false,"download":true},"commands":[],"hideDotfiles":false,"dateFormat":false,"username":"user${i}","password":"password${i}","rules":[],"lockPassword":true,"id":0}}
EOF
)

    RESPONSE=$(curl -s -w "%{http_code}" -X POST "${USER_CREATE_URL}" \
        -H "X-Auth: ${ADMIN_AUTH_TOKEN}" \
        -H "Content-Type: application/json" \
        -d "$JSON_PAYLOAD")

    # Get HTTP code and response body
    HTTP_CODE=$(echo "$RESPONSE" | tail -n 1)
    RESPONSE_BODY=$(echo "$RESPONSE" | sed '$d')

    # Log the response body and status code
    echo "Response: $HTTP_CODE"
    echo "Response body: $RESPONSE_BODY"

    if [ "$HTTP_CODE" -ne 201 ]; then
       echo "Failed to create user user${i}. HTTP Response: $HTTP_CODE"
    else
       echo "User user${i} created successfully!"
    fi
done




