import 'package:flutter/material.dart';
import 'package:fym_test_1/composition_root.dart';
// import 'package:fym_test_1/ui/auth/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CompositionRoot.configure();
  final screentoshow = await CompositionRoot.start();
  runApp(MyApp(screentoshow));
}

class MyApp extends StatelessWidget {
  final Widget startpage;

  MyApp(this.startpage);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fym Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: startpage,
    );
  }
}
