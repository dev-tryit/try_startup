extension NullableNumberExtension on num? {
  bool get isNull => this == null;
}
extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
