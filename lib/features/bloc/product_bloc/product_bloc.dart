import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong_project/core/domains/model/product.dart';
import 'package:klontong_project/core/domains/usecase/product_use_case.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'product_event.dart';
part 'product_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  int page = 1;
  final ProductUseCase _useCase;
  ProductBloc(this._useCase) : super(const ProductState()) {
    on<RetrieveProduct>(
      retrieveProduct,
      transformer: throttleDroppable(throttleDuration),
    );
    on<StoreProduct>(
      storeProduct,
    );
    on<UpdateProduct>(
      updateProduct,
    );
    on<DeleteProduct>(
      deleteProduct,
    );
  }

  storeProduct(StoreProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loadingStore));
    final result = await _useCase.store(data: event.data);
    result.fold((failure) {
      emit(state.copyWith(
          status: ProductStatus.errorStore, message: failure.message));
    }, (data) {
      emit(state.copyWith(
          status: ProductStatus.stored, message: 'saved successfuly'));
    });
  }

  updateProduct(UpdateProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loadingStore));
    final result = await _useCase.store(data: event.data);
    result.fold((failure) {
      emit(state.copyWith(
          status: ProductStatus.errorStore, message: failure.message));
    }, (data) {
      emit(state.copyWith(
          status: ProductStatus.stored, message: 'saved successfuly'));
    });
  }

  deleteProduct(DeleteProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loadingDelete));
    final result = await _useCase.delete(event.id);
    result.fold((failure) {
      emit(state.copyWith(
          status: ProductStatus.errorDelete, message: failure.message));
    }, (data) {
      emit(state.copyWith(
          status: ProductStatus.deleted, message: 'deleted successfuly'));
    });
  }

  retrieveProduct(RetrieveProduct event, Emitter<ProductState> emit) async {
    if (event.isScroll) {
      page++;
      if (state.hasReachedMax) return;

      final result = await _useCase.paginate(page);
      result.fold((failure) {
        emit(state.copyWith(
            status: ProductStatus.errorRetrieve, message: failure.message));
      }, (data) {
        return data.isEmpty
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(
                state.copyWith(
                    status: ProductStatus.loaded,
                    data: List.of(state.data)..addAll(data),
                    hasReachedMax: false),
              );
      });
    } else {
      emit(state.copyWith(status: ProductStatus.loadingRetrieve));

      page = 1;
      final result = await _useCase.paginate(page);
      result.fold((failure) {
        emit(state.copyWith(
            status: ProductStatus.errorRetrieve, message: failure.message));
      }, (data) {
        if (data.isNotEmpty) {
          return emit(state.copyWith(
              status: ProductStatus.loaded, data: data, hasReachedMax: false));
        } else {
          return emit(state.copyWith(
              status: ProductStatus.empty, data: data, hasReachedMax: false));
        }
      });
    }
  }
}
