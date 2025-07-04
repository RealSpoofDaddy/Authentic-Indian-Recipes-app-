import React from 'react';
import { 
  View, 
  Text, 
  StyleSheet, 
  FlatList, 
  SafeAreaView, 
  StatusBar,
  TouchableOpacity
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import RecipeCard from '../components/RecipeCard';
import { useApp } from '../context/AppContext';
import { recipes } from '../data/recipes';

const FavoritesScreen = ({ navigation }) => {
  const { favorites, toggleFavorite, isFavorite } = useApp();

  // Get favorite recipes
  const favoriteRecipes = recipes.filter(recipe => favorites.includes(recipe.id));

  const handleRecipePress = (recipe) => {
    navigation.navigate('RecipeDetail', { recipe });
  };

  const handleToggleFavorite = (recipeId) => {
    toggleFavorite(recipeId);
  };

  const handleBrowseRecipes = () => {
    navigation.navigate('SearchTab');
  };

  const renderRecipeItem = ({ item }) => (
    <RecipeCard
      recipe={item}
      onPress={() => handleRecipePress(item)}
      isFavorite={isFavorite(item.id)}
      onToggleFavorite={() => handleToggleFavorite(item.id)}
    />
  );

  const renderEmptyState = () => (
    <View style={styles.emptyContainer}>
      <LinearGradient
        colors={['#FF6B35', '#F7931E']}
        style={styles.emptyGradient}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
      >
        <Text style={styles.emptyIcon}>💖</Text>
        <Text style={styles.emptyTitle}>No Favorites Yet</Text>
        <Text style={styles.emptySubtitle}>
          Start adding recipes to your favorites by tapping the heart icon
        </Text>
        <TouchableOpacity style={styles.emptyButton} onPress={handleBrowseRecipes}>
          <Text style={styles.emptyButtonText}>Browse Recipes</Text>
          <Ionicons name="arrow-forward" size={16} color="#FF6B35" />
        </TouchableOpacity>
      </LinearGradient>
    </View>
  );

  const renderStats = () => (
    <View style={styles.statsContainer}>
      <View style={styles.statCard}>
        <Text style={styles.statNumber}>{favoriteRecipes.length}</Text>
        <Text style={styles.statLabel}>Favorite{favoriteRecipes.length !== 1 ? 's' : ''}</Text>
      </View>
      <View style={styles.statCard}>
        <Text style={styles.statNumber}>
          {new Set(favoriteRecipes.map(r => r.category)).size}
        </Text>
        <Text style={styles.statLabel}>Categories</Text>
      </View>
      <View style={styles.statCard}>
        <Text style={styles.statNumber}>
          {new Set(favoriteRecipes.map(r => r.region)).size}
        </Text>
        <Text style={styles.statLabel}>Regions</Text>
      </View>
    </View>
  );

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar barStyle="light-content" backgroundColor="#FF6B35" />
      
      {/* Header */}
      <LinearGradient
        colors={['#FF6B35', '#F7931E']}
        style={styles.header}
      >
        <View style={styles.headerContent}>
          <Text style={styles.headerTitle}>My Favorites</Text>
          <Text style={styles.headerSubtitle}>
            Your collection of beloved recipes
          </Text>
        </View>
        <Text style={styles.headerEmoji}>❤️</Text>
      </LinearGradient>

      {favoriteRecipes.length > 0 ? (
        <>
          {/* Stats */}
          {renderStats()}
          
          {/* Recipes List */}
          <FlatList
            data={favoriteRecipes}
            renderItem={renderRecipeItem}
            keyExtractor={(item) => item.id.toString()}
            showsVerticalScrollIndicator={false}
            contentContainerStyle={styles.recipesList}
            ListHeaderComponent={
              <View style={styles.listHeader}>
                <Text style={styles.listHeaderText}>
                  {favoriteRecipes.length} favorite {favoriteRecipes.length === 1 ? 'recipe' : 'recipes'}
                </Text>
              </View>
            }
          />
        </>
      ) : (
        renderEmptyState()
      )}
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F8F9FA',
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingTop: 20,
    paddingBottom: 30,
    paddingHorizontal: 20,
  },
  headerContent: {
    flex: 1,
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: 'white',
    marginBottom: 4,
  },
  headerSubtitle: {
    fontSize: 14,
    color: 'rgba(255,255,255,0.8)',
    fontStyle: 'italic',
  },
  headerEmoji: {
    fontSize: 40,
    marginLeft: 20,
  },
  statsContainer: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    paddingHorizontal: 20,
    paddingVertical: 20,
    backgroundColor: 'white',
    marginHorizontal: 16,
    marginTop: -15,
    borderRadius: 12,
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  statCard: {
    alignItems: 'center',
    flex: 1,
  },
  statNumber: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#FF6B35',
  },
  statLabel: {
    fontSize: 12,
    color: '#666',
    marginTop: 4,
  },
  listHeader: {
    paddingHorizontal: 20,
    paddingVertical: 16,
  },
  listHeaderText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
  },
  recipesList: {
    paddingBottom: 20,
  },
  emptyContainer: {
    flex: 1,
    margin: 20,
    marginTop: -15,
    borderRadius: 16,
    overflow: 'hidden',
  },
  emptyGradient: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40,
    minHeight: 400,
  },
  emptyIcon: {
    fontSize: 64,
    marginBottom: 20,
    textShadowColor: 'rgba(0,0,0,0.3)',
    textShadowOffset: { width: 2, height: 2 },
    textShadowRadius: 4,
  },
  emptyTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: 'white',
    marginBottom: 12,
    textAlign: 'center',
    textShadowColor: 'rgba(0,0,0,0.3)',
    textShadowOffset: { width: 1, height: 1 },
    textShadowRadius: 2,
  },
  emptySubtitle: {
    fontSize: 16,
    color: 'rgba(255,255,255,0.9)',
    textAlign: 'center',
    lineHeight: 24,
    marginBottom: 30,
    paddingHorizontal: 20,
  },
  emptyButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'white',
    paddingHorizontal: 24,
    paddingVertical: 12,
    borderRadius: 25,
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
  },
  emptyButtonText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#FF6B35',
    marginRight: 8,
  },
});

export default FavoritesScreen;