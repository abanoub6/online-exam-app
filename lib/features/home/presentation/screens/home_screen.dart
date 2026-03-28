import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
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
      backgroundColor: Color(0xFFF9F9F9),
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() => currentIndex = index);
        },
        elevation: 0, // بيشيل الـ shadow
        backgroundColor: AppColors.lightBlue,
        indicatorColor: AppColors.blue10,
        destinations: const [
          NavigationDestination(
            icon: ImageIcon(
              AssetImage("assets/icons/explore_icon.png"),
              color: AppColors.blue,
            ),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: ImageIcon(
              AssetImage("assets/icons/results_icon.png"),
              color: AppColors.blue,
            ),
            label: 'Result',
          ),
          NavigationDestination(
            icon: ImageIcon(
              AssetImage("assets/icons/person_icon.png"),
              color: AppColors.blue,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
