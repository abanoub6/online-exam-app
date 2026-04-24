import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class ExamsShimmer extends StatelessWidget {
  const ExamsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.w(16),
          vertical: AppSizes.h(16),
        ),
        itemCount: 6,
        itemExtent: AppSizes.h(120),
        itemBuilder: (_, __) => const _ShimmerCard(),
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.h(12)),
      child: Container(
        padding: EdgeInsets.all(AppSizes.h(16)),
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.circular(AppSizes.r(12)),
        ),
        child: Row(
          children: [
            Container(
              width: AppSizes.w(48),
              height: AppSizes.h(48),
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(AppSizes.r(8)),
              ),
            ),
            SizedBox(width: AppSizes.w(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: AppSizes.h(16),
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: BorderRadius.circular(AppSizes.r(4)),
                    ),
                  ),
                  SizedBox(height: AppSizes.h(8)),
                  Container(
                    width: AppSizes.w(100),
                    height: AppSizes.h(12),
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: BorderRadius.circular(AppSizes.r(4)),
                    ),
                  ),
                  SizedBox(height: AppSizes.h(8)),
                  Container(
                    width: AppSizes.w(80),
                    height: AppSizes.h(12),
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: BorderRadius.circular(AppSizes.r(4)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: AppSizes.w(8)),
            Container(
              width: AppSizes.w(70),
              height: AppSizes.h(28),
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(AppSizes.r(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
