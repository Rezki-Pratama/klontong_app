import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong_project/features/common/app_colors.dart';

class ButtonLoader extends StatelessWidget {
  const ButtonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 24.w,
        width: 24.w,
        child: CircularProgressIndicator(
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.mainColorWhite),
            strokeWidth: 2.w),
      ),
    );
  }
}
