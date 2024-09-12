import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong_project/features/common/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin:
                EdgeInsets.only(top: 6.h, bottom: 6.h, left: 16.w, right: 16.w),
            padding: EdgeInsets.all(10.w),
            height: 120.h,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(8.w)),
            child: Shimmer.fromColors(
              baseColor: AppColors.neutral50,
              highlightColor: AppColors.neutral70,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.neutral50,
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          height: 15.h,
                          width: 80.w,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.neutral50,
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          height: 15.h,
                          width: 80.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.neutral50,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.neutral50,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.neutral50,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.neutral50,
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                      height: 10.h,
                      width: 100.w,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.neutral50,
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                      height: 10.h,
                      width: 100.w,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
