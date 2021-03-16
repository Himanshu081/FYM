import 'package:flutter/material.dart';
import 'package:fym_test_1/composition_root.dart';
import 'package:fym_test_1/ui/auth/auth_page.dart';

void main() {
  CompositionRoot.configure();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fym Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CompositionRoot.composeAuthUi(),
    );
  }
}
