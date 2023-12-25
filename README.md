# dart_multimethod

dart_multimethod is a package that provides multimethods for Dart.

## Features

* multimethod functions

## Getting started

### Installation

Add `dart_multimethod` to your `pubspec.yaml` file:

```yaml
dependencies:
  dart_multimethod: ^0.0.2
```

### Import

```dart
import 'package:dart_multimethod/dart_multimethod.dart';
```

## Usage

### Basic usage

```dart
import 'package:dart_multimethod/dart_multimethod.dart';

final area = Multimethod<String, MyClass, String>((o) => o.name).when('first', (o) => '${o.name} square');
print(area(MyClass('first')));  // first square
```
