# f_map

Map over futures in parlallel.

The problem with `Future.all` is that you have to start all futures at the same time. f_map allows you
to control the concurrency over a list of futures.

## Usage

```dart
import 'dart:math';
import 'package:f_map/f_map.dart';

Future<int> delayedSquare(int x) async {
    await Future.delayed(Duration(milliseconds: Random().nextInt(2000)));
    return x * x;
};

void main()  {
  fmap([1,2,3,4,5,6,7,8,9], delayedSquare, parallel: 3).then((List<int> result) {
    print("Result $result");
  });
}
```
