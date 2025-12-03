import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'farm_ticker_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<DateTime> farmTicker(FarmTickerRef ref) async* {
  while (true) {
    await Future.delayed(const Duration(seconds: 30));
    yield DateTime.now();
  }
}