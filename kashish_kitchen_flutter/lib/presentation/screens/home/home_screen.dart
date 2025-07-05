import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../providers/app_providers.dart';
import '../../widgets/recipe/recipe_card.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/category_chip.dart';
import '../../widgets/common/loading_shimmer.dart';
import '../recipe/recipe_detail_screen.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/recipe_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipesAsync = ref.watch(recipesProvider);
    final categories = ref.watch(categoriesProvider);
    final recentRecipes = ref.watch(recentRecipesProvider);
    final favorites = ref.watch(favoritesProvider);
    final isOnline = ref.watch(isOnlineProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildAppBar(context),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildWelcomeSection(context),
                    const SizedBox(height: 16),
                    _buildStatsSection(context, recipesAsync, favorites.length),
                    const SizedBox(height: 24),
                    _buildCategoriesSection(context, categories),
                    const SizedBox(height: 24),
                    _buildFeaturedRecipesSection(context, recipesAsync),
                    const SizedBox(height: 24),
                    if (recentRecipes.isNotEmpty) ...[
                      _buildRecentRecipesSection(context, recentRecipes),
                      const SizedBox(height: 24),
                    ],
                    _buildQuickTipsSection(context),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 80,
      floating: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.restaurant_menu,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Kashish\'s Kitchen',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Navigate to notifications
          },
          icon: const Icon(
            Icons.notifications_outlined,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor.withOpacity(0.1),
                AppTheme.secondaryColor.withOpacity(0.1),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.waving_hand,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Welcome to Authentic Indian Cuisine!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Discover traditional recipes passed down through generations. Each dish tells a story of India\'s rich culinary heritage.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppTheme.primaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Tip: Use the timer feature while cooking!',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, AsyncValue<List<RecipeModel>> recipesAsync, int favoritesCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              context,
              icon: Icons.restaurant,
              title: 'Recipes',
              value: recipesAsync.when(
                data: (recipes) => recipes.length.toString(),
                loading: () => '...',
                error: (_, __) => '0',
              ),
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              context,
              icon: Icons.favorite,
              title: 'Favorites',
              value: favoritesCount.toString(),
              color: AppTheme.errorColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              context,
              icon: Icons.category,
              title: 'Categories',
              value: AppConstants.recipeCategories.length.toString(),
              color: AppTheme.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context, List<String> categories) {
    return Column(
      children: [
        SectionHeader(
          title: 'Categories',
          subtitle: 'Explore recipes by region',
          onSeeAll: () {
            // Navigate to categories screen
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: AnimationLimiter(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: CategoryChip(
                        category: categories[index],
                        onTap: () {
                          ref.read(selectedCategoryProvider.notifier).state = categories[index];
                          // Navigate to filtered recipes
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedRecipesSection(BuildContext context, AsyncValue<List<RecipeModel>> recipesAsync) {
    return Column(
      children: [
        SectionHeader(
          title: 'Featured Recipes',
          subtitle: 'Popular dishes you\'ll love',
          onSeeAll: () {
            // Navigate to all recipes
          },
        ),
        const SizedBox(height: 16),
        recipesAsync.when(
          data: (recipes) {
            if (recipes.isEmpty) {
              return const Center(
                child: Text('No recipes available'),
              );
            }
            
            final featuredRecipes = recipes.take(5).toList();
            return SizedBox(
              height: 280,
              child: AnimationLimiter(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: featuredRecipes.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final recipe = featuredRecipes[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: SizedBox(
                            width: 200,
                            child: RecipeCard(
                              recipe: recipe,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecipeDetailScreen(recipe: recipe),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
          loading: () => const LoadingShimmer(),
          error: (error, stack) => Center(
            child: Text('Error: ${error.toString()}'),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentRecipesSection(BuildContext context, List<RecipeModel> recentRecipes) {
    return Column(
      children: [
        SectionHeader(
          title: 'Recently Viewed',
          subtitle: 'Pick up where you left off',
          onSeeAll: () {
            // Navigate to recently viewed recipes
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: AnimationLimiter(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: recentRecipes.take(5).length,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final recipe = recentRecipes[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: SizedBox(
                        width: 200,
                        child: RecipeCard(
                          recipe: recipe,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeDetailScreen(recipe: recipe),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickTipsSection(BuildContext context) {
    final tips = [
      'Use fresh spices for authentic flavors',
      'Soak rice for 30 minutes before cooking',
      'Temper spices in hot oil for best results',
      'Let dal rest for 10 minutes after cooking',
    ];

    return Column(
      children: [
        SectionHeader(
          title: 'Quick Tips',
          subtitle: 'Master the art of Indian cooking',
        ),
        const SizedBox(height: 16),
        ...tips.asMap().entries.map((entry) {
          final index = entry.key;
          final tip = entry.value;
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.lightbulb_outline,
                          color: AppTheme.primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          tip,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}