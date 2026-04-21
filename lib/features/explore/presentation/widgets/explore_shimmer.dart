import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class ExploreShimmer extends StatelessWidget {
  const ExploreShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 6,
        padding: EdgeInsets.symmetric(horizontal: AppSizes.w(24)),
        itemBuilder: (context, index) => _buildShimmerCard(),
      ),
    );
  }

  static Widget _buildShimmerCard() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.h(12)),
      child: Container(
        width: double.infinity,
        height: AppSizes.h(72),
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.circular(AppSizes.r(12)),
        ),
      ),
    );
  }
}
