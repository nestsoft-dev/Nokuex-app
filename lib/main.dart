import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nokuex/views/Auth/login/loginPage.dart';
import 'package:nokuex/views/intro/splashPage.dart';

import 'views/NavPage/NavPage.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nokuex',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff202428),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}


/*
echo "# Nokuex-app" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/nestsoft-dev/Nokuex-app.git
git push -u origin main
*/