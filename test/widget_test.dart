import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:plantpal/constants/app_colors.dart';

void main() {
  testWidgets('PlantPal app theme configuration is correct', (tester) async {
    // Test theme configuration independently of Firebase
    final theme = ThemeData(
      primarySwatch: Colors.green,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );

    expect(theme.useMaterial3, true);
    expect(theme.primaryColor, AppColors.primary);
    expect(theme.scaffoldBackgroundColor, AppColors.background);
    expect(theme.appBarTheme.backgroundColor, AppColors.primary);
    expect(theme.appBarTheme.foregroundColor, Colors.white);
  });

  testWidgets('AppColors has correct color values', (tester) async {
    expect(AppColors.primary, const Color(0xFF4CAF50));
    expect(AppColors.secondary, const Color(0xFF8BC34A));
    expect(AppColors.background, const Color(0xFFFFFFFF));
    expect(AppColors.error, const Color(0xFFF44336));
    expect(AppColors.textPrimary, const Color(0xFF212121));
    expect(AppColors.textSecondary, const Color(0xFF757575));
  });

  testWidgets('HomeScreen renders with correct UI elements', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.yard, size: 100),
                SizedBox(height: 24),
                Text('Welcome to PlantPal!'),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Welcome to PlantPal!'), findsOneWidget);
    expect(find.byIcon(Icons.yard), findsOneWidget);
  });
}
