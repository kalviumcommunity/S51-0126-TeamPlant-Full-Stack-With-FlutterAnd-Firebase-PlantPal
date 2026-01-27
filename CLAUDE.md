# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**PlantPal** is a mobile plant care companion app built with Flutter and Firebase. It helps home gardeners and plant buyers access plant-specific care instructions, watering schedules, and maintenance tips provided by local plant nurseries.

**Target Users**: Home gardeners and customers of local plant nurseries who need easy access to plant care guidance on their smartphones.

## Tech Stack

- **Frontend**: Flutter (Dart SDK ^3.10.7)
- **Backend**: Firebase Authentication, Cloud Firestore
- **Linting**: flutter_lints package (activated in analysis_options.yaml)

## Common Development Commands

```bash
# Install dependencies
flutter pub get

# Run app in debug mode
flutter run

# Run on specific device (list devices with: flutter devices)
flutter run -d <device-id>

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Run static analysis / linter
flutter analyze

# Build release APK for Android
flutter build apk --release

# Check Flutter environment setup
flutter doctor

# Clean build artifacts (useful when having build issues)
flutter clean

# Check for outdated packages
flutter pub outdated

# Hot reload: Press 'r' in terminal while app is running
# Hot restart: Press 'R' in terminal while app is running
```

## High-Level Architecture

### Planned Application Structure

The app follows a standard Flutter architecture with three main layers:

**1. UI Layer** (`lib/screens/` or `lib/ui/`)
- Splash screen
- Authentication screens (Login, Sign Up)
- Home screen (plant list view)
- Plant detail screen (care instructions, watering schedule, maintenance tips)
- User profile screen

**2. Business Logic Layer** (`lib/services/` or `lib/providers/`)
- Authentication service (Firebase Auth wrapper)
- Firestore service (database operations)
- State management (approach TBD - Provider, Riverpod, or Bloc)

**3. Data Layer** (`lib/models/`)
- User model
- Plant model (care instructions, watering frequency, sunlight requirements)
- Data transfer objects for Firebase

### Firebase Integration Pattern

**Firebase packages to be added to `pubspec.yaml`:**
```yaml
dependencies:
  firebase_core: latest
  firebase_auth: latest
  cloud_firestore: latest
```

**Configuration files (not in version control):**
- Android: `android/app/google-services.json`
- iOS: `ios/Runner/GoogleService-Info.plist`

**Firebase initialization:**
Must call `Firebase.initializeApp()` in `main()` before `runApp()`.

### Navigation Flow
```
Splash → Authentication Check → Login/Sign Up → Home (Plant List) → Plant Detail
                                      ↓
                                User Profile
```

### Firestore Data Structure (Planned)
- **Collection**: `plants`
  - Fields: name, description, wateringFrequency, sunlightNeeds, maintenanceTips, imageUrl
- **Collection**: `users`
  - Fields: email, displayName, createdAt

## Project-Specific Context

### Current Development State
- **Branch**: `feature/flutter-project-setup`
- **Status**: Initial Flutter project scaffolding complete; Firebase integration pending
- **Main entry**: `lib/main.dart` (currently has default Flutter counter app - to be replaced)

### Team Structure & Responsibilities
- **Flutter UI & App Flow Lead (Monesh)**: Implements UI screens, navigation, state management
- **Firebase & Backend Lead (Jaswant)**: Sets up Firebase Authentication, Firestore database design, security rules
- **Testing & Deployment Lead (Kirtik)**: Manual testing, bug fixes, APK generation, documentation

### MVP Scope (In Scope)
- Firebase Authentication (email/password only)
- Cloud Firestore integration for plant data
- View plant list and care instructions
- User profile management
- Responsive UI across screen sizes

### Out of Scope for MVP
- Push notifications and reminders
- E-commerce features
- Admin dashboard for nurseries
- AI-based plant diagnosis
- Multi-language support
- Social features (sharing, favorites)

### Firebase Security Rules
Must implement proper Firestore security rules:
- Authenticated users can read all plants
- Only authenticated users can read/write their own user document
- Plant data is read-only for regular users (write access reserved for admin)

### Testing Strategy
- Widget tests for core UI components (`test/` directory)
- Manual testing for authentication flows
- Firestore read/write operations testing
- UI navigation and responsiveness testing across devices

### Build & Deployment
- Target platform: Android (primary), iOS (secondary)
- Release builds via `flutter build apk --release`
- APK distribution via Google Drive for evaluation and demo purposes

## Additional Documentation

Comprehensive project documentation (sprint timeline, requirements, setup instructions) is available on the `docs/update-readme-sprint2` branch in the README.md file.
