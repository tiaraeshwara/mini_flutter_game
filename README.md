# Mini Flutter Game
This project is a mini flutter game that serves as an example of integrating Flutter with various technologies.

## Architecture
The architecture follows a Model-View-ViewModel (MVVM) pattern which helps in separating the user interface from the business logic.

## Prerequisites
Before running the project, ensure you have the following:
- Flutter SDK installed
- Dart SDK installed
- An IDE of your choice (e.g., VSCode, Android Studio)

## Project Structure
```
- lib/
  - main.dart
  - models/
  - views/
  - viewmodels/
- assets/
- test/
```

## Getting Started
To get started with the project, clone the repository and run:
```bash
flutter pub get
flutter run
```

## Configuration
Ensure your environment variable is set up for:
- Dart SDK
- Flutter SDK

## API Endpoints
- **GET /api/games** - Retrieve the list of games
- **POST /api/games** - Add a new game

## Database Schema
- **games** table
  - `id`: Integer, Primary Key
  - `name`: String
  - `description`: String

## Technologies Used
- Flutter
- Dart
- Firebase

## Building & Running
To build the application for production, use:
```bash
flutter build apk
```
To run the application on an emulator, use:
```bash
flutter emulators --launch <emulator_id>
```

## Notes & Improvements
- Consider adding more complex game logic.
- Improve UI design for better user experience.
