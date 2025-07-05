import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../providers/app_providers.dart';
import 'login_screen.dart';
import '../home/main_navigation.dart';
import '../../../core/theme/app_theme.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return authState.when(
      data: (User? user) {
        if (user == null) {
          return const LoginScreen();
        } else {
          return const MainNavigation();
        }
      },
      loading: () => const AuthLoadingScreen(),
      error: (error, stackTrace) => AuthErrorScreen(error: error.toString()),
    );
  }
}

class AuthLoadingScreen extends StatelessWidget {
  const AuthLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Icon(
                Icons.restaurant_menu,
                size: 80,
                color: AppTheme.primaryColor,
              ),
              SizedBox(height: 24),
              Text(
                'Kashish\'s Kitchen',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Authentic Indian Recipes',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
              SizedBox(height: 16),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthErrorScreen extends StatelessWidget {
  final String error;
  
  const AuthErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 80,
                  color: AppTheme.errorColor,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Authentication Error',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // Restart the app or try again
                    // You can implement a retry mechanism here
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}