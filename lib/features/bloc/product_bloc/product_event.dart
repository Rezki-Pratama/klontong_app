part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class RetrieveProduct extends ProductEvent {
  final bool isScroll;
  final String search;
  const RetrieveProduct({this.isScroll = false, this.search = ''});
}

class StoreProduct extends ProductEvent {
  final Product data;
  const StoreProduct({required this.data});
}

class UpdateProduct extends ProductEvent {
  final Product data;
  const UpdateProduct({required this.data});
}

class DeleteProduct extends ProductEvent {
  final String id;
  const DeleteProduct({required this.id});
}
