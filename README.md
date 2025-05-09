# Islamic Prayer App

## Overview
Islamic Prayer App is a mobile application designed to assist Muslims in their daily religious practices. It provides accurate prayer times based on the user's location, displays both Hijri and Gregorian calendars, and includes a collection of daily Islamic supplications (Adhkar). The app also offers features like Qibla direction, audio playback for Adhkar, and offline support.

## Features
- **Prayer Times**: Fetches accurate prayer times based on the user's location.
- **Hijri & Gregorian Calendar**: Displays Islamic (Hijri) and Gregorian calendar dates.
- **Daily Adhkar**: Morning and evening supplications with audio playback and reminders.
- **Qibla Direction**: Compass to locate the Qibla using device sensors.
- **User-Friendly Interface**: Clean and intuitive design for seamless navigation.
- **Offline Support**: Access Adhkar and prayer times without an internet connection.

## Demo Video
Watch the demo video [here](https://drive.google.com/file/d/12aw6j0B8-cGRLTYF7th02EYZW5id99E7/preview).

## Presentation and Documentation
- View the project presentation [here](https://github.com/eslamabdelazem/islamy/raw/main/docs/presentation.pdf).
- View the project documentation [here](https://github.com/eslamabdelazem/islamy/raw/main/docs/documentation.pdf).

## System Requirements
- **Hardware**:
  - Android device (version 6.0 or higher).
  - Minimum 2GB RAM and 100MB free storage.
- **Software**:
  - Flutter SDK (version 3.27.1).
  - Dart (version 2.18 or higher).
  - Android Studio for development.
  - Git for version control.

## Technologies Used
- **Language**: Dart
- **Framework**: Flutter
- **APIs**: Aladhan API for prayer times and Hijri calendar
- **Database**: ObjectBox for local storage
- **Key Packages**: See the [Dependencies](#dependencies) section for a full list of packages used, including `adhan`, `google_maps_flutter`, and `just_audio`.
- **Other Tools**: Git, Android Studio

## Dependencies
The app relies on the following Flutter packages:
- **jhijri: ^1.0.0**: Converts Gregorian dates to Hijri dates for calendar functionality.
- **jhijri_picker: ^1.0.1**: Provides a Hijri date picker for selecting Islamic dates.
- **workmanager: ^0.5.2**: Schedules background tasks, such as prayer time notifications.
- **adhan: ^2.0.0+1**: Calculates prayer times based on location and Islamic calculation methods.
- **audio_service: ^0.18.18**: Manages background audio playback for Adhkar.
- **just_audio: ^0.10.0**: Plays audio files for supplications and reminders.
- **flutter_qiblah: ^3.1.0+1**: Provides Qibla direction using device sensors.
- **smooth_compass_plus: ^0.0.4**: Enhances compass functionality for accurate Qibla direction.
- **vector_math: ^2.1.0**: Supports mathematical calculations for compass and location features.
- **objectbox:Kids: ^4.1.0**: Lightweight database for storing Adhkar and user preferences locally.
- **flutter_launcher_icons: ^0.14.3**: Generates custom app icons for Android.
- **provider: ^6.1.2**: State management for handling app data and UI updates.
- **geocoding: ^3.0.0**: Converts coordinates to readable addresses for location-based features.
- **geolocator: ^13.0.2**: Retrieves the user's location for prayer times and Qibla.
- **google_maps_flutter: ^2.10.0**: Displays maps for mosque locations or other location-based features.
- **flutter_offline: ^3.0.1**: Detects internet connectivity for offline mode.
- **dio: ^5.8.0+1**: Handles HTTP requests to fetch data from APIs like Aladhan.
- **flutter_advanced_switch: ^3.1.0**: Custom switch UI for toggling settings like notifications.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/eslamabdelazem/islamy.git
   ```
2. Navigate to the project directory:
   ```bash
   cd islamy
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```

## Execution Guide
### Running Locally
1. Connect an Android device or start an emulator.
2. Run the app:
   ```bash
   flutter run
   ```
3. Grant location permissions when prompted to ensure accurate prayer times and Qibla direction.

## API Documentation
The app uses the [Aladhan API](http://api.aladhan.com/) to fetch prayer times and Hijri calendar data. Key endpoints include:
- **Prayer Times**: `GET /v1/timingsByCity` - Retrieves prayer times for a specific city.
- **Hijri Calendar**: `GET /v1/gToH` - Converts Gregorian dates to Hijri.
For detailed documentation, visit [Aladhan API Docs](http://api.aladhan.com/).


## Project Structure
- `/lib`: Main source code (Dart files).
- `/assets`: Images, fonts, and static resources.
- `/test`: Test cases for the app.
- `pubspec.yaml`: Flutter dependencies and configurations.

## Contributing
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m "Add new feature"`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a Pull Request.

## Contact
For questions or feedback, reach out to:
- Email: eslamabdelazzeem@gmail.com
- GitHub Issues: [Create an issue](https://github.com/eslamabdelazem/islamy/issues)
