import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createStackNavigator } from '@react-navigation/stack';
import { Ionicons } from '@expo/vector-icons';

import HomeScreen from '../screens/HomeScreen';
import SearchScreen from '../screens/SearchScreen';
import FavoritesScreen from '../screens/FavoritesScreen';
import ProfileScreen from '../screens/ProfileScreen';
import RecipeDetailScreen from '../screens/RecipeDetailScreen';

const Tab = createBottomTabNavigator();
const Stack = createStackNavigator();

const HomeStack = () => (
  <Stack.Navigator>
    <Stack.Screen 
      name="Home" 
      component={HomeScreen} 
      options={{ 
        headerShown: false 
      }} 
    />
    <Stack.Screen 
      name="RecipeDetail" 
      component={RecipeDetailScreen} 
      options={{ 
        headerStyle: { backgroundColor: '#FF6B35' },
        headerTintColor: 'white',
        headerTitleStyle: { fontWeight: 'bold' }
      }} 
    />
  </Stack.Navigator>
);

const SearchStack = () => (
  <Stack.Navigator>
    <Stack.Screen 
      name="Search" 
      component={SearchScreen} 
      options={{ 
        headerShown: false 
      }} 
    />
    <Stack.Screen 
      name="RecipeDetail" 
      component={RecipeDetailScreen} 
      options={{ 
        headerStyle: { backgroundColor: '#FF6B35' },
        headerTintColor: 'white',
        headerTitleStyle: { fontWeight: 'bold' }
      }} 
    />
  </Stack.Navigator>
);

const FavoritesStack = () => (
  <Stack.Navigator>
    <Stack.Screen 
      name="Favorites" 
      component={FavoritesScreen} 
      options={{ 
        headerShown: false 
      }} 
    />
    <Stack.Screen 
      name="RecipeDetail" 
      component={RecipeDetailScreen} 
      options={{ 
        headerStyle: { backgroundColor: '#FF6B35' },
        headerTintColor: 'white',
        headerTitleStyle: { fontWeight: 'bold' }
      }} 
    />
  </Stack.Navigator>
);

const AppNavigator = () => {
  return (
    <NavigationContainer>
      <Tab.Navigator
        screenOptions={({ route }) => ({
          tabBarIcon: ({ focused, color, size }) => {
            let iconName;

            if (route.name === 'HomeTab') {
              iconName = focused ? 'home' : 'home-outline';
            } else if (route.name === 'SearchTab') {
              iconName = focused ? 'search' : 'search-outline';
            } else if (route.name === 'FavoritesTab') {
              iconName = focused ? 'heart' : 'heart-outline';
            } else if (route.name === 'ProfileTab') {
              iconName = focused ? 'person' : 'person-outline';
            }

            return <Ionicons name={iconName} size={size} color={color} />;
          },
          tabBarActiveTintColor: '#FF6B35',
          tabBarInactiveTintColor: '#8E8E93',
          tabBarStyle: {
            backgroundColor: 'white',
            borderTopColor: '#E5E5E5',
            borderTopWidth: 1,
            paddingTop: 5,
            paddingBottom: 5,
            height: 60,
          },
          headerShown: false,
        })}
      >
        <Tab.Screen 
          name="HomeTab" 
          component={HomeStack} 
          options={{ 
            tabBarLabel: 'Home' 
          }} 
        />
        <Tab.Screen 
          name="SearchTab" 
          component={SearchStack} 
          options={{ 
            tabBarLabel: 'Search' 
          }} 
        />
        <Tab.Screen 
          name="FavoritesTab" 
          component={FavoritesStack} 
          options={{ 
            tabBarLabel: 'Favorites' 
          }} 
        />
        <Tab.Screen 
          name="ProfileTab" 
          component={ProfileScreen} 
          options={{ 
            tabBarLabel: 'Profile' 
          }} 
        />
      </Tab.Navigator>
    </NavigationContainer>
  );
};

export default AppNavigator;