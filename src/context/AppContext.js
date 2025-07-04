import React, { createContext, useContext, useReducer, useEffect } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';

const AppContext = createContext();

const initialState = {
  favorites: [],
  searchQuery: '',
  selectedCategory: 'All',
  selectedRegion: 'All',
  selectedDifficulty: 'All',
  loading: false,
};

const appReducer = (state, action) => {
  switch (action.type) {
    case 'SET_FAVORITES':
      return { ...state, favorites: action.payload };
    case 'ADD_FAVORITE':
      return { ...state, favorites: [...state.favorites, action.payload] };
    case 'REMOVE_FAVORITE':
      return { ...state, favorites: state.favorites.filter(id => id !== action.payload) };
    case 'SET_SEARCH_QUERY':
      return { ...state, searchQuery: action.payload };
    case 'SET_SELECTED_CATEGORY':
      return { ...state, selectedCategory: action.payload };
    case 'SET_SELECTED_REGION':
      return { ...state, selectedRegion: action.payload };
    case 'SET_SELECTED_DIFFICULTY':
      return { ...state, selectedDifficulty: action.payload };
    case 'SET_LOADING':
      return { ...state, loading: action.payload };
    case 'RESET_FILTERS':
      return { 
        ...state, 
        searchQuery: '', 
        selectedCategory: 'All', 
        selectedRegion: 'All', 
        selectedDifficulty: 'All' 
      };
    default:
      return state;
  }
};

export const AppProvider = ({ children }) => {
  const [state, dispatch] = useReducer(appReducer, initialState);

  // Load favorites from AsyncStorage on app start
  useEffect(() => {
    loadFavorites();
  }, []);

  // Save favorites to AsyncStorage whenever favorites change
  useEffect(() => {
    saveFavorites();
  }, [state.favorites]);

  const loadFavorites = async () => {
    try {
      const favoritesJSON = await AsyncStorage.getItem('favorites');
      if (favoritesJSON) {
        const favorites = JSON.parse(favoritesJSON);
        dispatch({ type: 'SET_FAVORITES', payload: favorites });
      }
    } catch (error) {
      console.error('Error loading favorites:', error);
    }
  };

  const saveFavorites = async () => {
    try {
      await AsyncStorage.setItem('favorites', JSON.stringify(state.favorites));
    } catch (error) {
      console.error('Error saving favorites:', error);
    }
  };

  const addFavorite = (recipeId) => {
    dispatch({ type: 'ADD_FAVORITE', payload: recipeId });
  };

  const removeFavorite = (recipeId) => {
    dispatch({ type: 'REMOVE_FAVORITE', payload: recipeId });
  };

  const toggleFavorite = (recipeId) => {
    if (state.favorites.includes(recipeId)) {
      removeFavorite(recipeId);
    } else {
      addFavorite(recipeId);
    }
  };

  const isFavorite = (recipeId) => {
    return state.favorites.includes(recipeId);
  };

  const setSearchQuery = (query) => {
    dispatch({ type: 'SET_SEARCH_QUERY', payload: query });
  };

  const setSelectedCategory = (category) => {
    dispatch({ type: 'SET_SELECTED_CATEGORY', payload: category });
  };

  const setSelectedRegion = (region) => {
    dispatch({ type: 'SET_SELECTED_REGION', payload: region });
  };

  const setSelectedDifficulty = (difficulty) => {
    dispatch({ type: 'SET_SELECTED_DIFFICULTY', payload: difficulty });
  };

  const resetFilters = () => {
    dispatch({ type: 'RESET_FILTERS' });
  };

  const setLoading = (loading) => {
    dispatch({ type: 'SET_LOADING', payload: loading });
  };

  const value = {
    ...state,
    addFavorite,
    removeFavorite,
    toggleFavorite,
    isFavorite,
    setSearchQuery,
    setSelectedCategory,
    setSelectedRegion,
    setSelectedDifficulty,
    resetFilters,
    setLoading,
  };

  return (
    <AppContext.Provider value={value}>
      {children}
    </AppContext.Provider>
  );
};

export const useApp = () => {
  const context = useContext(AppContext);
  if (!context) {
    throw new Error('useApp must be used within an AppProvider');
  }
  return context;
};

export default AppContext;