import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/features/explore/presentation/screens/explore_screen.dart';
import 'package:online_exam_app_v/features/profile/presentation/screens/profile_screen.dart';
import 'package:online_exam_app_v/features/results/presentation/screens/results_screen.dart'
    show ResultsScreen;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home';

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
      backgroundColor: Colors.white,
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() => currentIndex = index);
        },
        elevation: 0,
        backgroundColor: AppColors.lightBlue,
        indicatorColor: AppColors.blue10,
        destinations: const [
          NavigationDestination(
            icon: ImageIcon(
              AssetImage(AppStrings.iconHome),
              color: AppColors.blue,
            ),
            label: AppStrings.explore,
          ),
          NavigationDestination(
            icon: ImageIcon(
              AssetImage(AppStrings.iconResult),
              color: AppColors.blue,
            ),
            label: AppStrings.result,
          ),
          NavigationDestination(
            icon: ImageIcon(
              AssetImage(AppStrings.iconPerson),
              color: AppColors.blue,
            ),
            label: AppStrings.profile,
          ),
        ],
      ),
    );
  }
}
