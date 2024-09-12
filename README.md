# Klontong Mobile App

Mobile app of the Klontong App.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project to a live system.

### Prerequisites
This project uses [Flutter](https://flutter.dev/) to build, test, and deploy multiplatform mobile apps from a single codebase. To build and run this project, you need to have Flutter installed on your machine.

You can refer to this [link](https://docs.flutter.dev/get-started/install) to install Flutter and set up the platform. To be able to build and run this project, you have to complete the [iOS](https://docs.flutter.dev/get-started/install/macos#ios-setup) and [Android](https://docs.flutter.dev/get-started/install/macos#android-setup) platform setup on your machine.

### Run the project

* [Set up an editor](https://docs.flutter.dev/get-started/editor?tab=vscode) that supports Flutter development.
* Open the project directory on your local machine using your preferred editor.
* Run the app on your preferred mobile device by referring to this [link](https://docs.flutter.dev/get-started/test-drive?tab=vscode) on section **Run the app**.

## Instruction Deploy in your local environment

1. Clone from this repository by download zip or https or ssh (recommended using https or ssh)
   - Copy repository url
   - Open your fav code editor _(Recommended using Android Studio or Visual Studio Code)_
   - _(Android Studio)_ New -> Project from Version Control.. -> Paste the url, click OK
   - _(Visual Studio Code)_ create folder where do you want, open terminal and paste url clone then enter -> open root folder.
2. Run "flutter pub get" in the project directory or click the highlighted instruction in Android Studio or Visual Studio Code
3. Run "flutter gen-l10n" to generate the internationalizations any concern about this please refer to this [Internationalizations](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
4. Prepare the Android Virtual Device or real device _(Make sure its supported device)_
5. Run main.dart


## Tests
To run the test, you can run this command:

`flutter test`

You can run this command to see the code coverage report:

`flutter test --coverage`

The report will be available on the `coverage/lcov.info` file.


To see the report in HTML format, you can use [lcov](https://formulae.brew.sh/formula/lcov). Run this command to generate HTML based code coverage report:

`genhtml coverage/lcov.info -o coverage/html`

Check the generated HTML format report by opening the `coverage/html/index.html` file.

## Deployment
TBD


## Contributing
This project uses the [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) design approach which has the objective of separation of concerns. This separation achieved by dividing the software into layers.

When contributing to this project please follows the [SOLID design principles](https://kessler.tech/software-architecture/solid/) that implemented by Clean Architecture design. 

This way we can have this project more understandable, flexible and maintainable.


## Built With

### User Interface
* [Flutter](https://github.com/flutter/flutter) - Flutter makes it easy and fast to build beautiful apps for mobile and beyond.
* [Cupertino Icons](https://github.com/flutter/packages/tree/main/third_party/packages/cupertino_icons) - Default icons asset for Cupertino widgets based on Apple styled icons.

### State Management
* [flutter_bloc](https://github.com/felangel/bloc/tree/master/packages/flutter_bloc) - Flutter Widgets that make it easy to implement the BLoC (Business Logic Component) design pattern. Built to be used with the bloc state management package.
* [stream_transform](https://pub.dev/packages/stream_transform) - Provides utilities for working with Dart Streams, including combining and transforming streams.
* [bloc_concurrency](https://pub.dev/packages/bloc_concurrency) - A package that provides tools for managing concurrency within BLoC and Cubit implementations, including throttling and debouncing.

### Dart Extension
* [Equatable](https://github.com/felangel/equatable) - A Dart package that helps to implement value based equality without needing to explicitly override `==` and `hashCode`.
* [dartz](https://github.com/spebbe/dartz) - Functional Programming in Dart. Purify your Dart code using efficient immutable data structures, monads, lenses and other FP tools.
* [intl](https://pub.dev/packages/intl) - Provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.
* [google_fonts](https://pub.dev/packages/google_fonts) - A Flutter package to use fonts from fonts.google.com.

### Service Locator
* [get_it](https://github.com/fluttercommunity/get_it) - Simple direct Service Locator that allows to decouple the interface from a concrete implementation and to access the concrete implementation from everywhere in your App.

### Code Generation
* [build_runner](https://github.com/dart-lang/build/tree/master/build_runner) - A build system for Dart code generation and modular compilation.

### Linter
* [flutter_lints](https://github.com/flutter/packages/tree/main/packages/flutter_lints) - Recommended lints for Flutter apps, packages, and plugins to encourage good coding practices.

### Localization
* [flutter_localizations](https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html) - Flutter’s built-in package that provides localized resources for Flutter apps.
* [flutter_gen_l10n](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization) - A tool to generate localization files based on your `arb` files. Run `flutter gen-l10n` to generate the internationalizations.

### Screen Adaptation
* [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) - A package that helps with screen size adaptation, making it easier to develop responsive Flutter applications.

### Shimmer Effect
* [shimmer](https://pub.dev/packages/shimmer) - A package for adding shimmer effects to your Flutter application, useful for creating loading placeholders.

### Http Network
* [http](https://pub.dev/packages/http) - A composable, Future-based API for making HTTP requests in Dart and Flutter.
* [http_interceptor](https://pub.dev/packages/http_interceptor) - A package that allows you to intercept and modify HTTP requests and responses in Flutter.
