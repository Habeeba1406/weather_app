import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/services/location_provider.dart';
import 'package:weather_app/services/weather_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent, elevation: 0),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
