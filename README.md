# fut_map

## Description

Map over futures in parallel.

The problem with `Future.wait` is that you have to start all futures at the same time. fut_map allows you
to control the concurrency over a list of futures.

## Usage

```dart
import 'dart:math';
import 'package:fut_map/fut_map.dart';

Future<int> delayedSquare(int x) async {
    await Future.delayed(Duration(milliseconds: Random().nextInt(2000)));
    return x * x;
}

void main()  {
  fMap([1,2,3,4,5,6,7,8,9], delayedSquare, parallel: 3).then((result) {
    // Iterable<int> result;
    print("Result $result");
  });
}
```
