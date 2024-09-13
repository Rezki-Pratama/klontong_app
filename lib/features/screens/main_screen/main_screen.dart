import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong_project/features/bloc/product_bloc/product_bloc.dart';
import 'package:klontong_project/features/common/app_colors.dart';
import 'package:klontong_project/features/common/bottom_loader.dart';
import 'package:klontong_project/features/common/regular_text_form_field.dart';
import 'package:klontong_project/features/route/app_arguments.dart';
import 'package:klontong_project/features/route/routes.dart';
import 'package:klontong_project/features/screens/main_screen/components/product_card.dart';
import 'package:klontong_project/features/screens/main_screen/components/product_skeleton.dart';
import 'package:klontong_project/utils/debouncer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  final debouncer = Debouncer(milliseconds: 1000);

  _retrieveProduct() {
    context.read<ProductBloc>().add(const RetrieveProduct(isScroll: false));
  }

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      context.read<ProductBloc>().add(const RetrieveProduct(isScroll: true));
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _retrieveProduct();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Klontong"),
          actions: [
            SizedBox(width: 5.w),
            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(Routes.inputRoute, arguments: InputArguments())
                      .then((isRetrieve) {
                    if (isRetrieve == true) {
                      _retrieveProduct();
                    }
                  });
                },
                child: Container(
                    margin: EdgeInsets.all(10.w),
                    width: 50.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                        border:
                            Border.all(width: 3.w, color: AppColors.text50)),
                    child: Center(child: Icon(Icons.add_rounded, size: 25.w)))),
            SizedBox(width: 5.w),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: RegularTextFormField(
                  controller: _searchController,
                  label: 'Search',
                  onChanged: (value) {
                    debouncer.run(() {
                      context
                          .read<ProductBloc>()
                          .add(RetrieveProduct(isScroll: false, search: value));
                    });
                  }),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state.status == ProductStatus.updated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    _retrieveProduct();
                  } else if (state.status == ProductStatus.errorUpdate) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  } else if (state.status == ProductStatus.deleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    _retrieveProduct();
                  } else if (state.status == ProductStatus.errorDelete) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                buildWhen: (previous, current) {
                  return () {
                    if (current.status == ProductStatus.loaded ||
                        current.status == ProductStatus.empty ||
                        current.status == ProductStatus.loadingRetrieve ||
                        current.status == ProductStatus.errorRetrieve) {
                      return true;
                    }

                    return false;
                  }();
                },
                builder: (context, state) {
                  switch (state.status) {
                    case ProductStatus.loaded:
                      return RefreshIndicator(
                        key: const Key('productData'),
                        color: AppColors.secondary50,
                        onRefresh: () async {
                          await Future.delayed(const Duration(seconds: 1));
                          _retrieveProduct();
                        },
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            controller: _scrollController,
                            itemCount: state.hasReachedMax
                                ? state.data.length
                                : state.data.length + 1,
                            itemBuilder: (context, index) {
                              return index >= state.data.length
                                  ? (state.data.length < 7)
                                      ? Container()
                                      : const BottomLoader()
                                  : ProductCard(
                                      data: state.data[index],
                                      onUpdate: () {
                                        Navigator.of(context).pushNamed(
                                            Routes.inputRoute,
                                            arguments: InputArguments(
                                                data: state.data[index]));
                                      },
                                      onDelete: () {
                                        context.read<ProductBloc>().add(
                                            DeleteProduct(
                                                id: state.data[index].id));
                                      });
                            }),
                      );
                    case ProductStatus.empty:
                      return const Center(
                        child: Text("Empty"),
                      );
                    case ProductStatus.loadingRetrieve:
                      return const ProductSkeleton();
                    case ProductStatus.errorRetrieve:
                      return Center(
                        child: Text(state.message),
                      );
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
