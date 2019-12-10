# zowe_flutter

A basic Flutter app that connects to z/OS via Zowe and z/OSMF.

## Getting Started

### What is Zowe and how can I have access to z/OS?
More about Zowe: https://www.zowe.org/
To get access to Zowe: https://www.ibm.com/account/reg/us-en/signup?formid=urx-38870

### API Settings
API endpoints are currently set for Zowe trial machines. However, in case of any endpoint difference, don't forget to set API endpoints on `lib/env.dart` file.

### Installing Flutter
Flutter is a Dart framework that allows you to create apps on Android/iOS/Desktop with a single codebase.
See here about how to install Flutter on your machine: https://flutter.dev/docs/get-started/install

## Running the App
1. Open a terminal and run `git clone https://github.com/mehmetalpsumer/zowe-flutter.git`
2. Run `cd zowe-flutter` to move into the project directory.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run` to get the app going. (Don't forget to connect your mobile device and enable debugging on it. Or use a iOS/Android emulator.)

## Features
- Login to z/OS.
- Filter data sets.
- (TODO) Create/update/delete data sets.
- (TODO) Access to JES.