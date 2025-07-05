import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String? displayName;

  @HiveField(4)
  final String? photoUrl;

  @HiveField(5)
  final String? phoneNumber;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime updatedAt;

  @HiveField(8)
  final DateTime? lastLoginAt;

  @HiveField(9)
  final bool isEmailVerified;

  @HiveField(10)
  final String? bio;

  @HiveField(11)
  final String? location;

  @HiveField(12)
  final String? favoriteCategory;

  @HiveField(13)
  final String? cookingSkillLevel;

  @HiveField(14)
  final List<String> dietaryRestrictions;

  @HiveField(15)
  final List<String> favoriteRecipes;

  @HiveField(16)
  final List<String> dislikedIngredients;

  @HiveField(17)
  final int recipesCreated;

  @HiveField(18)
  final int recipesRated;

  @HiveField(19)
  final double averageRatingGiven;

  @HiveField(20)
  final bool isPrivate;

  @HiveField(21)
  final bool notificationsEnabled;

  @HiveField(22)
  final String preferredLanguage;

  @HiveField(23)
  final String preferredTheme;

  @HiveField(24)
  final String? spicePreference;

  @HiveField(25)
  final Map<String, dynamic> preferences;

  @HiveField(26)
  final List<String> achievements;

  @HiveField(27)
  final int cookingStreak;

  @HiveField(28)
  final DateTime? lastCookingDate;

  @HiveField(29)
  final Map<String, int> categoryStats;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    this.isEmailVerified = false,
    this.bio,
    this.location,
    this.favoriteCategory,
    this.cookingSkillLevel,
    this.dietaryRestrictions = const [],
    this.favoriteRecipes = const [],
    this.dislikedIngredients = const [],
    this.recipesCreated = 0,
    this.recipesRated = 0,
    this.averageRatingGiven = 0.0,
    this.isPrivate = false,
    this.notificationsEnabled = true,
    this.preferredLanguage = 'en',
    this.preferredTheme = 'system',
    this.spicePreference,
    this.preferences = const {},
    this.achievements = const [],
    this.cookingStreak = 0,
    this.lastCookingDate,
    this.categoryStats = const {},
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // Helper methods
  String get displayNameOrName => displayName ?? name;

  String get initials {
    final nameParts = displayNameOrName.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return displayNameOrName.isNotEmpty ? displayNameOrName[0].toUpperCase() : '';
  }

  bool get hasProfileImage => photoUrl != null && photoUrl!.isNotEmpty;

  String get skillLevelEmoji {
    switch (cookingSkillLevel?.toLowerCase()) {
      case 'beginner':
        return '🌱';
      case 'intermediate':
        return '🍳';
      case 'advanced':
        return '👨‍🍳';
      case 'expert':
        return '🏆';
      default:
        return '🍳';
    }
  }

  String get spicePreferenceEmoji {
    switch (spicePreference?.toLowerCase()) {
      case 'mild':
        return '🌶️';
      case 'medium':
        return '🌶️🌶️';
      case 'hot':
        return '🌶️🌶️🌶️';
      case 'very hot':
        return '🌶️🌶️🌶️🌶️';
      default:
        return '🌶️🌶️';
    }
  }

  bool get isNewUser {
    final now = DateTime.now();
    final daysSinceCreation = now.difference(createdAt).inDays;
    return daysSinceCreation <= 7;
  }

  bool get isActiveUser {
    if (lastLoginAt == null) return false;
    final now = DateTime.now();
    final daysSinceLastLogin = now.difference(lastLoginAt!).inDays;
    return daysSinceLastLogin <= 30;
  }

  String get memberSince {
    final now = DateTime.now();
    final duration = now.difference(createdAt);
    if (duration.inDays > 365) {
      final years = duration.inDays ~/ 365;
      return years == 1 ? '1 year' : '$years years';
    } else if (duration.inDays > 30) {
      final months = duration.inDays ~/ 30;
      return months == 1 ? '1 month' : '$months months';
    } else {
      return duration.inDays == 1 ? '1 day' : '${duration.inDays} days';
    }
  }

  int get totalRecipeInteractions => recipesCreated + recipesRated;

  double get engagementScore {
    if (totalRecipeInteractions == 0) return 0.0;
    return (recipesRated * 0.3 + recipesCreated * 0.7) / totalRecipeInteractions;
  }

  List<String> get allAchievements {
    final achievements = <String>[];
    
    // Cooking streak achievements
    if (cookingStreak >= 7) achievements.add('Week Warrior');
    if (cookingStreak >= 30) achievements.add('Month Master');
    if (cookingStreak >= 100) achievements.add('Century Cook');
    
    // Recipe creation achievements
    if (recipesCreated >= 1) achievements.add('Recipe Creator');
    if (recipesCreated >= 10) achievements.add('Culinary Author');
    if (recipesCreated >= 50) achievements.add('Recipe Master');
    
    // Rating achievements
    if (recipesRated >= 10) achievements.add('Taste Tester');
    if (recipesRated >= 50) achievements.add('Food Critic');
    if (recipesRated >= 100) achievements.add('Culinary Judge');
    
    // Favorite recipes achievements
    if (favoriteRecipes.length >= 5) achievements.add('Recipe Collector');
    if (favoriteRecipes.length >= 25) achievements.add('Flavor Explorer');
    if (favoriteRecipes.length >= 100) achievements.add('Culinary Connoisseur');
    
    return achievements;
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    bool? isEmailVerified,
    String? bio,
    String? location,
    String? favoriteCategory,
    String? cookingSkillLevel,
    List<String>? dietaryRestrictions,
    List<String>? favoriteRecipes,
    List<String>? dislikedIngredients,
    int? recipesCreated,
    int? recipesRated,
    double? averageRatingGiven,
    bool? isPrivate,
    bool? notificationsEnabled,
    String? preferredLanguage,
    String? preferredTheme,
    String? spicePreference,
    Map<String, dynamic>? preferences,
    List<String>? achievements,
    int? cookingStreak,
    DateTime? lastCookingDate,
    Map<String, int>? categoryStats,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      favoriteCategory: favoriteCategory ?? this.favoriteCategory,
      cookingSkillLevel: cookingSkillLevel ?? this.cookingSkillLevel,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      favoriteRecipes: favoriteRecipes ?? this.favoriteRecipes,
      dislikedIngredients: dislikedIngredients ?? this.dislikedIngredients,
      recipesCreated: recipesCreated ?? this.recipesCreated,
      recipesRated: recipesRated ?? this.recipesRated,
      averageRatingGiven: averageRatingGiven ?? this.averageRatingGiven,
      isPrivate: isPrivate ?? this.isPrivate,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      preferredTheme: preferredTheme ?? this.preferredTheme,
      spicePreference: spicePreference ?? this.spicePreference,
      preferences: preferences ?? this.preferences,
      achievements: achievements ?? this.achievements,
      cookingStreak: cookingStreak ?? this.cookingStreak,
      lastCookingDate: lastCookingDate ?? this.lastCookingDate,
      categoryStats: categoryStats ?? this.categoryStats,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email)';
  }
}