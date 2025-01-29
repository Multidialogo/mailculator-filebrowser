You can achieve this with **Filebrowser** by configuring per-user permissions and mounting specific directories. Here’s how you can set it up for your multi-user environment:

---

## **1. Install Filebrowser**
```sh
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
```
or using Docker:
```sh
docker run -d -p 8080:80 -v /your/data:/srv filebrowser/filebrowser
```

---

## **2. Setup Multi-User Access**
Since you have a directory structure like:
```
/outbox/user/{user-id}/...
/sent/user/{user-id}/...
/failure/user/{user-id}/...
```
Each user should only access their own `{user-id}` directory.

1. **Start Filebrowser UI**  
   Open [http://localhost:8080](http://localhost:8080) and create users.
   
2. **Configure Home Directories Per User**  
   - Go to **Users** > **Edit User**
   - Set **Scope** to `/outbox/user/{user-id}`
   - Add additional scopes (`/sent/user/{user-id}` and `/failure/user/{user-id}`)
   - Set **Permissions**:  
     - Enable `list` and `download`  
     - Disable `delete`, `rename`, `modify` (if needed)

---

## **3. Use API for Listing & Downloading**
### **List Files (Recursively)**
```
GET /api/resources/?path=/outbox/user/{user-id}
Authorization: Bearer <token>
```

### **Download File**
```
GET /api/raw/{file-path}
Authorization: Bearer <token>
```

---

## **4. Automate User Creation (Optional)**
You can create users via API:
```sh
curl -X POST "http://localhost:8080/api/users" \
     -H "Authorization: Bearer <admin-token>" \
     -H "Content-Type: application/json" \
     -d '{
         "username": "user123",
         "password": "securepass",
         "scope": ["/outbox/user/user123", "/sent/user/user123", "/failure/user/user123"],
         "permissions": {"download": true, "list": true}
     }'
```

---

## **5. Run as a Service (Systemd)**
```sh
sudo nano /etc/systemd/system/filebrowser.service
```
```ini
[Unit]
Description=File Browser
After=network.target

[Service]
ExecStart=/usr/local/bin/filebrowser -r /outbox
Restart=always
User=root

[Install]
WantedBy=multi-user.target
```
```sh
sudo systemctl enable filebrowser
sudo systemctl start filebrowser
```

---

Now each user can:
✅ List files in `/outbox/user/{user-id}`  
✅ List files in `/sent/user/{user-id}`  
✅ List files in `/failure/user/{user-id}`  
✅ Download their files  
❌ Cannot see files of other users  

Would you like to add JWT auth or any extra feature? 🚀
