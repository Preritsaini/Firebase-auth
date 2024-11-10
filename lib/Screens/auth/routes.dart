// app_pages.dart
import 'package:authenticate/Screens/pages/home.dart';
import 'package:authenticate/Screens/auth/login.dart';
import 'package:authenticate/Screens/pages/newpage.dart';
import 'package:authenticate/main.dart';
import 'package:get/get.dart';


class AppPages {
  final List<GetPage> pages = [
    GetPage(name: '/', page: () => NewPage()),
    GetPage(name: '/second', page: () => LoginScreen()),
    GetPage(name: '/third', page: () => HomeScreen()),
    GetPage(name: "/fourth", page: () => MyHomePage(title: 's')),
  ];
}
