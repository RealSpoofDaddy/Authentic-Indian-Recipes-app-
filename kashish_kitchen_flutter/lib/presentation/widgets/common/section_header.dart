import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSeeAll;
  final Widget? action;

  const SectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.onSeeAll,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null)
            action!
          else if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'See All',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}