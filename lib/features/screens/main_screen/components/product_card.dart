import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong_project/core/domains/model/product.dart';
import 'package:klontong_project/features/common/app_colors.dart';
import 'package:klontong_project/utils/common_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  final VoidCallback? onUpdate;
  final VoidCallback? onDelete;
  const ProductCard(
      {super.key, required this.data, this.onUpdate, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onUpdate,
      child: Container(
        margin: EdgeInsets.only(top: 6.h, bottom: 6.h, left: 16.w, right: 16.w),
        padding: EdgeInsets.all(10.w),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(data.name,
                      style: Theme.of(context).textTheme.titleSmall),
                ),
                SizedBox(width: 10.w),
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                      color: AppColors.secondary50,
                      borderRadius: BorderRadius.circular(5.w)),
                  child: Text(data.categoryName,
                      style: Theme.of(context).textTheme.labelMedium),
                )
              ],
            ),
            SizedBox(height: 10.h),
            Text(data.description,
                style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("${data.price.toCurrencyFormat()} IDR",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Text(
                          "${AppLocalizations.of(context)!.weight}: ${data.weight}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: onDelete,
                  child: Icon(Icons.delete,
                      size: 25.w, color: AppColors.primaryRed),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
