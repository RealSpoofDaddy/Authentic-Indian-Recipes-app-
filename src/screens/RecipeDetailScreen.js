import React, { useState } from 'react';
import { 
  View, 
  Text, 
  StyleSheet, 
  ScrollView, 
  TouchableOpacity, 
  SafeAreaView,
  StatusBar,
  Share,
  Alert
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { LinearGradient } from 'expo-linear-gradient';
import { useApp } from '../context/AppContext';

const RecipeDetailScreen = ({ route, navigation }) => {
  const { recipe } = route.params;
  const { toggleFavorite, isFavorite } = useApp();
  const [activeTab, setActiveTab] = useState('ingredients');

  const getDifficultyColor = (difficulty) => {
    switch (difficulty) {
      case 'Easy': return '#4CAF50';
      case 'Medium': return '#FF9800';
      case 'Hard': return '#F44336';
      default: return '#757575';
    }
  };

  const getGradientColors = (category) => {
    switch (category) {
      case 'Main Course': return ['#FF6B35', '#F7931E'];
      case 'Appetizer': return ['#FFB74D', '#FF8A65'];
      case 'Dessert': return ['#E91E63', '#F06292'];
      case 'Breakfast': return ['#4CAF50', '#66BB6A'];
      default: return ['#FF6B35', '#F7931E'];
    }
  };

  const handleShare = async () => {
    try {
      const result = await Share.share({
        message: `Check out this delicious ${recipe.name} recipe! 🍛\n\nIngredients:\n${recipe.ingredients.join('\n')}\n\nFrom: Authentic Indian Recipes App`,
        title: recipe.name,
      });
    } catch (error) {
      Alert.alert('Error', 'Could not share the recipe');
    }
  };

  const handleToggleFavorite = () => {
    toggleFavorite(recipe.id);
  };

  const TabButton = ({ label, isActive, onPress }) => (
    <TouchableOpacity
      style={[styles.tabButton, isActive && styles.tabButtonActive]}
      onPress={onPress}
    >
      <Text style={[styles.tabButtonText, isActive && styles.tabButtonTextActive]}>
        {label}
      </Text>
    </TouchableOpacity>
  );

  const renderIngredients = () => (
    <View style={styles.contentContainer}>
      <Text style={styles.sectionTitle}>Ingredients</Text>
      {recipe.ingredients.map((ingredient, index) => (
        <View key={index} style={styles.ingredientItem}>
          <View style={styles.ingredientBullet} />
          <Text style={styles.ingredientText}>{ingredient}</Text>
        </View>
      ))}
    </View>
  );

  const renderInstructions = () => (
    <View style={styles.contentContainer}>
      <Text style={styles.sectionTitle}>Instructions</Text>
      {recipe.instructions.map((instruction, index) => (
        <View key={index} style={styles.instructionItem}>
          <View style={styles.instructionNumber}>
            <Text style={styles.instructionNumberText}>{index + 1}</Text>
          </View>
          <Text style={styles.instructionText}>{instruction}</Text>
        </View>
      ))}
    </View>
  );

  const renderTips = () => (
    <View style={styles.contentContainer}>
      <Text style={styles.sectionTitle}>Chef's Tips</Text>
      <View style={styles.tipContainer}>
        <Ionicons name="bulb" size={24} color="#FF6B35" />
        <Text style={styles.tipText}>{recipe.tips}</Text>
      </View>
    </View>
  );

  React.useLayoutEffect(() => {
    navigation.setOptions({
      title: recipe.name,
      headerRight: () => (
        <View style={styles.headerButtons}>
          <TouchableOpacity onPress={handleShare} style={styles.headerButton}>
            <Ionicons name="share-outline" size={24} color="white" />
          </TouchableOpacity>
          <TouchableOpacity onPress={handleToggleFavorite} style={styles.headerButton}>
            <Ionicons 
              name={isFavorite(recipe.id) ? 'heart' : 'heart-outline'} 
              size={24} 
              color={isFavorite(recipe.id) ? '#FF4444' : 'white'} 
            />
          </TouchableOpacity>
        </View>
      ),
    });
  }, [navigation, recipe.name, isFavorite(recipe.id)]);

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar barStyle="light-content" backgroundColor="#FF6B35" />
      
      <ScrollView style={styles.scrollView} showsVerticalScrollIndicator={false}>
        {/* Hero Section */}
        <LinearGradient
          colors={getGradientColors(recipe.category)}
          style={styles.hero}
          start={{ x: 0, y: 0 }}
          end={{ x: 1, y: 1 }}
        >
          <Text style={styles.heroEmoji}>{recipe.image}</Text>
          <Text style={styles.heroTitle}>{recipe.name}</Text>
          <Text style={styles.heroRegion}>{recipe.region}</Text>
        </LinearGradient>

        {/* Recipe Info */}
        <View style={styles.infoContainer}>
          <View style={styles.infoCard}>
            <Ionicons name="time-outline" size={20} color="#FF6B35" />
            <Text style={styles.infoLabel}>Cook Time</Text>
            <Text style={styles.infoValue}>{recipe.cookingTime}</Text>
          </View>
          <View style={styles.infoCard}>
            <Ionicons name="people-outline" size={20} color="#FF6B35" />
            <Text style={styles.infoLabel}>Servings</Text>
            <Text style={styles.infoValue}>{recipe.servings}</Text>
          </View>
          <View style={styles.infoCard}>
            <Ionicons name="bar-chart-outline" size={20} color={getDifficultyColor(recipe.difficulty)} />
            <Text style={styles.infoLabel}>Difficulty</Text>
            <Text style={[styles.infoValue, { color: getDifficultyColor(recipe.difficulty) }]}>
              {recipe.difficulty}
            </Text>
          </View>
        </View>

        {/* Category Badge */}
        <View style={styles.categoryContainer}>
          <View style={styles.categoryBadge}>
            <Text style={styles.categoryText}>{recipe.category}</Text>
          </View>
        </View>

        {/* Tabs */}
        <View style={styles.tabContainer}>
          <TabButton
            label="Ingredients"
            isActive={activeTab === 'ingredients'}
            onPress={() => setActiveTab('ingredients')}
          />
          <TabButton
            label="Instructions"
            isActive={activeTab === 'instructions'}
            onPress={() => setActiveTab('instructions')}
          />
          <TabButton
            label="Tips"
            isActive={activeTab === 'tips'}
            onPress={() => setActiveTab('tips')}
          />
        </View>

        {/* Content */}
        {activeTab === 'ingredients' && renderIngredients()}
        {activeTab === 'instructions' && renderInstructions()}
        {activeTab === 'tips' && renderTips()}
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F8F9FA',
  },
  scrollView: {
    flex: 1,
  },
  headerButtons: {
    flexDirection: 'row',
    marginRight: 16,
  },
  headerButton: {
    marginLeft: 16,
  },
  hero: {
    padding: 30,
    alignItems: 'center',
    minHeight: 200,
    justifyContent: 'center',
  },
  heroEmoji: {
    fontSize: 80,
    marginBottom: 16,
    textShadowColor: 'rgba(0,0,0,0.3)',
    textShadowOffset: { width: 2, height: 2 },
    textShadowRadius: 4,
  },
  heroTitle: {
    fontSize: 28,
    fontWeight: 'bold',
    color: 'white',
    textAlign: 'center',
    marginBottom: 8,
    textShadowColor: 'rgba(0,0,0,0.3)',
    textShadowOffset: { width: 1, height: 1 },
    textShadowRadius: 2,
  },
  heroRegion: {
    fontSize: 16,
    color: 'rgba(255,255,255,0.9)',
    fontStyle: 'italic',
  },
  infoContainer: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    paddingHorizontal: 20,
    paddingVertical: 20,
    backgroundColor: 'white',
    marginHorizontal: 16,
    marginTop: -20,
    borderRadius: 12,
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  infoCard: {
    alignItems: 'center',
    flex: 1,
  },
  infoLabel: {
    fontSize: 12,
    color: '#666',
    marginTop: 4,
  },
  infoValue: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    marginTop: 2,
  },
  categoryContainer: {
    alignItems: 'center',
    marginVertical: 20,
  },
  categoryBadge: {
    backgroundColor: '#FF6B35',
    paddingHorizontal: 20,
    paddingVertical: 8,
    borderRadius: 20,
  },
  categoryText: {
    fontSize: 14,
    fontWeight: '600',
    color: 'white',
  },
  tabContainer: {
    flexDirection: 'row',
    backgroundColor: 'white',
    marginHorizontal: 16,
    borderRadius: 12,
    padding: 4,
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
  },
  tabButton: {
    flex: 1,
    paddingVertical: 12,
    alignItems: 'center',
    borderRadius: 8,
  },
  tabButtonActive: {
    backgroundColor: '#FF6B35',
  },
  tabButtonText: {
    fontSize: 14,
    fontWeight: '600',
    color: '#666',
  },
  tabButtonTextActive: {
    color: 'white',
  },
  contentContainer: {
    backgroundColor: 'white',
    margin: 16,
    borderRadius: 12,
    padding: 20,
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 16,
  },
  ingredientItem: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  ingredientBullet: {
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: '#FF6B35',
    marginRight: 12,
  },
  ingredientText: {
    fontSize: 16,
    color: '#333',
    flex: 1,
    lineHeight: 24,
  },
  instructionItem: {
    flexDirection: 'row',
    marginBottom: 16,
  },
  instructionNumber: {
    width: 28,
    height: 28,
    borderRadius: 14,
    backgroundColor: '#FF6B35',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
    marginTop: 2,
  },
  instructionNumberText: {
    fontSize: 14,
    fontWeight: 'bold',
    color: 'white',
  },
  instructionText: {
    fontSize: 16,
    color: '#333',
    flex: 1,
    lineHeight: 24,
  },
  tipContainer: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    backgroundColor: '#FFF8F0',
    padding: 16,
    borderRadius: 12,
    borderLeftWidth: 4,
    borderLeftColor: '#FF6B35',
  },
  tipText: {
    fontSize: 16,
    color: '#333',
    flex: 1,
    marginLeft: 12,
    lineHeight: 24,
    fontStyle: 'italic',
  },
});

export default RecipeDetailScreen;