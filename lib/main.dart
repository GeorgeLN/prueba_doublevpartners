import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:prueba_dvp/core/design/app_theme.dart';
import 'package:prueba_dvp/features/presentation/pages/home_page.dart';
import 'package:prueba_dvp/features/presentation/viewmodels/user_view_model.dart';
import 'package:prueba_dvp/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => UserViewModel()),
      ],
      child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prueba DVP',
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}