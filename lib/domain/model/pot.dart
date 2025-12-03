import 'package:freezed_annotation/freezed_annotation.dart';

part 'pot.freezed.dart';

@freezed
class Pot with _$Pot {
  const factory Pot({
    required String id,
    required int slotIndex,
    required int itemId,
  }) = _Pot;
}