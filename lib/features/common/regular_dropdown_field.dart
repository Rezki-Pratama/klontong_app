import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong_project/features/common/app_colors.dart';

class RegularDropdownButtonFormField<T> extends StatelessWidget {
  final T? selectedValue;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final void Function(T?) onChanged;
  final String? Function(T?) validator;
  final String labelText;
  final TextStyle? labelStyle;

  const RegularDropdownButtonFormField({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
    required this.validator,
    required this.labelText,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: labelStyle ??
              Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.passiveColor),
          child: DropdownButtonFormField<T>(
            key: const Key('dropdownField'),
            value: selectedValue,
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  itemLabelBuilder(item),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }).toList(),
            onChanged: (T? newValue) {
              onChanged(newValue);
            },
            validator: validator,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      width: 1,
                      color: AppColors
                          .error50), // Border color when there's an error
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      width: 1,
                      color: AppColors
                          .error50), // Border color when focused and there's an error
                ),
                errorStyle: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.error50,
                )),
          ),
        ),
      ],
    );
  }
}
