import 'package:flutter/material.dart';

import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import 'pages/catlogscreen.dart';
import 'pages/homescreen.dart';

import 'pages/trending.dart';
import 'pages/userpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black12,
      ),
      debugShowCheckedModeBanner: false,
      home: Metz_wallpaper(),
    );
  }
}

class Metz_wallpaper extends StatefulWidget {
  @override
  State<Metz_wallpaper> createState() => _Metz_wallpaperState();
}

class _Metz_wallpaperState extends State<Metz_wallpaper> {
  int selectedIndex = 0;

  @override
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    homescreen(),
    catlogscreen(),
    trending(),
    userpage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[selectedIndex],
      bottomNavigationBar: WaterDropNavBar(
          waterDropColor: Colors.deepPurpleAccent,
          backgroundColor: Colors.black12,
          barItems: [
            BarItem(
              filledIcon: Icons.home_rounded,
              outlinedIcon: Icons.home_outlined,
            ),
            BarItem(
                filledIcon: Icons.amp_stories_rounded,
                outlinedIcon: Icons.amp_stories_outlined),
            BarItem(
              filledIcon: Icons.local_fire_department_rounded,
              outlinedIcon: Icons.local_fire_department_outlined,
            ),
            BarItem(
                filledIcon: Icons.account_circle_rounded,
                outlinedIcon: Icons.account_circle_outlined),
          ],
          selectedIndex: selectedIndex,
          onItemSelected: onItemTapped),
    );
  }
}
