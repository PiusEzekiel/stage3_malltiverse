import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stage2_product_app/screens/product_list_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Stage2 Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(255, 127, 125, 1),
          onPrimary: Colors.white,
          secondary: Color(0x2A2A2A),
          tertiary: Color.fromRGBO(42, 42, 42, 1),
        ),
      ),
      home: const ProductListScreen(),
    );
  }
}
