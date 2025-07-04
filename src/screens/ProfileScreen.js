import React from 'react';
import { 
  View, 
  Text, 
  StyleSheet, 
  ScrollView, 
  SafeAreaView, 
  StatusBar,
  TouchableOpacity,
  Linking,
  Alert
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { useApp } from '../context/AppContext';
import { recipes } from '../data/recipes';

const ProfileScreen = ({ navigation }) => {
  const { favorites } = useApp();

  const favoriteRecipes = recipes.filter(recipe => favorites.includes(recipe.id));
  const favoriteCategories = new Set(favoriteRecipes.map(r => r.category));
  const favoriteRegions = new Set(favoriteRecipes.map(r => r.region));

  const handleRateApp = () => {
    Alert.alert(
      'Rate Our App',
      'Thank you for using our app! Please rate us on the App Store.',
      [
        { text: 'Later', style: 'cancel' },
        { text: 'Rate Now', onPress: () => console.log('Rate app pressed') }
      ]
    );
  };

  const handleShare = () => {
    Alert.alert(
      'Share App',
      'Share this amazing Indian recipe app with your friends!',
      [
        { text: 'Cancel', style: 'cancel' },
        { text: 'Share', onPress: () => console.log('Share app pressed') }
      ]
    );
  };

  const handleFeedback = () => {
    Alert.alert(
      'Feedback',
      'We love to hear from you! Your feedback helps us improve.',
      [
        { text: 'Cancel', style: 'cancel' },
        { text: 'Send Feedback', onPress: () => console.log('Send feedback pressed') }
      ]
    );
  };

  const ProfileCard = ({ icon, title, subtitle, onPress, showArrow = true }) => (
    <TouchableOpacity style={styles.profileCard} onPress={onPress}>
      <View style={styles.profileCardLeft}>
        <View style={styles.profileCardIcon}>
          <Ionicons name={icon} size={24} color="#FF6B35" />
        </View>
        <View style={styles.profileCardContent}>
          <Text style={styles.profileCardTitle}>{title}</Text>
          <Text style={styles.profileCardSubtitle}>{subtitle}</Text>
        </View>
      </View>
      {showArrow && (
        <Ionicons name="chevron-forward" size={20} color="#999" />
      )}
    </TouchableOpacity>
  );

  const AchievementBadge = ({ icon, title, description, unlocked }) => (
    <View style={[styles.achievementBadge, !unlocked && styles.achievementBadgeLocked]}>
      <Text style={[styles.achievementIcon, !unlocked && styles.achievementIconLocked]}>
        {icon}
      </Text>
      <Text style={[styles.achievementTitle, !unlocked && styles.achievementTitleLocked]}>
        {title}
      </Text>
      <Text style={[styles.achievementDescription, !unlocked && styles.achievementDescriptionLocked]}>
        {description}
      </Text>
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
          <Text style={styles.headerTitle}>Profile</Text>
          <Text style={styles.headerSubtitle}>
            Your culinary journey
          </Text>
        </View>
        <Text style={styles.headerEmoji}>👨‍🍳</Text>
      </LinearGradient>

      <ScrollView style={styles.scrollView} showsVerticalScrollIndicator={false}>
        {/* Stats */}
        <View style={styles.statsContainer}>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{favoriteRecipes.length}</Text>
            <Text style={styles.statLabel}>Favorites</Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{favoriteCategories.size}</Text>
            <Text style={styles.statLabel}>Categories</Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{favoriteRegions.size}</Text>
            <Text style={styles.statLabel}>Regions</Text>
          </View>
        </View>

        {/* Achievements */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Achievements</Text>
          <View style={styles.achievementsContainer}>
            <AchievementBadge
              icon="🏆"
              title="Recipe Explorer"
              description="Saved your first recipe"
              unlocked={favoriteRecipes.length > 0}
            />
            <AchievementBadge
              icon="❤️"
              title="Recipe Lover"
              description="Saved 5 recipes"
              unlocked={favoriteRecipes.length >= 5}
            />
            <AchievementBadge
              icon="👑"
              title="Spice Master"
              description="Saved 10 recipes"
              unlocked={favoriteRecipes.length >= 10}
            />
            <AchievementBadge
              icon="🌟"
              title="Regional Expert"
              description="Saved recipes from 3 regions"
              unlocked={favoriteRegions.size >= 3}
            />
          </View>
        </View>

        {/* Profile Options */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>App</Text>
          <View style={styles.profileCards}>
            <ProfileCard
              icon="star"
              title="Rate Our App"
              subtitle="Love the app? Rate us!"
              onPress={handleRateApp}
            />
            <ProfileCard
              icon="share"
              title="Share App"
              subtitle="Tell your friends about us"
              onPress={handleShare}
            />
            <ProfileCard
              icon="chatbubble"
              title="Feedback"
              subtitle="Help us improve"
              onPress={handleFeedback}
            />
          </View>
        </View>

        {/* About */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>About</Text>
          <View style={styles.aboutContainer}>
            <Text style={styles.aboutTitle}>Authentic Indian Recipes</Text>
            <Text style={styles.aboutDescription}>
              Discover the rich flavors of India with our collection of traditional recipes. 
              Each recipe is carefully curated to bring you authentic taste and cooking techniques 
              passed down through generations.
            </Text>
            <Text style={styles.aboutVersion}>Version 1.0.0</Text>
          </View>
        </View>

        {/* Love Message */}
        <View style={styles.loveContainer}>
          <LinearGradient
            colors={['#E91E63', '#F06292']}
            style={styles.loveGradient}
            start={{ x: 0, y: 0 }}
            end={{ x: 1, y: 1 }}
          >
            <Text style={styles.loveIcon}>💕</Text>
            <Text style={styles.loveTitle}>Made with Love</Text>
            <Text style={styles.loveSubtitle}>
              This app was created especially for someone special - 
              to share the joy of cooking authentic Indian cuisine together.
            </Text>
          </LinearGradient>
        </View>
      </ScrollView>
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
  scrollView: {
    flex: 1,
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
  section: {
    marginTop: 30,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 16,
    paddingHorizontal: 20,
  },
  achievementsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
  },
  achievementBadge: {
    width: '48%',
    backgroundColor: 'white',
    padding: 16,
    borderRadius: 12,
    alignItems: 'center',
    marginBottom: 12,
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
  },
  achievementBadgeLocked: {
    backgroundColor: '#F5F5F5',
  },
  achievementIcon: {
    fontSize: 32,
    marginBottom: 8,
  },
  achievementIconLocked: {
    opacity: 0.3,
  },
  achievementTitle: {
    fontSize: 14,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 4,
    textAlign: 'center',
  },
  achievementTitleLocked: {
    color: '#999',
  },
  achievementDescription: {
    fontSize: 12,
    color: '#666',
    textAlign: 'center',
    lineHeight: 16,
  },
  achievementDescriptionLocked: {
    color: '#999',
  },
  profileCards: {
    paddingHorizontal: 16,
  },
  profileCard: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    backgroundColor: 'white',
    padding: 16,
    borderRadius: 12,
    marginBottom: 12,
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
  },
  profileCardLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
  },
  profileCardIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#FFF8F0',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  profileCardContent: {
    flex: 1,
  },
  profileCardTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 2,
  },
  profileCardSubtitle: {
    fontSize: 14,
    color: '#666',
  },
  aboutContainer: {
    backgroundColor: 'white',
    marginHorizontal: 16,
    padding: 20,
    borderRadius: 12,
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
  },
  aboutTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 12,
  },
  aboutDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 22,
    marginBottom: 16,
  },
  aboutVersion: {
    fontSize: 12,
    color: '#999',
    fontStyle: 'italic',
  },
  loveContainer: {
    margin: 16,
    marginTop: 30,
    marginBottom: 30,
    borderRadius: 16,
    overflow: 'hidden',
  },
  loveGradient: {
    padding: 24,
    alignItems: 'center',
  },
  loveIcon: {
    fontSize: 48,
    marginBottom: 12,
  },
  loveTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: 'white',
    marginBottom: 8,
    textShadowColor: 'rgba(0,0,0,0.3)',
    textShadowOffset: { width: 1, height: 1 },
    textShadowRadius: 2,
  },
  loveSubtitle: {
    fontSize: 14,
    color: 'rgba(255,255,255,0.9)',
    textAlign: 'center',
    lineHeight: 20,
    fontStyle: 'italic',
  },
});

export default ProfileScreen;