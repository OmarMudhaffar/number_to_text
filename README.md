<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Convert The Numbers Into Humanized text

## Features

Support Both English And Arabic Languages

## Getting started

To use NumberToString in your project, add the number_to_string package to pubspec.yaml: 
```dart
number_to_string: 0.0.1
```

Import the package to use it:

```dart
import 'package:number_to_string/number_to_string.dart';
```

## Usage

- **First Create New Instance**

```dart
NumberToString numberToString = new NumberToString();
```

- **English** use

```dart
Container(
child:Text(number.parse(1000, "en")) // Thousand
)
```

- **Arabic** use

```dart
Container(
child:Text(number.parse(1000, "ar")) // الف
)
```

## Follow Me On Linkedin

[OmarMudhaffar](https://www.linkedin.com/in/omarmudhaffar)