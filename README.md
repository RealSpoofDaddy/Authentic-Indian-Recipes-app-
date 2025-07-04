# 🍛 Authentic Indian Recipes App

A beautiful React Native mobile application featuring authentic Indian recipes for iOS and Android. This app was created with love to share the rich culinary traditions of India.

## 🌟 Features

- **🏠 Home Screen**: Welcome message with featured recipes and cooking tips
- **🔍 Search & Filter**: Advanced search with filters by category, region, and difficulty
- **❤️ Favorites**: Save your favorite recipes with persistent storage
- **👨‍🍳 Profile**: Personal stats, achievements, and app settings
- **📱 Recipe Details**: Step-by-step instructions with ingredients and chef's tips
- **🎨 Beautiful UI**: Indian-inspired design with gradient backgrounds and modern components
- **💾 Offline Support**: Local storage for favorites and app preferences

## 🍽️ Recipe Collection

The app includes authentic recipes from various Indian regions:

- **Main Courses**: Butter Chicken, Biryani, Rajma, Palak Paneer, Chole Bhature
- **Appetizers**: Samosa
- **Desserts**: Gulab Jamun
- **Breakfast**: Masala Dosa

Each recipe includes:
- Complete ingredient list
- Step-by-step cooking instructions
- Cooking time and difficulty level
- Serving information
- Chef's tips and tricks

## 🚀 Getting Started

### Prerequisites

- Node.js (v14 or higher)
- npm or yarn
- Expo CLI
- Expo Go app on your mobile device

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd IndianRecipeApp
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start the development server**
   ```bash
   npm start
   ```

4. **Run on your device**
   - Install Expo Go app on your iOS or Android device
   - Scan the QR code from the terminal or browser
   - The app will load on your device

### Alternative Running Methods

- **iOS Simulator**: `npm run ios` (requires Mac)
- **Android Emulator**: `npm run android`
- **Web Browser**: `npm run web`

## 📱 App Structure

```
IndianRecipeApp/
├── src/
│   ├── components/
│   │   └── RecipeCard.js          # Reusable recipe card component
│   ├── screens/
│   │   ├── HomeScreen.js          # Home screen with featured recipes
│   │   ├── SearchScreen.js        # Search and filter functionality
│   │   ├── FavoritesScreen.js     # User's favorite recipes
│   │   ├── ProfileScreen.js       # User profile and settings
│   │   └── RecipeDetailScreen.js  # Detailed recipe view
│   ├── navigation/
│   │   └── AppNavigator.js        # Navigation setup
│   ├── context/
│   │   └── AppContext.js          # Global state management
│   └── data/
│       └── recipes.js             # Recipe data and categories
├── assets/                        # Images and icons
├── App.js                         # Main app component
└── package.json                   # Dependencies and scripts
```

## 🎨 Design Features

- **Indian-inspired Color Palette**: Warm oranges, vibrant colors
- **Gradient Backgrounds**: Beautiful linear gradients for visual appeal
- **Modern UI Components**: Cards, buttons, and navigation with smooth animations
- **Responsive Design**: Works perfectly on both iOS and Android
- **Typography**: Clear, readable fonts with proper hierarchy

## 🔧 Technologies Used

- **React Native**: Cross-platform mobile development
- **Expo**: Development platform and tools
- **React Navigation**: Screen navigation and routing
- **AsyncStorage**: Local data persistence
- **Linear Gradient**: Beautiful background gradients
- **Vector Icons**: Comprehensive icon library

## 📋 App Screens

### 🏠 Home Screen
- Welcome message with app branding
- Quick stats showing total recipes, categories, and regions
- Featured recipes carousel
- Cooking tips section
- Call-to-action to browse all recipes

### 🔍 Search Screen
- Search bar with real-time filtering
- Advanced filters (category, region, difficulty)
- Results counter
- Empty state with helpful messaging

### ❤️ Favorites Screen
- List of saved favorite recipes
- Statistics about favorite recipes
- Empty state encouraging users to add favorites
- Quick access to browse more recipes

### 👨‍🍳 Profile Screen
- Personal cooking statistics
- Achievement badges (unlocked based on activity)
- App settings and options
- About section with app information
- Special "Made with Love" message

### 📱 Recipe Detail Screen
- Large recipe image with category-specific gradients
- Recipe information (time, servings, difficulty)
- Tabbed interface for ingredients, instructions, and tips
- Share functionality
- Add/remove from favorites

## 🎯 Features Roadmap

- [ ] Recipe rating system
- [ ] Shopping list generation
- [ ] Cooking timer integration
- [ ] Social sharing improvements
- [ ] Recipe video tutorials
- [ ] Nutritional information
- [ ] User-generated recipes

## 💝 Special Note

This app was created as a labor of love to share the beautiful traditions of Indian cuisine. It's designed to bring authentic flavors and cooking techniques to everyone who appreciates good food.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Traditional Indian recipes passed down through generations
- The vibrant Indian culinary community
- Open source community for amazing tools and libraries

---

**Made with ❤️ for food lovers everywhere**

Happy Cooking! 🍛✨