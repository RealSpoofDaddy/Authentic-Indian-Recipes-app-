class AppConstants {
  static const String appName = 'Kashish\'s Kitchen';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Authentic Indian Recipes';
  
  // Firebase Collections
  static const String recipesCollection = 'recipes';
  static const String usersCollection = 'users';
  static const String categoriesCollection = 'categories';
  static const String favoritesCollection = 'favorites';
  static const String reviewsCollection = 'reviews';
  
  // Recipe Categories
  static const List<String> recipeCategories = [
    'North Indian',
    'South Indian',
    'Bengali',
    'Gujarati',
    'Punjabi',
    'Rajasthani',
    'Maharashtrian',
    'Street Food',
    'Desserts',
    'Beverages',
    'Breakfast',
    'Snacks',
  ];
  
  // Recipe Types
  static const List<String> recipeTypes = [
    'Vegetarian',
    'Non-Vegetarian',
    'Vegan',
    'Gluten-Free',
    'Dairy-Free',
  ];
  
  // Difficulty Levels
  static const List<String> difficultyLevels = [
    'Easy',
    'Medium',
    'Hard',
  ];
  
  // Cooking Methods
  static const List<String> cookingMethods = [
    'Frying',
    'Boiling',
    'Grilling',
    'Baking',
    'Steaming',
    'Roasting',
    'Sautéing',
  ];
  
  // Default Images
  static const String defaultRecipeImage = 'assets/images/default_recipe.jpg';
  static const String defaultUserImage = 'assets/images/default_user.jpg';
  static const String appLogo = 'assets/images/app_logo.png';
  
  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  
  // Padding and Margins
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;
  
  // Border Radius
  static const double smallBorderRadius = 8.0;
  static const double mediumBorderRadius = 12.0;
  static const double largeBorderRadius = 16.0;
  static const double extraLargeBorderRadius = 24.0;
  
  // API Keys and URLs
  static const String baseUrl = 'https://api.kashishkitchen.com';
  static const String imageBaseUrl = 'https://images.kashishkitchen.com';
  
  // Hive Boxes
  static const String userBox = 'user_box';
  static const String recipeBox = 'recipe_box';
  static const String favoriteBox = 'favorite_box';
  static const String cacheBox = 'cache_box';
  
  // Notification Channels
  static const String timerChannelId = 'timer_channel';
  static const String timerChannelName = 'Cooking Timer';
  static const String timerChannelDescription = 'Notifications for cooking timers';
  
  // Search and Filter
  static const int maxSearchResults = 50;
  static const int recipesPerPage = 20;
  
  // Social Media
  static const String instagramUrl = 'https://instagram.com/kashishkitchen';
  static const String facebookUrl = 'https://facebook.com/kashishkitchen';
  static const String twitterUrl = 'https://twitter.com/kashishkitchen';
  
  // Support
  static const String supportEmail = 'support@kashishkitchen.com';
  static const String privacyPolicyUrl = 'https://kashishkitchen.com/privacy';
  static const String termsOfServiceUrl = 'https://kashishkitchen.com/terms';
}