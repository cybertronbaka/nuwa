part of 'app.dart';

abstract class NuwaTheme{
  static ThemeData data = ThemeData(
      fontFamily: 'Inter',
      primaryColor: NuwaColors.primary,
      useMaterial3: false,
      textTheme: const TextTheme().apply(
        fontFamily: 'Inter',
        bodyColor: NuwaColors.black
      ),
      iconTheme: const IconThemeData(
        color: NuwaColors.black
      ),
      scaffoldBackgroundColor: NuwaColors.bg,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 18
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          backgroundColor: NuwaColors.white,
          foregroundColor: NuwaColors.black,
        )
      ),
      filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
              textStyle: const TextStyle(
                fontFamily: 'Inter',
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