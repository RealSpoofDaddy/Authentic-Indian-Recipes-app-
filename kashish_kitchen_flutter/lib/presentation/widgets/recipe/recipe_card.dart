import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/recipe_model.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/app_providers.dart';

class RecipeCard extends ConsumerWidget {
  final RecipeModel recipe;
  final VoidCallback? onTap;
  final bool isCompact;

  const RecipeCard({
    Key? key,
    required this.recipe,
    this.onTap,
    this.isCompact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.contains(recipe.id);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(context, ref, isFavorite),
            _buildContentSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, WidgetRef ref, bool isFavorite) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: AspectRatio(
            aspectRatio: isCompact ? 16 / 9 : 4 / 3,
            child: CachedNetworkImage(
              imageUrl: recipe.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppTheme.cardColor,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppTheme.cardColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.restaurant,
                      size: 48,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipe.name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ),
        // Favorite button
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () async {
              await ref.read(favoritesProvider.notifier).toggleFavorite(recipe.id);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorite ? 'Removed from favorites' : 'Added to favorites',
                  ),
                  duration: const Duration(seconds: 1),
                  backgroundColor: isFavorite ? AppTheme.errorColor : AppTheme.successColor,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? AppTheme.errorColor : AppTheme.textSecondary,
                size: 20,
              ),
            ),
          ),
        ),
        // Category tag
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              recipe.category,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        // Rating
        if (recipe.rating > 0)
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    recipe.ratingString,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            if (!isCompact) ...[
              Text(
                recipe.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
            ],
            Row(
              children: [
                _buildInfoChip(
                  context,
                  icon: Icons.access_time,
                  text: recipe.totalTimeString,
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  context,
                  icon: Icons.restaurant,
                  text: recipe.servingsString,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  recipe.difficultyEmoji,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 4),
                Text(
                  recipe.difficulty,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  recipe.spiceLevelEmoji,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 4),
                Text(
                  recipe.spiceLevel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (recipe.isVegetarian || recipe.isVegan) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  if (recipe.isVegan)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.successColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Vegan',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.successColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    )
                  else if (recipe.isVegetarian)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.secondaryColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Vegetarian',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.secondaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, {required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}