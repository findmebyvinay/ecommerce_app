
import 'package:ecom_app/features/products/presentation/screen/product_screen.dart';
import 'package:ecom_app/features/profilepage/presentation/screen/profile_page.dart';
import 'package:flutter/material.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex=0;
  late final List<Widget> _pages;
  @override
  void initState() {
    _pages=[ProductScreen(),ProfilePage(),];
    super.initState();
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(microseconds: 300),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }
  
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(),
      child: BottomNavigationBar(
        backgroundColor:  const Color.fromARGB(255, 5, 82, 9),
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() {
                _selectedIndex = index;
              }),
          selectedItemColor:Colors.white,
          unselectedItemColor: Colors.greenAccent,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
                         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Product'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Profile'),

            
          ]),
    );
  }
}
