import 'package:flutter_riverpod/flutter_riverpod.dart';

AsyncValue<(T1, T2, T3, T4)> combineAsyncValues4<T1, T2, T3, T4>(
    AsyncValue<T1> a,
    AsyncValue<T2> b,
    AsyncValue<T3> c,
    AsyncValue<T4> d,
    ) {
  // どれか1つでもロード中なら loading を返す
  if (a.isLoading || b.isLoading || c.isLoading || d.isLoading) {
    return const AsyncValue.loading();
  }

  // どれか1つでもエラーなら最初のエラーを返す
  if (a.hasError) {
    return AsyncValue.error(a.error!, a.stackTrace!);
  }
  if (b.hasError) {
    return AsyncValue.error(b.error!, b.stackTrace!);
  }
  if (c.hasError) {
    return AsyncValue.error(c.error!, c.stackTrace!);
  }
  if (d.hasError) {
    return AsyncValue.error(c.error!, c.stackTrace!);
  }

  // すべて data の場合
  if (a.hasValue && b.hasValue && c.hasValue && d.hasValue) {
    return AsyncValue.data((a.value!, b.value!, c.value!, d.value!));
  }

  // 万が一（全部 null の場合）
  return const AsyncValue.loading();
}

/// 3つの AsyncValue をまとめて扱うユーティリティ関数
AsyncValue<(T1, T2, T3)> combineAsyncValues3<T1, T2, T3>(
    AsyncValue<T1> a,
    AsyncValue<T2> b,
    AsyncValue<T3> c,
    ) {
  // どれか1つでもロード中なら loading を返す
  if (a.isLoading || b.isLoading || c.isLoading) {
    return const AsyncValue.loading();
  }

  // どれか1つでもエラーなら最初のエラーを返す
  if (a.hasError) {
    return AsyncValue.error(a.error!, a.stackTrace!);
  }
  if (b.hasError) {
    return AsyncValue.error(b.error!, b.stackTrace!);
  }
  if (c.hasError) {
    return AsyncValue.error(c.error!, c.stackTrace!);
  }

  // すべて data の場合
  if (a.hasValue && b.hasValue && c.hasValue) {
    return AsyncValue.data((a.value!, b.value!, c.value!));
  }

  // 万が一（全部 null の場合）
  return const AsyncValue.loading();
}

/// 3つの AsyncValue をまとめて扱うユーティリティ関数
AsyncValue<(T1, T2)> combineAsyncValues2<T1, T2>(
    AsyncValue<T1> a,
    AsyncValue<T2> b,
    ) {
  // どれか1つでもロード中なら loading を返す
  if (a.isLoading || b.isLoading) {
    return const AsyncValue.loading();
  }

  // どれか1つでもエラーなら最初のエラーを返す
  if (a.hasError) {
    return AsyncValue.error(a.error!, a.stackTrace!);
  }
  if (b.hasError) {
    return AsyncValue.error(b.error!, b.stackTrace!);
  }

  // すべて data の場合
  if (a.hasValue && b.hasValue) {
    return AsyncValue.data((a.value!, b.value!));
  }

  // 万が一（全部 null の場合）
  return const AsyncValue.loading();
}