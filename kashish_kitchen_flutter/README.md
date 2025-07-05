# 🍛 Kashish's Kitchen - Authentic Indian Recipes

A beautiful, cross-platform mobile application built with Flutter featuring authentic Indian cuisine recipes. The app provides a comprehensive cooking experience with detailed recipes, cooking timers, offline support, and a user-friendly interface.

![Flutter](https://img.shields.io/badge/Flutter-3.24.3-blue.svg)
![Firebase](https://img.shields.io/badge/Firebase-Latest-orange.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## ✨ Features

### 🏠 Core Features
- **Beautiful UI**: Indian-inspired design with Material Design 3
- **Authentic Recipes**: Traditional Indian recipes from various regions
- **Category Browsing**: Explore recipes by North Indian, South Indian, Bengali, etc.
- **Advanced Search**: Search by dish name, ingredients, or tags
- **Cooking Timers**: Built-in timers for time-sensitive cooking steps
- **Favorites**: Save and organize your favorite recipes
- **Offline Support**: Local caching with Hive for offline browsing

### 🔥 Advanced Features
- **Firebase Integration**: Real-time data synchronization
- **User Authentication**: Google Sign-In and email authentication
- **Recipe Details**: Step-by-step instructions with images
- **Cultural Background**: Learn about the history of each dish
- **Chef's Tips**: Professional cooking advice for each recipe
- **Nutritional Info**: Calorie and dietary information
- **Push Notifications**: Cooking timer alerts
- **Responsive Design**: Works beautifully on all screen sizes

### 👨‍🍳 User Experience
- **Progressive Loading**: Shimmer effects and smooth animations
- **State Management**: Efficient state handling with Riverpod
- **Error Handling**: Graceful error states and offline fallbacks
- **Performance**: Optimized for smooth scrolling and navigation
- **Accessibility**: Screen reader support and proper contrast ratios

## 🏗️ Architecture

### Clean Architecture Structure
```
lib/
├── core/
│   ├── constants/           # App constants and configuration
│   ├── theme/              # App theming and colors
│   ├── utils/              # Utility functions
│   └── exceptions/         # Custom exceptions
├── data/
│   ├── models/             # Data models with Hive adapters
│   ├── repositories/       # Data repositories
│   └── services/           # External services (Firebase, Cache, etc.)
├── domain/
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces
│   └── usecases/          # Business logic use cases
└── presentation/
    ├── screens/            # UI screens
    ├── widgets/            # Reusable UI components
    └── providers/          # Riverpod state providers
```

### Key Dependencies
- **State Management**: `flutter_riverpod` for reactive state management
- **Local Storage**: `hive` for offline data persistence
- **Backend**: Firebase (Auth, Firestore, Storage, Analytics)
- **Navigation**: `go_router` for declarative routing
- **UI Components**: `cached_network_image`, `shimmer`, `flutter_staggered_animations`
- **Notifications**: `flutter_local_notifications` for cooking timers
- **Authentication**: `google_sign_in` for social authentication

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.24.3 or later)
- Dart SDK (3.4.3 or later)
- Android Studio or VS Code
- Git

### Development Setup

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd kashish_kitchen_flutter
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   ```bash
   # Install Firebase CLI
   npm install -g firebase-tools
   
   # Login to Firebase
   firebase login
   
   # Initialize Firebase project
   firebase init
   
   # Generate Firebase configuration
   flutterfire configure
   ```

4. **Generate Code**
   ```bash
   # Generate model classes and adapters
   flutter packages pub run build_runner build
   ```

5. **Run the App**
   ```bash
   # Debug mode
   flutter run
   
   # Release mode
   flutter run --release
   ```

## 📱 Platform Setup

### Android Setup

#### Prerequisites
- Android Studio with latest SDK
- Java Development Kit (JDK) 11 or later
- Android SDK (API level 21 or higher)

#### Configuration
1. **Update `android/app/build.gradle`**
   ```gradle
   android {
       compileSdkVersion 34
       
       defaultConfig {
           minSdkVersion 21
           targetSdkVersion 34
           versionCode 1
           versionName "1.0.0"
       }
   }
   ```

2. **Add Permissions in `android/app/src/main/AndroidManifest.xml`**
   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.WAKE_LOCK" />
   <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
   <uses-permission android:name="android.permission.VIBRATE" />
   ```

3. **Build APK**
   ```bash
   # Debug APK
   flutter build apk
   
   # Release APK
   flutter build apk --release
   
   # Split APKs by architecture
   flutter build apk --split-per-abi
   ```

4. **Build App Bundle (for Play Store)**
   ```bash
   flutter build appbundle --release
   ```

#### Signing for Release
1. **Create Keystore**
   ```bash
   keytool -genkey -v -keystore ~/kashish-kitchen-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias kashish-kitchen
   ```

2. **Create `android/key.properties`**
   ```properties
   storePassword=your_store_password
   keyPassword=your_key_password
   keyAlias=kashish-kitchen
   storeFile=/path/to/kashish-kitchen-key.jks
   ```

3. **Update `android/app/build.gradle`**
   ```gradle
   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }
   
   android {
       signingConfigs {
           release {
               keyAlias keystoreProperties['keyAlias']
               keyPassword keystoreProperties['keyPassword']
               storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
               storePassword keystoreProperties['storePassword']
           }
       }
       buildTypes {
           release {
               signingConfig signingConfigs.release
           }
       }
   }
   ```

### iOS Setup

#### Prerequisites
- macOS with Xcode 14.0 or later
- iOS SDK 12.0 or later
- Apple Developer Account (for App Store deployment)
- CocoaPods

#### Configuration
1. **Install CocoaPods**
   ```bash
   sudo gem install cocoapods
   ```

2. **Navigate to iOS Directory**
   ```bash
   cd ios
   pod install
   cd ..
   ```

3. **Update `ios/Runner/Info.plist`**
   ```xml
   <key>NSAppTransportSecurity</key>
   <dict>
       <key>NSAllowsArbitraryLoads</key>
       <true/>
   </dict>
   ```

4. **Build for iOS**
   ```bash
   # Debug build
   flutter build ios
   
   # Release build
   flutter build ios --release
   ```

#### Xcode Configuration
1. **Open in Xcode**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Configure Signing & Capabilities**
   - Select your development team
   - Update bundle identifier
   - Enable required capabilities (Push Notifications, etc.)

3. **Build for Device**
   - Select your device or simulator
   - Product → Build
   - Product → Archive (for App Store)

#### App Store Deployment
1. **Archive the App**
   - In Xcode: Product → Archive
   - Organizer opens automatically

2. **Upload to App Store Connect**
   - Click "Distribute App"
   - Choose "App Store Connect"
   - Follow the upload process

## ☁️ Cloud Mac Solutions (For iOS Development)

If you don't have a Mac, here are cloud-based solutions:

### 1. MacStadium
- Dedicated Mac hardware in the cloud
- Full macOS environment with Xcode
- Pricing: ~$79/month for Mac mini

### 2. AWS EC2 Mac Instances
- Apple Mac mini instances on AWS
- Pay-per-hour pricing
- Requires AWS account setup

### 3. MacInCloud
- Managed Mac hosting service
- Pre-configured Xcode environments
- Plans starting from $20/month

### 4. Codemagic CI/CD
- Cloud-based CI/CD for Flutter
- Automated iOS builds without Mac
- Free tier available

### 5. GitHub Actions with macOS Runners
- Use GitHub Actions for iOS builds
- macOS runners included in GitHub plans
- Automated deployment workflows

### Setup Example for Cloud Mac:
```bash
# Connect via VNC or SSH
# Install Flutter
git clone https://github.com/flutter/flutter.git
export PATH="$PATH:`pwd`/flutter/bin"

# Clone your project
git clone <your-project-url>
cd kashish_kitchen_flutter

# Setup and build
flutter pub get
flutter build ios --release
```

## 🧪 Testing

### Unit Testing
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

### Integration Testing
```bash
# Run integration tests
flutter drive --target=test_driver/app.dart
```

### Device Testing

#### Android Testing
- **Android Emulator**: Built into Android Studio
- **Firebase Test Lab**: Cloud-based testing on real devices
- **Physical Device**: Enable USB debugging

#### iOS Testing
- **iOS Simulator**: Included with Xcode
- **TestFlight**: Beta testing platform
- **Physical Device**: Requires developer account

## 🔧 Performance Optimization

### Best Practices Implemented
1. **Efficient State Management**: Riverpod for granular updates
2. **Image Optimization**: `cached_network_image` with compression
3. **Lazy Loading**: ListView.builder for large lists
4. **Offline-First**: Hive caching for better performance
5. **Tree Shaking**: Optimized builds remove unused code
6. **Code Splitting**: Modular architecture for better maintainability

### Performance Monitoring
```bash
# Analyze app size
flutter build apk --analyze-size

# Profile performance
flutter run --profile
```

## 🔐 Security & Privacy

### Implemented Security Measures
- **Firebase Security Rules**: Protect user data
- **Input Validation**: Prevent injection attacks
- **HTTPS Only**: All network requests use SSL
- **Authentication**: Secure user authentication
- **Data Encryption**: Local data encrypted with Hive

### Privacy Compliance
- **GDPR Compliant**: User data handling
- **Privacy Policy**: Required for app stores
- **User Consent**: Clear permission requests

## 📦 Build Automation

### GitHub Actions Example
```yaml
name: Build and Test
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test
      
  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter build apk --release
      
  build-ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter build ios --release --no-codesign
```

## 🎨 Design System

### Color Palette
- **Primary**: Saffron Orange (#FF6B35)
- **Secondary**: Indian Green (#138808)
- **Tertiary**: Golden Yellow (#FFD700)
- **Background**: Cream White (#FFFBF0)
- **Surface**: Pure White (#FFFFFF)

### Typography
- **Font Family**: Google Fonts Poppins
- **Heading**: Bold weights for titles
- **Body**: Regular weight for content
- **Caption**: Light weight for secondary text

## 📋 Deployment Checklist

### Pre-Deployment
- [ ] Update version number in `pubspec.yaml`
- [ ] Update Firebase configuration
- [ ] Test on multiple devices/simulators
- [ ] Run automated tests
- [ ] Check app permissions
- [ ] Verify offline functionality
- [ ] Test push notifications
- [ ] Review security rules

### Android Deployment
- [ ] Generate signed APK/AAB
- [ ] Test on different Android versions
- [ ] Optimize app size
- [ ] Create store listing
- [ ] Upload to Play Console

### iOS Deployment
- [ ] Archive in Xcode
- [ ] Test on different iOS versions
- [ ] Submit for App Store review
- [ ] Create App Store listing
- [ ] Configure TestFlight beta

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

### Code Style
- Follow Dart/Flutter style guide
- Use meaningful variable names
- Add comments for complex logic
- Write tests for new features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team**: For the amazing framework
- **Firebase**: For backend services
- **Indian Cuisine**: For inspiring this beautiful app
- **Open Source Community**: For excellent packages

## 📞 Support

- **Documentation**: Check this README first
- **Issues**: Create GitHub issues for bugs
- **Discussions**: Use GitHub Discussions for questions
- **Email**: support@kashishkitchen.com

## 🗺️ Roadmap

### Version 1.1
- [ ] Video tutorials for recipes
- [ ] Shopping list generation
- [ ] Recipe rating system
- [ ] Social sharing improvements

### Version 1.2
- [ ] User-generated recipes
- [ ] Recipe challenges/contests
- [ ] Advanced meal planning
- [ ] Nutritional tracking

### Version 2.0
- [ ] AI-powered recipe suggestions
- [ ] Voice-guided cooking
- [ ] AR ingredient recognition
- [ ] Multi-language support

---

**Made with ❤️ for food lovers everywhere**

Happy Cooking! 🍛✨
