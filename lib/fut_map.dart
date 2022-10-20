Future<Iterable<U>> fMap<T, U>(
    Iterable<T> iterable,
    Future<U> Function(T input) mapper, {
      int parallel = 1,
  }) async {
  final futures = <Future<U>>[];
  int running = 0;
  int executed = 0;
  var it = iterable.iterator;
  var results = <U>[];
  await Future.doWhile(() async {

    if (running < parallel) {
      if (it.moveNext()) {
        Future<U> fut = mapper(it.current).then((value) {
          running--;
          results.add(value);
          executed++;
          return value;
        });
        futures.add(fut);
        fut.whenComplete(() => futures.remove(fut));
        running++;
      } else {
        // wait for the rest of the missions after we're done with the iterable
        await Future.wait(futures);
      }
    } else {
      // wait for any of the futures to finish in order to go to the next
      await Future.any(futures);
    }
    return executed != iterable.length;
  });
  return Future.value(results);
}
