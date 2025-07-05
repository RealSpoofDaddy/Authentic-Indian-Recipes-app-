import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class RecipeModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String cuisine;

  @HiveField(5)
  final String difficulty;

  @HiveField(6)
  final int prepTime; // in minutes

  @HiveField(7)
  final int cookTime; // in minutes

  @HiveField(8)
  final int servings;

  @HiveField(9)
  final List<IngredientModel> ingredients;

  @HiveField(10)
  final List<InstructionModel> instructions;

  @HiveField(11)
  final String imageUrl;

  @HiveField(12)
  final List<String> tags;

  @HiveField(13)
  final List<String> dietaryRestrictions;

  @HiveField(14)
  final double rating;

  @HiveField(15)
  final int ratingCount;

  @HiveField(16)
  final String authorId;

  @HiveField(17)
  final String authorName;

  @HiveField(18)
  final DateTime createdAt;

  @HiveField(19)
  final DateTime updatedAt;

  @HiveField(20)
  final String? videoUrl;

  @HiveField(21)
  final List<String> additionalImages;

  @HiveField(22)
  final String? chefTips;

  @HiveField(23)
  final String? culturalBackground;

  @HiveField(24)
  final String? nutritionInfo;

  @HiveField(25)
  final bool isVegetarian;

  @HiveField(26)
  final bool isVegan;

  @HiveField(27)
  final bool isGlutenFree;

  @HiveField(28)
  final bool isDairyFree;

  @HiveField(29)
  final int calories;

  @HiveField(30)
  final String spiceLevel; // mild, medium, hot, very hot

  const RecipeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.cuisine,
    required this.difficulty,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.ingredients,
    required this.instructions,
    required this.imageUrl,
    required this.tags,
    required this.dietaryRestrictions,
    required this.rating,
    required this.ratingCount,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.updatedAt,
    this.videoUrl,
    this.additionalImages = const [],
    this.chefTips,
    this.culturalBackground,
    this.nutritionInfo,
    this.isVegetarian = false,
    this.isVegan = false,
    this.isGlutenFree = false,
    this.isDairyFree = false,
    this.calories = 0,
    this.spiceLevel = 'medium',
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);

  // Helper methods
  int get totalTime => prepTime + cookTime;

  String get totalTimeString {
    final hours = totalTime ~/ 60;
    final minutes = totalTime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  String get prepTimeString {
    final hours = prepTime ~/ 60;
    final minutes = prepTime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  String get cookTimeString {
    final hours = cookTime ~/ 60;
    final minutes = cookTime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  String get servingsString {
    return servings == 1 ? '1 serving' : '$servings servings';
  }

  String get ratingString {
    return rating.toStringAsFixed(1);
  }

  bool get hasVideo => videoUrl != null && videoUrl!.isNotEmpty;

  bool get hasAdditionalImages => additionalImages.isNotEmpty;

  String get difficultyEmoji {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return '🟢';
      case 'medium':
        return '🟡';
      case 'hard':
        return '🔴';
      default:
        return '🟡';
    }
  }

  String get spiceLevelEmoji {
    switch (spiceLevel.toLowerCase()) {
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

  RecipeModel copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? cuisine,
    String? difficulty,
    int? prepTime,
    int? cookTime,
    int? servings,
    List<IngredientModel>? ingredients,
    List<InstructionModel>? instructions,
    String? imageUrl,
    List<String>? tags,
    List<String>? dietaryRestrictions,
    double? rating,
    int? ratingCount,
    String? authorId,
    String? authorName,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? videoUrl,
    List<String>? additionalImages,
    String? chefTips,
    String? culturalBackground,
    String? nutritionInfo,
    bool? isVegetarian,
    bool? isVegan,
    bool? isGlutenFree,
    bool? isDairyFree,
    int? calories,
    String? spiceLevel,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      cuisine: cuisine ?? this.cuisine,
      difficulty: difficulty ?? this.difficulty,
      prepTime: prepTime ?? this.prepTime,
      cookTime: cookTime ?? this.cookTime,
      servings: servings ?? this.servings,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags ?? this.tags,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      videoUrl: videoUrl ?? this.videoUrl,
      additionalImages: additionalImages ?? this.additionalImages,
      chefTips: chefTips ?? this.chefTips,
      culturalBackground: culturalBackground ?? this.culturalBackground,
      nutritionInfo: nutritionInfo ?? this.nutritionInfo,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isDairyFree: isDairyFree ?? this.isDairyFree,
      calories: calories ?? this.calories,
      spiceLevel: spiceLevel ?? this.spiceLevel,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RecipeModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'RecipeModel(id: $id, name: $name, category: $category)';
  }
}

@HiveType(typeId: 2)
@JsonSerializable()
class IngredientModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String quantity;

  @HiveField(2)
  final String unit;

  @HiveField(3)
  final String? notes;

  @HiveField(4)
  final bool isOptional;

  const IngredientModel({
    required this.name,
    required this.quantity,
    required this.unit,
    this.notes,
    this.isOptional = false,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientModelToJson(this);

  String get displayText {
    String result = '$quantity $unit $name';
    if (notes != null && notes!.isNotEmpty) {
      result += ' ($notes)';
    }
    if (isOptional) {
      result += ' (optional)';
    }
    return result;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IngredientModel &&
        other.name == name &&
        other.quantity == quantity &&
        other.unit == unit;
  }

  @override
  int get hashCode => name.hashCode ^ quantity.hashCode ^ unit.hashCode;

  @override
  String toString() {
    return 'IngredientModel(name: $name, quantity: $quantity, unit: $unit)';
  }
}

@HiveType(typeId: 3)
@JsonSerializable()
class InstructionModel {
  @HiveField(0)
  final int stepNumber;

  @HiveField(1)
  final String instruction;

  @HiveField(2)
  final int? timerMinutes;

  @HiveField(3)
  final String? imageUrl;

  @HiveField(4)
  final String? tip;

  const InstructionModel({
    required this.stepNumber,
    required this.instruction,
    this.timerMinutes,
    this.imageUrl,
    this.tip,
  });

  factory InstructionModel.fromJson(Map<String, dynamic> json) =>
      _$InstructionModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstructionModelToJson(this);

  bool get hasTimer => timerMinutes != null && timerMinutes! > 0;

  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  bool get hasTip => tip != null && tip!.isNotEmpty;

  String get timerString {
    if (!hasTimer) return '';
    final minutes = timerMinutes!;
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    if (hours > 0) {
      return '${hours}h ${remainingMinutes}m';
    }
    return '${remainingMinutes}m';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InstructionModel &&
        other.stepNumber == stepNumber &&
        other.instruction == instruction;
  }

  @override
  int get hashCode => stepNumber.hashCode ^ instruction.hashCode;

  @override
  String toString() {
    return 'InstructionModel(stepNumber: $stepNumber, instruction: $instruction)';
  }
}