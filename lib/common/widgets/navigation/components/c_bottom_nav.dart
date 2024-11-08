import 'package:bloc_clean_arch/core/constants/app_colors.dart';
import 'package:flutter/material.dart';


/**
 * when widget screens are complex consider
 * 
 * lazy loading - rather than building all screens once e.g using IndexedStack
 * state mngt to handle states outside widget tree making widgets stateless and reduce rebuilds
 * 
 * 
 * *** persisting states while switching between tabs
 */

class CBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const CBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      indicatorColor: AppColors.primaryLightColor,
      onDestinationSelected: onDestinationSelected,
      destinations: <NavigationDestination>[
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
          selectedIcon: Icon(
            Icons.home,
            color: AppColors.primaryColor,
          ),
        ),
        const NavigationDestination(
          icon: Icon(Icons.search_outlined),
          label: 'notifications',
          selectedIcon: Icon(
            Icons.search,
            color: AppColors.primaryColor,
          ),
        ),
        const NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: 'Account',
          selectedIcon: Icon(
            Icons.person,
            color: AppColors.primaryColor,
          ),
        ),
        NavigationDestination(
            icon: Badge.count(
              count: 2,
              backgroundColor: Colors.red,
              child: const Icon(Icons.message_sharp),
            ),
            label: 'Messages')
      ],
    );
  }
}
