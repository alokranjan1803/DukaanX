import 'package:dukaanx/common/widgets/bottom_bar.dart';
import 'package:dukaanx/constraints/global_variables.dart';
import 'package:dukaanx/features/Auth/screens/auth_screen.dart';
import 'package:dukaanx/features/Auth/services/auth_service.dart';
import 'package:dukaanx/features/admin/screens/admin_screen.dart';
import 'package:dukaanx/providers/theme_provider.dart';
import 'package:dukaanx/providers/user_provider.dart';
import 'package:dukaanx/router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env"); // Load environment variables
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ScaffoldMessenger(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DukaanX',
        theme: themeProvider.isDarkTheme
            ? ThemeData.dark().copyWith(
                scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
                colorScheme: const ColorScheme.light(
                  primary: GlobalVariables.secondaryColor,
                ),
                appBarTheme: const AppBarTheme(
                  elevation: 0,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
              )
            : ThemeData.light().copyWith(
                scaffoldBackgroundColor: GlobalVariables.backgroundColor,
                colorScheme: const ColorScheme.light(
                  primary: GlobalVariables.secondaryColor,
                ),
                appBarTheme: const AppBarTheme(
                  elevation: 0,
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
              ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type == 'user'
                ? const BottomBar()
                : const AdminScren()
            : const AuthScreen(),
      ),
    );
  }
}
