import 'package:flutter/material.dart';
import 'package:q_bot/locator.dart';
import 'package:q_bot/ui/route_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initializing the Locators (GetIt)
  setupLocator();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'A Queue Management System of TMC developed by HSS',
      initialRoute: RouteNavigation.home,
      theme: ThemeData(fontFamily: 'VarelaRound'),
      onGenerateRoute: RouteNavigation.generateRoute,
    ),
  );
}
