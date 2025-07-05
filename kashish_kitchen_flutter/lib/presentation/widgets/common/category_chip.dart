import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  final VoidCallback? onTap;
  final bool isSelected;

  const CategoryChip({
    Key? key,
    required this.category,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected 
              ? AppTheme.primaryGradient
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.cardColor,
                    AppTheme.surfaceColor,
                  ],
                ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected 
                ? AppTheme.primaryColor 
                : AppTheme.primaryColor.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (isSelected ? AppTheme.primaryColor : Colors.black)
                  .withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getCategoryIcon(category),
              size: 32,
              color: isSelected ? Colors.white : AppTheme.primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              category,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'north indian':
        return Icons.restaurant;
      case 'south indian':
        return Icons.rice_bowl;
      case 'bengali':
        return Icons.set_meal;
      case 'gujarati':
        return Icons.local_dining;
      case 'punjabi':
        return Icons.dinner_dining;
      case 'rajasthani':
        return Icons.restaurant_menu;
      case 'maharashtrian':
        return Icons.lunch_dining;
      case 'street food':
        return Icons.food_truck;
      case 'desserts':
        return Icons.cake;
      case 'beverages':
        return Icons.local_cafe;
      case 'breakfast':
        return Icons.free_breakfast;
      case 'snacks':
        return Icons.fastfood;
      default:
        return Icons.restaurant;
    }
  }
}