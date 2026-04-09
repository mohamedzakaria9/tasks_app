# Mock API Server

A mock REST API server built with **json-server** and **json-server-auth** to simulate a real backend with JWT authentication and task management for the Flutter Tasks App.

---

## 📁 Project Files

| File | Description |
|------|-------------|
| `db.json` | The database — contains users and tasks |
| `routes.json` | Route rules for task access protection |
| `package.json` | Project configuration and start script |
| `package-lock.json` | Locked dependency versions |

---

## ⚙️ Prerequisites

- [Node.js](https://nodejs.org/) installed on your machine

---

## 🚀 Installation & Running

**1. Install dependencies:**
```bash
npm install
```

**2. Start the server:**
```bash
npm start
```

**3. You should see this output:**
```
\{^_^}/ hi!

Loading db.json
Loading routes.json
Loading node_modules/json-server-auth
Done

Resources
http://localhost:3000/users
http://localhost:3000/tasks

Other routes
/tasks* -> 600/tasks$1
```

The server runs on **http://localhost:3000**

---

## 👥 Test Users

| Name | Email | Password |
|------|-------|----------|
| John Doe | test@example.com | 123456 |
| Alice | alice@example.com | (registered via API) |
| Mohamed | mohamed@gmail.com | (registered via API) |
| Ahmed | ahmed@gmail.com | (registered via API) |
| Khaled | khaled@gmail.com | (registered via API) |

---

## 📡 API Endpoints

### Authentication
| Method | Endpoint | Auth | Body |
|--------|----------|------|------|
| POST | `/register` | No | `{ "email", "password", "name" }` |
| POST | `/login` | No | `{ "email", "password" }` |

### Tasks
| Method | Endpoint | Auth | Body |
|--------|----------|------|------|
| GET | `/tasks` | Yes | — |
| GET | `/tasks?assignedTo={userId}` | Yes | — |
| GET | `/tasks/{id}` | Yes | — |
| POST | `/tasks` | Yes | Task fields |
| PUT | `/tasks/{id}` | Yes | Task fields |
| DELETE | `/tasks/{id}` | Yes | — |

**All protected endpoints require a Bearer token:**
```
Authorization: Bearer <accessToken>
```

The token is returned from `/login` and expires after **1 hour**.

---

## 📋 Task Fields

| Field | Type | Values |
|-------|------|--------|
| title | String | Any text |
| description | String | Any text |
| status | String | `Todo`, `In Progress`, `Done` |
| priority | String | `Low`, `Medium`, `High` |
| dueDate | String | `YYYY-MM-DD` |
| assignedTo | Number | User ID |
| userId | Number | Same as assignedTo (required by auth) |

---

## 📱 Connecting to Flutter (Android Emulator)

> The server uses `--host 0.0.0.0` to listen on all network interfaces — this is required for the Android emulator to reach it.

**Every time you start the emulator, run this command to forward the port:**

```bash
adb reverse tcp:3000 tcp:3000
```

If `adb` is not recognized, use the full path:
```bash
C:\Users\<your-username>\AppData\Local\Android\Sdk\platform-tools\adb.exe reverse tcp:3000 tcp:3000
```

Then set the base URL in your Flutter app to:
```dart
static const String baseUrl = "http://localhost:3000";
```

---

## 🔥 Troubleshooting — Windows Firewall Blocking Port 3000

If the emulator cannot reach the server, Windows Firewall may be blocking port 3000.

**Fix — Add a permanent firewall rule (run as Administrator):**
```bash
netsh advfirewall firewall add rule name="JSON Server Port 3000" dir=in action=allow protocol=TCP localport=3000 profile=any
```

**Verify the server is listening on all interfaces:**
```bash
netstat -an | findstr 3000
```

You should see:
```
TCP    0.0.0.0:3000    0.0.0.0:0    LISTENING
```

If you see `[::1]:3000` instead, the server is only listening on IPv6. Make sure your `package.json` start script includes `--host 0.0.0.0`.

**If adb reverse resets after emulator restart:**

Run this sequence to restart the adb server:
```bash
adb kill-server
adb start-server
adb reverse tcp:3000 tcp:3000
```

---

## ⚠️ Important Notes

- The `node_modules` folder is **not included** — run `npm install` to generate it
- Any changes made via the API (create/update/delete) are **saved automatically** to `db.json`
- Restart the server after changing `routes.json` or `package.json`
- No restart needed when `db.json` changes — the server watches it automatically
