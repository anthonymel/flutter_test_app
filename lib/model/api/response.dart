class Response<T> {
  String? error;
  dynamic data;
  Map<String, dynamic>? meta;
  T? result;

  Response({
    this.error,
    this.data,
    this.meta,
    this.result,
  });

  bool get hasError => (errorText?.isNotEmpty ?? false);

  String? get errorText => error ?? meta?["error"];
}
