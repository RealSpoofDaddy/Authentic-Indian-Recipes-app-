import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

import '../../core/constants/app_constants.dart';
import '../models/recipe_model.dart';
import '../models/user_model.dart';

class CacheService {
  static late Box _userBox;
  static late Box _recipeBox;
  static late Box _favoriteBox;
  static late Box _cacheBox;

  static Future<void> init() async {
    // Register adapters for custom objects
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(RecipeModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(IngredientModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(InstructionModelAdapter());
    }

    // Open boxes
    _userBox = await Hive.openBox(AppConstants.userBox);
    _recipeBox = await Hive.openBox(AppConstants.recipeBox);
    _favoriteBox = await Hive.openBox(AppConstants.favoriteBox);
    _cacheBox = await Hive.openBox(AppConstants.cacheBox);

    if (kDebugMode) {
      print('Cache service initialized');
    }
  }

  // User-related methods
  static Future<void> cacheUser(UserModel user) async {
    await _userBox.put('current_user', user);
  }

  static UserModel? getCachedUser() {
    return _userBox.get('current_user');
  }

  static Future<void> clearUserCache() async {
    await _userBox.delete('current_user');
  }

  // Recipe-related methods
  static Future<void> cacheRecipe(RecipeModel recipe) async {
    await _recipeBox.put(recipe.id, recipe);
  }

  static Future<void> cacheRecipes(List<RecipeModel> recipes) async {
    final Map<String, RecipeModel> recipeMap = {};
    for (final recipe in recipes) {
      recipeMap[recipe.id] = recipe;
    }
    await _recipeBox.putAll(recipeMap);
  }

  static RecipeModel? getCachedRecipe(String recipeId) {
    return _recipeBox.get(recipeId);
  }

  static List<RecipeModel> getCachedRecipes() {
    return _recipeBox.values.cast<RecipeModel>().toList();
  }

  static List<RecipeModel> getCachedRecipesByCategory(String category) {
    return _recipeBox.values
        .cast<RecipeModel>()
        .where((recipe) => recipe.category == category)
        .toList();
  }

  static Future<void> clearRecipeCache() async {
    await _recipeBox.clear();
  }

  // Favorite-related methods
  static Future<void> addToFavorites(String recipeId) async {
    final favorites = getFavorites();
    if (!favorites.contains(recipeId)) {
      favorites.add(recipeId);
      await _favoriteBox.put('favorites', favorites);
    }
  }

  static Future<void> removeFromFavorites(String recipeId) async {
    final favorites = getFavorites();
    favorites.remove(recipeId);
    await _favoriteBox.put('favorites', favorites);
  }

  static List<String> getFavorites() {
    return _favoriteBox.get('favorites', defaultValue: <String>[]).cast<String>();
  }

  static bool isFavorite(String recipeId) {
    return getFavorites().contains(recipeId);
  }

  static List<RecipeModel> getFavoriteRecipes() {
    final favoriteIds = getFavorites();
    final favoriteRecipes = <RecipeModel>[];
    
    for (final id in favoriteIds) {
      final recipe = getCachedRecipe(id);
      if (recipe != null) {
        favoriteRecipes.add(recipe);
      }
    }
    
    return favoriteRecipes;
  }

  static Future<void> clearFavorites() async {
    await _favoriteBox.clear();
  }

  // General cache methods
  static Future<void> cacheData(String key, dynamic data) async {
    await _cacheBox.put(key, data);
  }

  static T? getCachedData<T>(String key) {
    return _cacheBox.get(key);
  }

  static Future<void> clearCachedData(String key) async {
    await _cacheBox.delete(key);
  }

  // Search history
  static Future<void> addToSearchHistory(String query) async {
    final history = getSearchHistory();
    if (history.contains(query)) {
      history.remove(query);
    }
    history.insert(0, query);
    
    // Keep only last 10 searches
    if (history.length > 10) {
      history.removeRange(10, history.length);
    }
    
    await _cacheBox.put('search_history', history);
  }

  static List<String> getSearchHistory() {
    return _cacheBox.get('search_history', defaultValue: <String>[]).cast<String>();
  }

  static Future<void> clearSearchHistory() async {
    await _cacheBox.delete('search_history');
  }

  // App settings
  static Future<void> setThemeMode(String themeMode) async {
    await _cacheBox.put('theme_mode', themeMode);
  }

  static String getThemeMode() {
    return _cacheBox.get('theme_mode', defaultValue: 'system');
  }

  static Future<void> setLanguage(String language) async {
    await _cacheBox.put('language', language);
  }

  static String getLanguage() {
    return _cacheBox.get('language', defaultValue: 'en');
  }

  static Future<void> setNotificationsEnabled(bool enabled) async {
    await _cacheBox.put('notifications_enabled', enabled);
  }

  static bool getNotificationsEnabled() {
    return _cacheBox.get('notifications_enabled', defaultValue: true);
  }

  // Recipe view history
  static Future<void> addToViewHistory(String recipeId) async {
    final history = getViewHistory();
    if (history.contains(recipeId)) {
      history.remove(recipeId);
    }
    history.insert(0, recipeId);
    
    // Keep only last 20 viewed recipes
    if (history.length > 20) {
      history.removeRange(20, history.length);
    }
    
    await _cacheBox.put('view_history', history);
  }

  static List<String> getViewHistory() {
    return _cacheBox.get('view_history', defaultValue: <String>[]).cast<String>();
  }

  static List<RecipeModel> getViewedRecipes() {
    final historyIds = getViewHistory();
    final viewedRecipes = <RecipeModel>[];
    
    for (final id in historyIds) {
      final recipe = getCachedRecipe(id);
      if (recipe != null) {
        viewedRecipes.add(recipe);
      }
    }
    
    return viewedRecipes;
  }

  static Future<void> clearViewHistory() async {
    await _cacheBox.delete('view_history');
  }

  // Offline status
  static Future<void> setOfflineMode(bool isOffline) async {
    await _cacheBox.put('is_offline', isOffline);
  }

  static bool getOfflineMode() {
    return _cacheBox.get('is_offline', defaultValue: false);
  }

  // Last sync time
  static Future<void> setLastSyncTime(DateTime time) async {
    await _cacheBox.put('last_sync', time.millisecondsSinceEpoch);
  }

  static DateTime? getLastSyncTime() {
    final timestamp = _cacheBox.get('last_sync');
    return timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : null;
  }

  // Cache size and management
  static int getCacheSize() {
    return _recipeBox.length + _userBox.length + _favoriteBox.length + _cacheBox.length;
  }

  static Future<void> clearAllCache() async {
    await _recipeBox.clear();
    await _userBox.clear();
    await _favoriteBox.clear();
    await _cacheBox.clear();
  }

  // Cache statistics
  static Map<String, int> getCacheStatistics() {
    return {
      'recipes': _recipeBox.length,
      'users': _userBox.length,
      'favorites': getFavorites().length,
      'cache_entries': _cacheBox.length,
    };
  }

  static Future<void> dispose() async {
    await _userBox.close();
    await _recipeBox.close();
    await _favoriteBox.close();
    await _cacheBox.close();
  }
}