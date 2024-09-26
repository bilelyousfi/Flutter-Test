import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/apis/apis.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../helper/global.dart';
import '../helper/my_dialog.dart';

import '../widget/home_page_widget.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Apis homeAPIS = Get.put(Apis());
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  Widget _buildSearchScreen() {
    return SearchScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(appName, style: TextStyle(color: Colors.red)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => MyDialog.info("Coming Soon!"),
          icon: const Icon(Icons.menu, color: Colors.black),
        ),
        actions: <Widget>[
          if (_selectedIndex == 0)
            IconButton(
              onPressed: () {
                // Navigate to SearchScreen
                Get.to(() => SearchScreen(), transition: Transition.rightToLeft);
              },
              icon: const Icon(Icons.search, color: Colors.black),
            ),
        ],
      ),
      body: _selectedIndex == 0
          ? HomePageWidget(homeAPIS: homeAPIS, pageController: _pageController)
          : _buildSearchScreen(),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.red,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            selectedColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
