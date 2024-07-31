import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'data/app_data.dart';
import 'utilities/utilities.dart';
import '../screens/screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Silvian Automobile PH',
      theme: AppData.lightTheme,
      darkTheme: AppData.darkTheme,
      themeMode: ThemeMode.light,
      scrollBehavior: WebScrollBehavior(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('fil'), // Filipino
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        'login': (context) => const LoginScreen(),
      },
    );
  }
}
