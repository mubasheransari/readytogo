import 'package:flutter/material.dart';
import 'package:readytogo/Features/profile_screen.dart';
import 'package:readytogo/Features/Resources/resources_screen.dart';
import 'package:readytogo/Features/search_screen.dart'; // This is FindProvidersScreen
import 'mygeo_screen.dart';
import 'navdrawer.dart';

final Key mapKey = UniqueKey();

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;

    final List<Widget> _screens = [
    const MyGeoScreen(),
    ResourcesScreen(),
    FindProvidersScreen(
    ),
    const ProfileScreen(),
  ];

  // final List<Widget> _screens = const [
  //   MyGeoScreen(),
  //    ResourcesScreen(),
  //   FindProvidersScreen(),
  //   ProfileScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBarExact(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

/*class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1; // Default to Resources tab

  // List of screens shown on tabs
  final List<Widget> _screens = [
    const MyGeoScreen(),
    ResourcesScreen()
    FindProvidersScreen(
      key: mapKey,
    ),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_currentIndex], // Show screen based on index
      bottomNavigationBar: BottomNavBarExact(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update selected index
          });
        },
      ),
      // drawer: CustomNavDrawer(),
    );
  }
}*/

class BottomNavBarExact extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBarExact({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  static const List<_NavItem> _items = [
    _NavItem('My Geo', "assets/globe-04.png"),
    _NavItem('Resources', "assets/bookbottomNavbar1.png"),
    _NavItem('Search', "assets/search.png"),
    _NavItem('Profile', "assets/user.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        height: 90,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (index) {
            final isSelected = index == currentIndex;
            final item = _items[index];
            final color =
                isSelected ? const Color(0xFF3B68FF) : const Color(0xFF47474F);

            return GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item.imageicon,
                    width: 27,
                    height: 27,
                    color: color,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: color,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isSelected)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3B68FF),
                        shape: BoxShape.circle,
                      ),
                    )
                  else
                    const SizedBox(height: 6),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String imageicon;
  const _NavItem(this.label, this.imageicon);
}
