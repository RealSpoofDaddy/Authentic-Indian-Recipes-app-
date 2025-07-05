import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette - Indian-inspired
  static const Color primaryColor = Color(0xFFFF6B35); // Saffron Orange
  static const Color secondaryColor = Color(0xFF138808); // Indian Green
  static const Color tertiaryColor = Color(0xFFFFD700); // Golden Yellow
  static const Color backgroundColor = Color(0xFFFFFBF0); // Cream White
  static const Color surfaceColor = Color(0xFFFFFFFF); // Pure White
  static const Color cardColor = Color(0xFFF8F4E6); // Light Cream
  static const Color errorColor = Color(0xFFDC3545); // Red
  static const Color successColor = Color(0xFF28A745); // Green
  static const Color warningColor = Color(0xFFFFC107); // Amber
  static const Color infoColor = Color(0xFF17A2B8); // Cyan
  
  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50); // Dark Blue Grey
  static const Color textSecondary = Color(0xFF7F8C8D); // Light Grey
  static const Color textLight = Color(0xFFBDC3C7); // Very Light Grey
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF6B35),
      Color(0xFFFF8F65),
    ],
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF138808),
      Color(0xFF4CAF50),
    ],
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFFBF0),
      Color(0xFFF8F4E6),
    ],
  );
  
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      surface: surfaceColor,
      onPrimary: textOnPrimary,
      onSecondary: textOnPrimary,
      onSurface: textPrimary,
      error: errorColor,
      onError: textOnPrimary,
    ),
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(
        color: textPrimary,
        size: 24,
      ),
    ),
    
    // Card Theme
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: textOnPrimary,
        elevation: 4,
        shadowColor: primaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: textLight.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: textLight.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: GoogleFonts.poppins(
        color: textSecondary,
        fontSize: 16,
      ),
      labelStyle: GoogleFonts.poppins(
        color: textSecondary,
        fontSize: 16,
      ),
    ),
    
    // Text Theme
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textPrimary,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textPrimary,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textSecondary,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondary,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textSecondary,
      ),
    ),
    
    // Icon Theme
    iconTheme: const IconThemeData(
      color: textPrimary,
      size: 24,
    ),
    
    // Divider Theme
    dividerTheme: DividerThemeData(
      color: textLight.withOpacity(0.3),
      thickness: 1,
    ),
    
    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: cardColor,
      selectedColor: primaryColor,
      labelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: textSecondary,
      selectedLabelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    
    // Tab Bar Theme
    tabBarTheme: TabBarTheme(
      labelColor: primaryColor,
      unselectedLabelColor: textSecondary,
      labelStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: primaryColor, width: 3),
        insets: const EdgeInsets.symmetric(horizontal: 16),
      ),
    ),
  );
  
  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      surface: Color(0xFF2C2C2C),
      onPrimary: textOnPrimary,
      onSecondary: textOnPrimary,
      onSurface: Color(0xFFE0E0E0),
      error: errorColor,
      onError: textOnPrimary,
    ),
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 24,
      ),
    ),
    
    // Card Theme
    cardTheme: CardTheme(
      color: const Color(0xFF2C2C2C),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    // Text Theme for Dark Mode
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: const Color(0xFFB0B0B0),
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFB0B0B0),
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFB0B0B0),
      ),
    ),
  );
}