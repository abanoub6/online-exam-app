import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.h(24)),
        child: Column(
          children: [
            SizedBox(height: AppSizes.h(24)),

            Center(
              child: CircleAvatar(
                radius: AppSizes.h(50),
                backgroundColor: AppColors.gray,
              ),
            ),
            SizedBox(height: AppSizes.h(32)),

            _buildShimmerField(),
            SizedBox(height: AppSizes.h(16)),

            Row(
              children: [
                Expanded(child: _buildShimmerField()),
                SizedBox(width: AppSizes.w(16)),
                Expanded(child: _buildShimmerField()),
              ],
            ),
            SizedBox(height: AppSizes.h(16)),

            _buildShimmerField(),
            SizedBox(height: AppSizes.h(16)),

            _buildShimmerField(),
            SizedBox(height: AppSizes.h(16)),

            _buildShimmerField(),
            SizedBox(height: AppSizes.h(40)),

            Container(
              width: double.infinity,
              height: AppSizes.h(56),
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(AppSizes.r(12)),
              ),
            ),
            SizedBox(height: AppSizes.h(24)),
          ],
        ),
      ),
    );
  }

  static Widget _buildShimmerField() {
    return Container(
      width: double.infinity,
      height: AppSizes.h(48),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(AppSizes.r(8)),
      ),
    );
  }
}
