import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../data/models/recipe_model.dart';
import '../../data/models/user_model.dart';
import '../../data/services/cache_service.dart';
import '../../core/constants/app_constants.dart';

// Authentication Providers
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final currentUserProvider = StateProvider<UserModel?>((ref) {
  return null;
});

// Theme Providers
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final savedTheme = CacheService.getThemeMode();
  switch (savedTheme) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
});

// Connectivity Provider
final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity().onConnectivityChanged;
});

final isOnlineProvider = Provider<bool>((ref) {
  final connectivity = ref.watch(connectivityProvider);
  return connectivity.when(
    data: (result) => result != ConnectivityResult.none,
    loading: () => true,
    error: (_, __) => false,
  );
});

// Recipe Providers
final recipesProvider = StateNotifierProvider<RecipesNotifier, AsyncValue<List<RecipeModel>>>((ref) {
  return RecipesNotifier(ref);
});

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  return FavoritesNotifier(ref);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

final filteredRecipesProvider = Provider<List<RecipeModel>>((ref) {
  final recipes = ref.watch(recipesProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  
  return recipes.when(
    data: (recipeList) {
      var filtered = recipeList;
      
      // Filter by category
      if (selectedCategory != null && selectedCategory.isNotEmpty) {
        filtered = filtered.where((recipe) => recipe.category == selectedCategory).toList();
      }
      
      // Filter by search query
      if (searchQuery.isNotEmpty) {
        filtered = filtered.where((recipe) {
          final query = searchQuery.toLowerCase();
          return recipe.name.toLowerCase().contains(query) ||
                 recipe.description.toLowerCase().contains(query) ||
                 recipe.tags.any((tag) => tag.toLowerCase().contains(query)) ||
                 recipe.ingredients.any((ingredient) => ingredient.name.toLowerCase().contains(query));
        }).toList();
      }
      
      return filtered;
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

// Search History Provider
final searchHistoryProvider = StateNotifierProvider<SearchHistoryNotifier, List<String>>((ref) {
  return SearchHistoryNotifier();
});

// Recipe Detail Provider
final selectedRecipeProvider = StateProvider<RecipeModel?>((ref) => null);

// Cooking Timer Provider
final cookingTimerProvider = StateNotifierProvider<CookingTimerNotifier, CookingTimerState>((ref) {
  return CookingTimerNotifier();
});

// Loading State Provider
final loadingProvider = StateProvider<bool>((ref) => false);

// Error Provider
final errorProvider = StateProvider<String?>((ref) => null);

// Language Provider
final languageProvider = StateProvider<String>((ref) {
  return CacheService.getLanguage();
});

// Notification Provider
final notificationProvider = StateProvider<bool>((ref) {
  return CacheService.getNotificationsEnabled();
});

// Categories Provider
final categoriesProvider = Provider<List<String>>((ref) {
  return AppConstants.recipeCategories;
});

// Recent Recipes Provider
final recentRecipesProvider = Provider<List<RecipeModel>>((ref) {
  return CacheService.getViewedRecipes();
});

// State Notifiers
class RecipesNotifier extends StateNotifier<AsyncValue<List<RecipeModel>>> {
  final Ref ref;
  
  RecipesNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadRecipes();
  }
  
  Future<void> loadRecipes() async {
    try {
      state = const AsyncValue.loading();
      
      // Try to load from cache first
      final cachedRecipes = CacheService.getCachedRecipes();
      if (cachedRecipes.isNotEmpty) {
        state = AsyncValue.data(cachedRecipes);
      }
      
      // Load from Firebase if online
      final isOnline = ref.read(isOnlineProvider);
      if (isOnline) {
        final firestore = ref.read(firestoreProvider);
        final snapshot = await firestore.collection(AppConstants.recipesCollection).get();
        
        final recipes = snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return RecipeModel.fromJson(data);
        }).toList();
        
        // Cache the recipes
        await CacheService.cacheRecipes(recipes);
        state = AsyncValue.data(recipes);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  Future<void> addRecipe(RecipeModel recipe) async {
    try {
      final firestore = ref.read(firestoreProvider);
      await firestore.collection(AppConstants.recipesCollection).doc(recipe.id).set(recipe.toJson());
      
      // Add to cache
      await CacheService.cacheRecipe(recipe);
      
      // Reload recipes
      await loadRecipes();
    } catch (error) {
      ref.read(errorProvider.notifier).state = error.toString();
    }
  }
  
  Future<void> updateRecipe(RecipeModel recipe) async {
    try {
      final firestore = ref.read(firestoreProvider);
      await firestore.collection(AppConstants.recipesCollection).doc(recipe.id).update(recipe.toJson());
      
      // Update cache
      await CacheService.cacheRecipe(recipe);
      
      // Reload recipes
      await loadRecipes();
    } catch (error) {
      ref.read(errorProvider.notifier).state = error.toString();
    }
  }
  
  Future<void> deleteRecipe(String recipeId) async {
    try {
      final firestore = ref.read(firestoreProvider);
      await firestore.collection(AppConstants.recipesCollection).doc(recipeId).delete();
      
      // Remove from cache
      await CacheService.clearCachedData(recipeId);
      
      // Reload recipes
      await loadRecipes();
    } catch (error) {
      ref.read(errorProvider.notifier).state = error.toString();
    }
  }
  
  Future<void> refreshRecipes() async {
    await loadRecipes();
  }
}

class FavoritesNotifier extends StateNotifier<List<String>> {
  final Ref ref;
  
  FavoritesNotifier(this.ref) : super([]) {
    loadFavorites();
  }
  
  void loadFavorites() {
    state = CacheService.getFavorites();
  }
  
  Future<void> toggleFavorite(String recipeId) async {
    if (state.contains(recipeId)) {
      await CacheService.removeFromFavorites(recipeId);
    } else {
      await CacheService.addToFavorites(recipeId);
    }
    loadFavorites();
  }
  
  bool isFavorite(String recipeId) {
    return state.contains(recipeId);
  }
  
  Future<void> clearFavorites() async {
    await CacheService.clearFavorites();
    loadFavorites();
  }
}

class SearchHistoryNotifier extends StateNotifier<List<String>> {
  SearchHistoryNotifier() : super([]) {
    loadSearchHistory();
  }
  
  void loadSearchHistory() {
    state = CacheService.getSearchHistory();
  }
  
  Future<void> addToHistory(String query) async {
    await CacheService.addToSearchHistory(query);
    loadSearchHistory();
  }
  
  Future<void> clearHistory() async {
    await CacheService.clearSearchHistory();
    loadSearchHistory();
  }
}

class CookingTimerState {
  final bool isRunning;
  final Duration duration;
  final Duration elapsed;
  final String? recipeName;
  final String? stepName;
  final int? stepNumber;
  
  const CookingTimerState({
    this.isRunning = false,
    this.duration = Duration.zero,
    this.elapsed = Duration.zero,
    this.recipeName,
    this.stepName,
    this.stepNumber,
  });
  
  CookingTimerState copyWith({
    bool? isRunning,
    Duration? duration,
    Duration? elapsed,
    String? recipeName,
    String? stepName,
    int? stepNumber,
  }) {
    return CookingTimerState(
      isRunning: isRunning ?? this.isRunning,
      duration: duration ?? this.duration,
      elapsed: elapsed ?? this.elapsed,
      recipeName: recipeName ?? this.recipeName,
      stepName: stepName ?? this.stepName,
      stepNumber: stepNumber ?? this.stepNumber,
    );
  }
  
  Duration get remaining => duration - elapsed;
  
  double get progress => duration.inMilliseconds > 0 ? elapsed.inMilliseconds / duration.inMilliseconds : 0.0;
  
  bool get isCompleted => elapsed >= duration;
}

class CookingTimerNotifier extends StateNotifier<CookingTimerState> {
  CookingTimerNotifier() : super(const CookingTimerState());
  
  void startTimer({
    required Duration duration,
    String? recipeName,
    String? stepName,
    int? stepNumber,
  }) {
    state = CookingTimerState(
      isRunning: true,
      duration: duration,
      elapsed: Duration.zero,
      recipeName: recipeName,
      stepName: stepName,
      stepNumber: stepNumber,
    );
  }
  
  void pauseTimer() {
    state = state.copyWith(isRunning: false);
  }
  
  void resumeTimer() {
    state = state.copyWith(isRunning: true);
  }
  
  void stopTimer() {
    state = const CookingTimerState();
  }
  
  void updateElapsed(Duration elapsed) {
    state = state.copyWith(elapsed: elapsed);
  }
}

// Helper functions for providers
Future<void> setThemeMode(WidgetRef ref, ThemeMode mode) async {
  ref.read(themeModeProvider.notifier).state = mode;
  await CacheService.setThemeMode(mode.name);
}

Future<void> setLanguage(WidgetRef ref, String language) async {
  ref.read(languageProvider.notifier).state = language;
  await CacheService.setLanguage(language);
}

Future<void> setNotificationsEnabled(WidgetRef ref, bool enabled) async {
  ref.read(notificationProvider.notifier).state = enabled;
  await CacheService.setNotificationsEnabled(enabled);
}

Future<void> clearError(WidgetRef ref) async {
  ref.read(errorProvider.notifier).state = null;
}

Future<void> setLoading(WidgetRef ref, bool loading) async {
  ref.read(loadingProvider.notifier).state = loading;
}