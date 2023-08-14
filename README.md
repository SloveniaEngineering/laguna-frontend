# Laguna

### Requirements

- Latest version of Flutter installed - [Download][download]
- Flutter added to your environmental:
    - [Windows instructions][windows-environment]
    - [MacOS instructions][macos-environment]
    - [Linux instructions][linux-environment]
- IDE of choice with Flutter/Dart plugins (Android Studio / IntelliJ, Visual Studio Code).
- Google Chrome browser for web builds
- A connected mobile device (Android or iOS)
    - An appropriate emulator works aswell - [Android][android-emulator-guide]

### Preparation

To build or run the application, we must first prepare the project. We do this by running the
following commands:

  ```sh
  cd laguna-frontend
  flutter clean
  flutter pub get
  dart run build_runner build --delete-conflicting-outputs
  cd ios //required only for iOS/MacOS
  rm -rf Pods/ Podfile.lock //required only for iOS/MacOS
  pod install //required only for iOS/MacOS
  ```

If you want to run backend server locally,
clone [laguna-backend](https://github.com/SloveniaEngineering/laguna-backend) repository and follow
instructions in [CONTRIBUTING.md](https://github.com/SloveniaEngineering/laguna-backend/blob/dev/CONTRIBUTING.md)
file.
To run backend server, `git checkout dev` branch and execute `scripts/dev.sh` script from laguna-backend repository.

### Web App

#### Running the Web app

Because of current CORS issues on backend, you have to run web app
with `--web-browser-flag --disable-web-security`
parameter so that FE can send request to localhost without issues. Never use this flag in
production!

```sh
flutter run -d chrome --web-browser-flag --disable-web-security
flutter run -d chrome --web-browser-flag --disable-web-security --release //Run release build of web app
```

#### Building an Web app

```sh
flutter build web
flutter build web --release //Build web app for production
```

### Building an Android app (Release APK)

```sh
flutter build apk --split-per-abi //Build app with all architectures - Mostly used for test builds
flutter build appbundle //Build appbundle - Needed for Play Store
```

### Building an iOS/MacOS app

For iOS or MacOS, open the project in Xcode and build & archive the project from there.
More information can be found [here][ios-build-guide]
More information about building MacOS app can be found [here][macos-build-guide]

An alternative is to run the following command in project home directory

```sh
flutter build ipa
```

or for MacOS

```sh
flutter build macos
```

And then open the project in Xcode and archive the project from there.
-- Or using an app like transporter to upload the ipa to App Store Connect

### Building an Windows app - Not yet tested

For more information, see [here][windows-build-guide]

```sh
flutter build windows //Build windows app 
```

### Building an Linux app - Not yet tested

For more information, see [here][linux-build-guide]

```sh
flutter build linux //Build linux app 
```

### Testing

To run tests for the solution, run the following command in project home directory

```sh
flutter test
```

And if you would like code coverage generated

```sh
flutter test --coverage
```

This will generate a `${lcov.info}` file.

### Documentation

To generate documentation for your Flutter project, you can use the `dartdoc` tool, which is a Dart
documentation generator. Dartdoc generates API reference documentation and can also be used to
generate documentation for your Flutter project.

To generate Flutter documentation, follow these steps:

1. Ensure that you have the `dartdoc` tool installed. You can install it using the following
   command:
    ```sh
    pub global activate dartdoc
    ```

2. Run the dartdoc command to generate the documentation:
    ```sh
    dart doc .
    ```

By default, the documentation is generated to the doc/api directory as static HTML files.

3. You can view the generated docs directly from the file system, but if you want to use the search
   function, you
   must load them with an HTTP server.

An easy way to run an HTTP server locally is to use the dhttpd package. For example:

```sh
dart pub global activate dhttpd
dhttpd --path doc/api
```

Navigate to http://localhost:8080 in your browser; the search function should now work.

### Troubleshooting

If experiencing iOS related build with modules (invalid, missing, not found), see the following link
for help [Here][ios-pods-cleaning]


[//]: # (Links and references)

[download]: <https://docs.flutter.dev/get-started/install>

[windows-environment]: <https://flutter.dev/docs/get-started/install/windows#update-your-path>

[macos-environment]: <https://docs.flutter.dev/get-started/install/macos#update-your-path>

[linux-environment]: <https://docs.flutter.dev/get-started/install/linux#update-your-path>

[android-emulator-guide]: <https://flutter.dev/docs/get-started/install/windows#set-up-the-android-emulator>

[android-build-guide]: <https://flutter.dev/docs/deployment/android>

[ios-build-guide]: <https://flutter.dev/docs/deployment/ios>

[macos-build-guide]: <https://docs.flutter.dev/deployment/macos>

[linux-build-guide]: <https://docs.flutter.dev/deployment/linux>

[windows-build-guide]: <https://flutter.dev/docs/deployment/windows>

[web-build-guide]: <https://docs.flutter.dev/deployment/web>

[ios-pods-cleaning]: <https://github.com/flutter/flutter/issues/41383#issuecomment-549432413>

[laguna-backend]: <https://github.com/SloveniaEngineering/laguna-backend>
