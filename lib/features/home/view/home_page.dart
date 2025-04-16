import 'package:flutter/material.dart';
import 'package:pixelfield_project/features/my_collection/view/my_collection_page.dart';
import 'package:pixelfield_project/features/scan/view/scan_page.dart';
import 'package:pixelfield_project/features/settings/view/settings_page.dart';
import 'package:pixelfield_project/features/shop/shop.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Currently selected tab index for the BottomNavigationBar
  int _currentIndex = 1; // default to the "Collection" page
  // PageController to manage swipe behavior between pages
  final PageController _pageController = PageController(initialPage: 1);

  // When the user taps a bottom nav item, jump to that page
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF0E1C21);
    return Scaffold(
      // PageView allows for swiping between screens
      body: Container(
        color: backgroundColor,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            // Update the BottomNavigationBar when swiping
            setState(() {
              _currentIndex = index;
            });
          },
          children: const [
            ScanPage(),
            MyCollectionPage(),
            ShopPage(),
            SettingsPage(),
          ],
        ),
      ),
      // BottomNavigationBar to switch pages
      bottomNavigationBar: SizedBox(
        height: 110,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: _onItemTapped,
          type:
              BottomNavigationBarType
                  .fixed, // ensures all icons/labels are visible
          backgroundColor: const Color(0xFF0B1519),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Column(
                children: [Icon(Icons.view_in_ar), SizedBox(height: 8)],
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [Icon(Icons.grid_view), SizedBox(height: 8)],
              ),
              label: 'Collection',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [Icon(Icons.liquor_outlined), SizedBox(height: 8)],
              ),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [Icon(Icons.settings_outlined), SizedBox(height: 8)],
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
