# Firebase Configuration Guide

This guide provides step-by-step instructions to configure Firebase for the PlantPal application.

## Prerequisites

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Enable Firebase Authentication with Email/Password provider
3. Create a Cloud Firestore database

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click "Add project" or select existing project
3. Enter project name: `PlantPal` (or your preferred name)
4. Follow the setup wizard to complete project creation

## Step 2: Enable Authentication

1. In Firebase Console, go to **Authentication**
2. Click **Get Started**
3. Go to **Sign-in method** tab
4. Enable **Email/Password** provider
5. Click **Save**

## Step 3: Create Firestore Database

1. In Firebase Console, go to **Firestore Database**
2. Click **Create database**
3. Choose **Start in test mode** for development (we'll add security rules later)
4. Select a Cloud Firestore location closest to your users
5. Click **Enable**

## Step 4: Android Configuration

### 4.1 Register Android App

1. In Firebase Console, click the Android icon to add Android app
2. Enter Android package name: `com.plantpal.plantpal`
3. Enter app nickname (optional): `PlantPal Android`
4. Leave Debug signing certificate SHA-1 blank for now (optional for development)
5. Click **Register app**

### 4.2 Download google-services.json

1. Download the `google-services.json` file
2. Place it in: `android/app/google-services.json`
3. **IMPORTANT**: This file is gitignored for security reasons
4. Share this file securely with your team members (not via public repository)

### 4.3 Update Android Build Configuration

Add the following to `android/build.gradle.kts` (if not already present):

```kotlin
dependencies {
    classpath("com.google.gms:google-services:4.4.0")
}
```

Add to `android/app/build.gradle.kts` at the bottom:

```kotlin
apply(plugin = "com.google.gms.google-services")
```

## Step 5: iOS Configuration

### 5.1 Register iOS App

1. In Firebase Console, click the iOS icon to add iOS app
2. Enter iOS bundle ID: `com.plantpal.plantpal`
3. Enter app nickname (optional): `PlantPal iOS`
4. Leave App Store ID blank for now
5. Click **Register app**

### 5.2 Download GoogleService-Info.plist

1. Download the `GoogleService-Info.plist` file
2. Place it in: `ios/Runner/GoogleService-Info.plist`
3. **IMPORTANT**: This file is gitignored for security reasons
4. Share this file securely with your team members

### 5.3 Update iOS Project

1. Open `ios/Runner.xcworkspace` in Xcode
2. Drag `GoogleService-Info.plist` into the Runner folder in Xcode
3. Ensure "Copy items if needed" is checked
4. Click **Finish**

## Step 6: Firestore Security Rules

Apply these security rules in Firebase Console > Firestore Database > Rules:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Users collection - users can only read/write their own document
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    // Plants collection - read-only for authenticated users
    match /plants/{plantId} {
      allow read: if request.auth != null;
      allow write: if false; // Only admins can write (to be handled separately)
    }
  }
}
```

Click **Publish** to activate the rules.

## Step 7: Seed Plant Data (Optional)

To populate the Firestore database with sample plant data:

1. Go to Firestore Database in Firebase Console
2. Start a new collection: `plants`
3. Add sample documents with the following structure:

```json
{
  "name": "Snake Plant",
  "scientificName": "Sansevieria trifasciata",
  "description": "A hardy succulent that's perfect for beginners",
  "wateringFrequency": "Every 2-3 weeks",
  "sunlightNeeds": "Low to bright indirect light",
  "maintenanceTips": "Water sparingly, avoid overwatering. Thrives on neglect.",
  "imageUrl": "",
  "category": "Indoor"
}
```

Sample plants to add:
- Snake Plant
- Pothos
- Spider Plant
- Aloe Vera
- Peace Lily

## Step 8: Verification

Run the following commands to verify Firebase setup:

```bash
flutter pub get
flutter run
```

### Expected Output:
- No Firebase initialization errors in console
- App launches successfully
- Check logs for: "Firebase initialized successfully" or similar message

### Troubleshooting:

**Issue**: Firebase initialization fails
- **Solution**: Verify `google-services.json` and `GoogleService-Info.plist` are in correct locations

**Issue**: Authentication not working
- **Solution**: Ensure Email/Password provider is enabled in Firebase Console

**Issue**: Firestore permission denied
- **Solution**: Check security rules are properly configured

## Environment Configuration (Production)

For production deployment:

1. Switch Firestore to **production mode** with strict security rules
2. Set up Firebase App Check for additional security
3. Configure environment-specific Firebase projects (dev, staging, prod)
4. Never commit `google-services.json` or `GoogleService-Info.plist` to version control

## Team Sharing

**How to share Firebase config files with team:**
1. Use secure file sharing (Google Drive, team-specific encrypted storage)
2. Never push config files to public repositories
3. Each team member must place files in correct local directories

## Support

For Firebase-related issues:
- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev)
- [Firebase Support](https://firebase.google.com/support)

---

**Last Updated**: January 2026
**Maintained By**: Jaswant (Firebase & Backend Lead)
