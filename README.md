# Todo App (Full Stack)

A simple full‑stack Todo application with a Node.js/Express + MongoDB backend and a Flutter frontend.

## Features
- User registration and sign‑in.
- CRUD operations for todos.
- MongoDB Atlas data storage.
- Flutter UI for managing todos.

## Tech Stack
- Backend: Node.js, Express, Mongoose, MongoDB Atlas
- Frontend: Flutter, Dart

## Project Structure
- Todo_Backend/ — Express API and MongoDB models
- Todo_Frontend/ — Flutter application

## Prerequisites
- Node.js 18+ and npm
- Flutter SDK
- A MongoDB Atlas connection string

## Backend Setup
1) Install dependencies:
   - `cd Todo_Backend`
   - `npm install`

2) Configure MongoDB connection:
   - Update the connection string in `Todo_Backend/src/config/db.js`.

3) Start the API server:
   - `npm start`

The server listens on `http://0.0.0.0:7000`.

## Frontend Setup
1) Install dependencies:
   - `cd Todo_Frontend`
   - `flutter pub get`

2) Configure API base URL:
   - Update `Todo_Frontend/lib/services/todo_service.dart`.
   - Example: `http://<your-ip>:7000/todo`

3) Run the app:
   - `flutter run`

## API Endpoints
Base URL: `http://<host>:7000`

### Todo
- `GET /todo/get` — Fetch all todos
- `POST /todo/add` — Create a todo
  - Body: `{ "title": "...", "decription": "...", "isPrimary": false, "endDate": "" }`
- `POST /todo/update-one-by-title` — Update a todo by ID
  - Body: `{ "id": "...", "title": "...", "decription": "..." }`
- `DELETE /todo/delete` — Delete a todo by ID
  - Body: `{ "id": "..." }`

### User
- `POST /user/register` — Register user
  - Body: `{ "name": "...", "email": "...", "password": "..." }`
- `POST /user/signup` — Sign in user
  - Body: `{ "email": "...", "password": "..." }`

## Notes
- The field name is spelled `decription` in the backend model and API payloads.
- CORS is enabled on the backend for local development.
