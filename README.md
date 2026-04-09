# Tasks App

Flutter task management application with authentication, personal task list, search/filtering, and full task CRUD using a mock REST API.

## Overview

This app lets a user:

- Log in using email/password.
- Load only tasks assigned to the logged-in user.
- Search tasks by title or description.
- Filter tasks by status and priority.
- Add, edit, view details, and delete tasks.

The project uses `flutter_bloc` (Cubit pattern), `http` for API calls, and `shared_preferences` for local user session storage.

## Features

### Authentication

- Login form with validation.
- JWT-like access token is saved locally after successful login.
- App startup checks token existence and routes directly to home if already logged in.

### Home Screen

- Loads tasks for the current user.
- Displays task cards with title, description, status, due date, and priority.
- Real-time search over loaded tasks.
- Chip-based filtering:
    - Status: `All`, `Todo`, `In Progress`, `Done`
    - Priority: `All`, `Low`, `Medium`, `High`

### Task Management

- **Add Task** with:
    - Title
    - Description
    - Status
    - Priority
    - Due date
- **Edit Task** from task details screen.
- **Delete Task** from task details screen.
- Success and failure feedback using SnackBars and state-driven UI.

### Local Persistence

Stored using `shared_preferences`:

- Access token
- User id
- User name
- User email

## Tech Stack

- Flutter / Dart (`sdk: ^3.10.1`)
- `flutter_bloc`
- `http`
- `shared_preferences`

## Project Structure

Main directories:

- `lib/ui/` - screens, widgets, and feature Cubits
- `lib/apis/` - API constants, endpoints, and HTTP manager
- `lib/models/` - request/response models
- `lib/services/` - shared preferences wrapper
- `lib/utiles/` - routes, colors, fonts, constants, bloc observer
- `mock-api/` - local mock backend using `json-server`

## API Configuration

The app uses a base URL defined in `lib/apis/api_constants.dart`:

- `http://localhost:3000`

### Important

For the full mock API setup, routes, test users, endpoint table, and emulator connectivity instructions, check:

- `mock-api/Readme.md`

That file is the source of truth for backend setup and API behavior.

## Getting Started

### Prerequisites

- Flutter SDK installed
- A device/emulator (Android Studio emulator or physical device)
- Mock API server running (see `mock-api/Readme.md`)

### Install dependencies

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```

## Run on Your Device

Use these steps to run the app on a real Android device.

1. **Enable Developer Options and USB Debugging**
    - On your phone: Settings -> About phone -> tap Build number 7 times.
    - Open Developer options and enable USB debugging.

2. **Connect your phone**
    - Connect via USB.
    - Accept the RSA debugging prompt on the device.

3. **Verify Flutter can see the device**
```bash
   flutter devices
```
Confirm your device appears in the list.

4. **Start the mock API**
    - Follow `mock-api/Readme.md` and make sure the API server is running.

5. **Set correct API base URL for physical device**
    - `localhost` will not work on a real phone.
    - In `lib/apis/api_constants.dart`, set `baseUrl` to your computer's local network IP, for example:
```dart
   static const String baseUrl = "http://192.168.1.10:3000";
```
- Ensure both phone and computer are on the same Wi-Fi network.

6. **Run the app on the connected device**
```bash
   flutter run
```

7. **(Optional) Select a specific device**
```bash
   flutter run -d <device_id>
```

## Main App Flow

1. App starts and checks saved token.
2. If token exists -> open Home screen.
3. Otherwise -> open Login screen.
4. User logs in -> token/user data saved.
5. Home loads tasks assigned to that user.
6. User can search, filter, add, edit, and delete tasks.

## Screenshots & Demo

[View Screenshots and Video Demo on Google Drive](https://drive.google.com/drive/folders/1j78OvYOBnLHwWnMDxzQHmo5zAhuFRwfW?usp=sharing)