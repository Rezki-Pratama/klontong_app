part of 'product_bloc.dart';

enum ProductStatus {
  initial,
  loadingRetrieve,
  loadingStore,
  loadingDelete,
  loadingUpdate,
  empty,
  loaded,
  stored,
  updated,
  deleted,
  errorRetrieve,
  errorStore,
  errorDelete,
  errorUpdate,
}

class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    this.data = const <Product>[],
    this.hasReachedMax = false,
    this.message = "",
  });

  final ProductStatus status;
  final List<Product> data;
  final bool hasReachedMax;
  final String message;

  ProductState copyWith(
      {ProductStatus? status,
      List<Product>? data,
      bool? hasReachedMax,
      String? message}) {
    return ProductState(
      status: status ?? this.status,
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''ProductState { status: $status, hasReachedMax: $hasReachedMax, data: ${data.length}, message: $message }''';
  }

  @override
  List<Object> get props => [status, data, hasReachedMax];
}
