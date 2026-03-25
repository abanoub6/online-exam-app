import 'package:flutter/material.dart';
import 'package:online_exam_app_v/features/explore/presentation/screens/explore_screen.dart';
import 'package:online_exam_app_v/features/profile/presentation/screens/profile_screen.dart';
import 'package:online_exam_app_v/features/results/presentation/screens/results_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "routeName";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    ExploreScreen(),
    ResultsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/explore_icon.png")),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/results_icon.png")),
            label: 'Results',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
