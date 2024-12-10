part of 'app.dart';

abstract class NuwaTheme{
  static ThemeData data = ThemeData(
      fontFamily: 'Inter',
      primaryColor: NuwaColors.primary,
      useMaterial3: false,
      filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 58),
              backgroundColor: NuwaColors.primary,
              disabledBackgroundColor: NuwaColors.primary.withOpacity(0.5),
              foregroundColor: NuwaColors.black,
              disabledForegroundColor: NuwaColors.white
          )
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: NuwaColors.black
      )
  );
}