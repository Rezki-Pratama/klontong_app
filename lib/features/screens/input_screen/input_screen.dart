import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong_project/core/domains/model/category.dart';
import 'package:klontong_project/core/domains/model/product.dart';
import 'package:klontong_project/features/bloc/product_bloc/product_bloc.dart';
import 'package:klontong_project/features/common/app_colors.dart';
import 'package:klontong_project/features/common/button_loader.dart';
import 'package:klontong_project/features/common/regular_dropdown_field.dart';
import 'package:klontong_project/features/common/regular_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:klontong_project/features/route/app_arguments.dart';

class InputScreen extends StatefulWidget {
  final InputArguments arguments;
  const InputScreen({super.key, required this.arguments});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameFieldController = TextEditingController();
  TextEditingController _categoryFieldController = TextEditingController();
  TextEditingController _descriptionFieldController = TextEditingController();
  TextEditingController _skuFieldController = TextEditingController();
  TextEditingController _weightFieldController = TextEditingController();
  TextEditingController _widthFieldController = TextEditingController();
  TextEditingController _lengthFieldController = TextEditingController();
  TextEditingController _heightFieldController = TextEditingController();
  TextEditingController _priceFieldController = TextEditingController();

  Category? _selectedCategory;

  final List<Category> categories = [
    Category(id: 1, name: 'Cemilan'),
    Category(id: 2, name: 'Minuman'),
  ];

  _submitProduct() {
    int weight = int.tryParse(_weightFieldController.text) ?? 0;
    int width = int.tryParse(_widthFieldController.text) ?? 0;
    int length = int.tryParse(_lengthFieldController.text) ?? 0;
    int height = int.tryParse(_heightFieldController.text) ?? 0;
    int price = int.tryParse(_priceFieldController.text) ?? 0;
    Product data = Product(
      id: widget.arguments.data?.id ?? '',
      categoryId:
          _selectedCategory?.id ?? 0, // Gunakan id kategori yang dipilih
      categoryName:
          _selectedCategory?.name ?? '', // Gunakan nama kategori yang dipilih
      sku: _skuFieldController.text,
      name: _nameFieldController.text,
      description: _descriptionFieldController.text,
      weight: weight,
      width: width,
      length: length,
      height: height,
      image: 'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b',
      price: price,
    );
    if (widget.arguments.data != null && widget.arguments.data!.id.isNotEmpty) {
      context.read<ProductBloc>().add(UpdateProduct(data: data));
    } else {
      context.read<ProductBloc>().add(StoreProduct(data: data));
    }
  }

  @override
  void initState() {
    super.initState();
    if (categories.isNotEmpty) {
      _selectedCategory = categories.first;
    }
    if (widget.arguments.data != null) {
      Product? data = widget.arguments.data;
      _nameFieldController = TextEditingController(text: data?.name ?? '');
      _categoryFieldController =
          TextEditingController(text: data?.categoryName ?? '');
      _descriptionFieldController =
          TextEditingController(text: data?.description ?? '');
      _skuFieldController = TextEditingController(text: data?.sku ?? '');
      _weightFieldController =
          TextEditingController(text: data?.weight.toString());
      _widthFieldController =
          TextEditingController(text: data?.width.toString());
      _lengthFieldController =
          TextEditingController(text: data?.length.toString());
      _heightFieldController =
          TextEditingController(text: data?.height.toString());
      _priceFieldController =
          TextEditingController(text: data?.price.toString());

      // set selected category
      _selectedCategory = categories.firstWhere(
        (category) => category.id == data?.categoryId,
        orElse: () => categories.first, // Default category if not found
      );
    }
  }

  String? _validateCategory(Category? category) {
    if (category == null) {
      return AppLocalizations.of(context)!
          .validation
          .replaceAll('<title>', AppLocalizations.of(context)!.category);
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _nameFieldController.dispose();
    _categoryFieldController.dispose();
    _descriptionFieldController.dispose();
    _priceFieldController.dispose();
    _skuFieldController.dispose();
    _weightFieldController.dispose();
    _widthFieldController.dispose();
    _lengthFieldController.dispose();
    _heightFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.addProduct),
        ),
        body: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state.status == ProductStatus.stored) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pop(context, true);
            } else if (state.status == ProductStatus.errorStore) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    RegularTextFormField(
                      key: const Key('nameField'),
                      controller: _nameFieldController,
                      label: AppLocalizations.of(context)!.name,
                      validator: (value) {
                        if (!_nameFieldController.text.isNotEmpty) {
                          return AppLocalizations.of(context)!
                              .validation
                              .replaceAll('<title>',
                                  AppLocalizations.of(context)!.name);
                        } else {
                          return null;
                        }
                      },
                      showErrorText: !_nameFieldController.text.isNotEmpty,
                    ),
                    SizedBox(height: 10.h),
                    RegularDropdownButtonFormField<Category>(
                      key: const Key('categoryField'),
                      selectedValue: _selectedCategory,
                      items: categories,
                      itemLabelBuilder: (Category category) => category.name,
                      onChanged: (Category? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                      validator: (value) => _validateCategory(value),
                      labelText: AppLocalizations.of(context)!.category,
                      labelStyle:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(height: 10.h),
                    RegularTextFormField(
                      key: const Key('descriptionField'),
                      controller: _descriptionFieldController,
                      label: AppLocalizations.of(context)!.description,
                      maxLines: 4,
                    ),
                    SizedBox(height: 10.h),
                    RegularTextFormField(
                      key: const Key('priceField'),
                      controller: _priceFieldController,
                      label: AppLocalizations.of(context)!.price,
                      validator: (value) {
                        if (!_priceFieldController.text.isNotEmpty) {
                          return AppLocalizations.of(context)!
                              .validation
                              .replaceAll('<title>',
                                  AppLocalizations.of(context)!.price);
                        } else {
                          return null;
                        }
                      },
                      showErrorText: !_priceFieldController.text.isNotEmpty,
                      keyboardType: TextInputType.number,
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    SizedBox(height: 10.h),
                    RegularTextFormField(
                      key: const Key('skuField'),
                      controller: _skuFieldController,
                      label: 'Sku',
                      validator: (value) {
                        if (!_skuFieldController.text.isNotEmpty) {
                          return AppLocalizations.of(context)!
                              .validation
                              .replaceAll('<title>', 'sku');
                        } else {
                          return null;
                        }
                      },
                      showErrorText: !_skuFieldController.text.isNotEmpty,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: RegularTextFormField(
                            key: const Key('weightField'),
                            controller: _weightFieldController,
                            label: AppLocalizations.of(context)!.weight,
                            validator: (value) {
                              if (!_weightFieldController.text.isNotEmpty) {
                                return AppLocalizations.of(context)!
                                    .validation
                                    .replaceAll('<title>',
                                        AppLocalizations.of(context)!.weight);
                              } else {
                                return null;
                              }
                            },
                            showErrorText:
                                !_weightFieldController.text.isNotEmpty,
                            keyboardType: TextInputType.number,
                            inputFormatter: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(width: 10.h),
                        Flexible(
                          child: RegularTextFormField(
                            key: const Key('lengthField'),
                            controller: _lengthFieldController,
                            label: AppLocalizations.of(context)!.length,
                            validator: (value) {
                              if (!_lengthFieldController.text.isNotEmpty) {
                                return AppLocalizations.of(context)!
                                    .validation
                                    .replaceAll('<title>',
                                        AppLocalizations.of(context)!.length);
                              } else {
                                return null;
                              }
                            },
                            showErrorText:
                                !_lengthFieldController.text.isNotEmpty,
                            keyboardType: TextInputType.number,
                            inputFormatter: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: RegularTextFormField(
                            key: const Key('heightField'),
                            controller: _heightFieldController,
                            label: AppLocalizations.of(context)!.height,
                            validator: (value) {
                              if (!_heightFieldController.text.isNotEmpty) {
                                return AppLocalizations.of(context)!
                                    .validation
                                    .replaceAll('<title>',
                                        AppLocalizations.of(context)!.height);
                              } else {
                                return null;
                              }
                            },
                            showErrorText:
                                !_heightFieldController.text.isNotEmpty,
                            keyboardType: TextInputType.number,
                            inputFormatter: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(width: 10.h),
                        Flexible(
                          child: RegularTextFormField(
                            key: const Key('widthField'),
                            controller: _widthFieldController,
                            label: AppLocalizations.of(context)!.width,
                            validator: (value) {
                              if (!_widthFieldController.text.isNotEmpty) {
                                return AppLocalizations.of(context)!
                                    .validation
                                    .replaceAll('<title>',
                                        AppLocalizations.of(context)!.width);
                              } else {
                                return null;
                              }
                            },
                            showErrorText:
                                !_widthFieldController.text.isNotEmpty,
                            keyboardType: TextInputType.number,
                            inputFormatter: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _submitProduct();
                        } else {
                          setState(() {});
                        }
                      },
                      child: Container(
                        key: const Key('submitButton'),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                            color: AppColors.cardBlue,
                            borderRadius: BorderRadius.circular(19.w)),
                        child: Center(
                          child: BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              return () {
                                if (state.status ==
                                    ProductStatus.loadingStore) {
                                  return const ButtonLoader(
                                    key: Key('buttonLoader'),
                                  );
                                } else {
                                  return Text(() {
                                    if (widget.arguments.data != null) {
                                      return AppLocalizations.of(context)!
                                          .update;
                                    } else {
                                      return AppLocalizations.of(context)!.save;
                                    }
                                  }(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold));
                                }
                              }();
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
