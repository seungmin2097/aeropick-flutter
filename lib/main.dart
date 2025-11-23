import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/flight_provider.dart';
import 'providers/user_provider.dart';
import 'providers/reservation_provider.dart';
import 'providers/gacha_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/stamp_provider.dart';
import 'providers/checkin_provider.dart';
import 'theme/aerok_colors.dart';

void main() {
  runApp(const AirlineApp());
}

class AirlineApp extends StatelessWidget {
  const AirlineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FlightProvider()..initializeFlights()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ReservationProvider()),
        ChangeNotifierProvider(create: (_) => GachaProvider()..initializeItems()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => StampProvider()..initializeLocations()),
        ChangeNotifierProvider(create: (_) => CheckinProvider()),
      ],
      child: MaterialApp(
        title: 'Aero-K',
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0), // 텍스트 스케일링 고정
              boldText: false, // 볼드 텍스트 비활성화로 폰트 로딩 최적화
            ),
            child: DefaultTextStyle(
              style: const TextStyle(fontFamily: null), // 기본 폰트를 시스템 폰트로 강제
              child: child!,
            ),
          );
        },
        theme: ThemeData(
          primaryColor: AeroKColors.darkNavy,
          fontFamily: null, // 시스템 기본 폰트 사용
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontFamily: null),
            displayMedium: TextStyle(fontFamily: null),
            displaySmall: TextStyle(fontFamily: null),
            headlineLarge: TextStyle(fontFamily: null),
            headlineMedium: TextStyle(fontFamily: null),
            headlineSmall: TextStyle(fontFamily: null),
            titleLarge: TextStyle(fontFamily: null),
            titleMedium: TextStyle(fontFamily: null),
            titleSmall: TextStyle(fontFamily: null),
            bodyLarge: TextStyle(fontFamily: null),
            bodyMedium: TextStyle(fontFamily: null),
            bodySmall: TextStyle(fontFamily: null),
            labelLarge: TextStyle(fontFamily: null),
            labelMedium: TextStyle(fontFamily: null),
            labelSmall: TextStyle(fontFamily: null),
          ),
          colorScheme: ColorScheme.light(
            primary: AeroKColors.darkNavy,
            secondary: AeroKColors.yellow,
            surface: AeroKColors.white,
            background: AeroKColors.lightGray,
            onPrimary: AeroKColors.white,
            onSecondary: AeroKColors.darkNavy,
            onSurface: AeroKColors.darkNavy,
            onBackground: AeroKColors.darkNavy,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AeroKColors.darkNavy,
            foregroundColor: AeroKColors.white,
            elevation: 0,
            centerTitle: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AeroKColors.darkNavy,
              foregroundColor: AeroKColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AeroKColors.yellow,
            foregroundColor: AeroKColors.darkNavy,
          ),
          cardTheme: CardThemeData(
            color: AeroKColors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

