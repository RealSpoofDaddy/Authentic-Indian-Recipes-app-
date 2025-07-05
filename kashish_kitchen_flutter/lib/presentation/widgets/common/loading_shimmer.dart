import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/theme/app_theme.dart';

class LoadingShimmer extends StatelessWidget {
  final int itemCount;
  final double height;
  final bool isHorizontal;

  const LoadingShimmer({
    Key? key,
    this.itemCount = 3,
    this.height = 280,
    this.isHorizontal = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Shimmer.fromColors(
        baseColor: AppTheme.textLight.withOpacity(0.3),
        highlightColor: AppTheme.surfaceColor,
        child: isHorizontal
            ? ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: itemCount,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) => _buildShimmerCard(),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: itemCount,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) => _buildShimmerCard(),
              ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      width: isHorizontal ? 200 : double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            height: isHorizontal ? 140 : 200,
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title placeholder
                Container(
                  height: 18,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.cardColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle placeholder
                Container(
                  height: 14,
                  width: isHorizontal ? 120 : 200,
                  decoration: BoxDecoration(
                    color: AppTheme.cardColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 12),
                // Info chips placeholder
                Row(
                  children: [
                    Container(
                      height: 24,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 24,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeListShimmer extends StatelessWidget {
  final int itemCount;

  const RecipeListShimmer({
    Key? key,
    this.itemCount = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.textLight.withOpacity(0.3),
      highlightColor: AppTheme.surfaceColor,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: itemCount,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) => _buildListShimmerItem(),
      ),
    );
  }

  Widget _buildListShimmerItem() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Image placeholder
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title placeholder
                  Container(
                    height: 18,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle placeholder
                  Container(
                    height: 14,
                    width: 150,
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Another line
                  Container(
                    height: 14,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Spacer(),
                  // Info chips placeholder
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppTheme.cardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 20,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppTheme.cardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}