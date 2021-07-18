import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teleport_weather_bhargav/blocs/Cities/cities_bloc.dart';
import 'package:teleport_weather_bhargav/blocs/Settings/settings_bloc.dart';
import 'package:teleport_weather_bhargav/blocs/Splash/splash_bloc.dart';
import 'package:teleport_weather_bhargav/blocs/Theme/theme_bloc.dart';
import 'package:teleport_weather_bhargav/pages/current_weather_details.dart';
import 'package:teleport_weather_bhargav/pages/home.dart';
import 'package:teleport_weather_bhargav/pages/splash.dart';

import 'DB/weather_repository.dart';
import 'blocs/Dashboard/dashboard_bloc.dart';
import 'blocs/Home/home_bloc.dart';

void main() {
  //this line make sure all the required widgets are loaded before main application starts
  WidgetsFlutterBinding.ensureInitialized();

  //Initializing repository and carrying forward to avoid multiple instances of database
  WeatherRepository repository=WeatherRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (context) => SplashBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            repository: repository,
          ),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(
            repository: repository,
          ),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()..add(ThemeLoadStarted()),
          lazy: false,
        ),
        BlocProvider<CitiesBloc>(
          create: (context) => CitiesBloc(
            repository: repository,
          ),
        ),
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(
            repository: repository,
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Color primaryColor = Color(0xff2052cf);
  final Color secondaryColor = Color(0xff000000);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          themeMode: themeState.themeMode,
          //themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          theme: _buildLightTheme(context),
          darkTheme: _buildDarkTheme(context),
          initialRoute: '/',
          routes: {
            '/': (context) => SplashPage(),
            '/home': (context) => HomePage(),
            '/weather_details':(context) => CurrentWeatherDetailsPage()
          },
        );
      },
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(),
      },
    );
  }

  ThemeData _buildLightTheme(BuildContext context) {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      accentColorBrightness: Brightness.dark,
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      primaryColorDark: const Color(0xFF381D99),
      buttonColor: primaryColor,
      cardColor: Colors.white,
      accentColor: secondaryColor,
      scaffoldBackgroundColor: Color(0xffffffff),
      backgroundColor: Color(0xffF6F6F4),
      errorColor: const Color(0xFFDC3545),
      appBarTheme: AppBarTheme(
        color: primaryColor,
        shadowColor: Color(0xffCBBBF2),
        brightness: Brightness.light,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: Color(0xff303030),
          selectedLabelStyle: TextStyle(fontSize: 9,fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontSize: 9,fontWeight: FontWeight.w400)
      ),
    );
    return base;
  }

  ThemeData _buildDarkTheme(BuildContext context) {
    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      primary: Color(0xff0b3242),
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData(
      primarySwatch: Colors.blue,
      applyElevationOverlayColor: true,
      brightness: Brightness.dark,
      accentColorBrightness: Brightness.dark,
      colorScheme: colorScheme,
      primaryColor: Color(0xffB383E6),
      cardColor: Color(0xff46484F),
      primaryColorDark: const Color(0xFF381D99),
      primaryColorLight: secondaryColor,
      buttonColor: primaryColor,
      accentColor: secondaryColor,
      canvasColor: const Color(0xFF2A4058),
      scaffoldBackgroundColor: const Color(0xFF0F0E11),
      backgroundColor: const Color(0xFF0D1520),
      errorColor: const Color(0xFFff7f7f),
      appBarTheme: AppBarTheme(
        color: primaryColor,
        shadowColor: Color(0xffCBBBF2),
        brightness: Brightness.dark,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xff4a483e),
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xffA7A7A7),
          selectedLabelStyle: TextStyle(fontSize: 9,fontWeight: FontWeight.w600,color: Colors.white),
          unselectedLabelStyle: TextStyle(fontSize: 9,fontWeight: FontWeight.w400,color: Color(0xffA7A7A7))
      ),
    );
    return base;
  }
}
