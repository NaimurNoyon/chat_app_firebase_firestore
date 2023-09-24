import 'package:chat_app/provider/firebase_provider.dart';
import 'package:chat_app/screens/auth/auth_page.dart';
import 'package:chat_app/screens/auth/verify_email_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get mainColor => null;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider(
        create: (_) => FirebaseProvider(),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    textStyle:
                    const TextStyle(fontSize: 20),
                    minimumSize: const Size.fromHeight(52),
                    backgroundColor: mainColor),
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              )),
          home: const MainPage(),
        ),
      );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const VerifyEmailPage();
        } else {
          return const AuthPage();
        }
      },
    ),
  );
}
