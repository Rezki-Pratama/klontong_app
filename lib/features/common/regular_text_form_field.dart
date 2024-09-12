import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong_project/features/common/app_colors.dart';

class RegularTextFormField extends StatefulWidget {
  const RegularTextFormField({
    super.key,
    this.textFormFieldKey,
    required this.controller,
    required this.label,
    this.additionalInfo,
    this.autovalidateMode,
    this.hint,
    this.maxLines,
    this.maxLength,
    this.obscureText,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.showErrorText = true,
    this.validator,
    this.successInfo,
    this.keyboardType,
    this.inputFormatter,
    this.enableInteractiveSelection,
  });

  final Key? textFormFieldKey;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? additionalInfo;
  final String? successInfo;
  final int? maxLines;
  final int? maxLength;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final bool showErrorText;
  final Widget? suffixIcon;
  final bool? enableInteractiveSelection;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;

  @override
  State<RegularTextFormField> createState() => _RegularTextFormFieldState();
}

class _RegularTextFormFieldState extends State<RegularTextFormField> {
  String _value = '';
  bool _isInvalidValue = false;
  final FocusNode _textFieldFocus = FocusNode();

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {});
      } else {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _textFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: _isInvalidValue
          ? const BorderSide(width: 1.0, color: AppColors.error50)
          : const BorderSide(width: 1.0, color: AppColors.neutral50),
    );

    var negativeBorder = defaultBorder.copyWith(
        borderSide: _isInvalidValue
            ? const BorderSide(width: 0.0, color: AppColors.error50)
            : const BorderSide(width: 0.0, color: AppColors.passiveColor));

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8.0),
          TextFormField(
              focusNode: _textFieldFocus,
              autovalidateMode: widget.autovalidateMode,
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              inputFormatters: widget.inputFormatter,
              maxLength: widget.maxLength,
              enableInteractiveSelection: widget.enableInteractiveSelection,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder:
                    _textFieldFocus.hasFocus ? defaultBorder : negativeBorder,
                focusedBorder:
                    _textFieldFocus.hasFocus ? defaultBorder : negativeBorder,
                focusedErrorBorder: defaultBorder,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 1, color: AppColors.error50),
                ),
                errorStyle: const TextStyle(
                  height: 0,
                  color: Colors.transparent,
                  fontSize: 0,
                ),
                focusColor:
                    _isInvalidValue ? AppColors.error50 : AppColors.primary50,
                fillColor: _textFieldFocus.hasFocus
                    ? Colors.white
                    : AppColors.passiveColor,
                filled: true,
                hintText: widget.hint,
                counter: const Offstage(),
                labelText: widget.label,
                labelStyle: TextStyle(
                  fontSize: 12.sp,
                  color: _isInvalidValue ? AppColors.error50 : AppColors.textS0,
                ),
                suffixIcon: widget.suffixIcon,
              ),
              key: widget.textFormFieldKey,
              maxLines: widget.maxLines ?? 1,
              obscureText: widget.obscureText ?? false,
              onChanged: (value) {
                widget.onChanged?.call(value);
                setState(() {
                  _value = value;
                  _isInvalidValue = widget.validator?.call(_value) != null;
                });
              },
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              style: Theme.of(context).textTheme.bodyMedium,
              validator: (value) {
                final validation = widget.validator?.call(_value);
                _isInvalidValue = validation != null;
                return validation;
              }),
          const SizedBox(height: 2.0),
          Visibility(
            visible: widget.additionalInfo != null &&
                !_isInvalidValue &&
                widget.successInfo == null,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  widget.additionalInfo ?? '',
                  style: const TextStyle(
                    color: AppColors.neutral70,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ]),
          ),
          Visibility(
            visible: widget.successInfo != null && !_isInvalidValue,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  widget.successInfo ?? '',
                  style: const TextStyle(
                    color: AppColors.mainColorGreen,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ]),
          ),
          Visibility(
            visible: _isInvalidValue && widget.showErrorText,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  widget.validator?.call(_value) ?? '',
                  style: const TextStyle(
                    color: AppColors.error50,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ]),
          )
        ]);
  }
}
