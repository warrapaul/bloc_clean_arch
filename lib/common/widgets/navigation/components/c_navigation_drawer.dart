import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CNavigationDrawer extends StatelessWidget {
  const CNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 1,
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            context.pushNamed(AppRoutePaths.basicForm1);
            break;
          case 1:
            context.pushNamed(AppRoutePaths.dialogHome);
            break;
          case 2:
            context.pushNamed(AppRoutePaths.buttonHome);
            break;
          case 3:
            context.pushNamed(AppRoutePaths.basicTabBars);
            break;
          case 4:
            context.pushNamed(AppRoutePaths.imagesHome);
            break;
          case 5:
            context.pushNamed(AppRoutePaths.bottomSheetHome);
            break;
          case 6:
            context.pushNamed(AppRoutePaths.shimmerHome);
            break;
          case 7:
            context.pushNamed(AppRoutePaths.crouselSlider);
            break;
          case 8:
            context.pushNamed(AppRoutePaths.notifications, extra: {
              'title': 'test title',
              'body': 'test body',
              'data': {
                'name': 'user',
                'age': 20,
              },
            });
            break;
          case 9:
            context.pushNamed(AppRoutePaths.gridViewHome);
            break;
        }
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
          child: Text(
            'App Name',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const Divider(height: 1),
        const _DrawerHeader(),
        const NavigationDrawerDestination(
          icon: Icon(Icons.book_outlined),
          selectedIcon: Icon(Icons.book),
          label: Text('Form'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.slideshow_sharp),
          selectedIcon: Icon(Icons.slideshow),
          label: Text('Dialog'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.ads_click_outlined),
          selectedIcon: Icon(Icons.ads_click),
          label: Text('Button'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.slideshow_sharp),
          selectedIcon: Icon(Icons.slideshow),
          label: Text('Tabs'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.image_outlined),
          selectedIcon: Icon(Icons.image),
          label: Text('Images'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.slideshow_sharp),
          selectedIcon: Icon(Icons.slideshow),
          label: Text('Bottom Sheet'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.slideshow_sharp),
          selectedIcon: Icon(Icons.slideshow),
          label: Text('Shimmer'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.slideshow_sharp),
          selectedIcon: Icon(Icons.slideshow),
          label: Text('Carousel'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.slideshow_sharp),
          selectedIcon: Icon(Icons.slideshow),
          label: Text('Notifications'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.grid_3x3_outlined),
          selectedIcon: Icon(Icons.grid_3x3),
          label: Text('GridView'),
        ),
        // Spacer for bottom content
        const SizedBox(height: 8),
        // Bottom section with user profile
        const _DrawerFooter(),
      ],
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Icon(
              Icons.person_outline,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Name',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'user@email.com',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerFooter extends StatelessWidget {
  const _DrawerFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.help_outline,
                size: 20,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Text(
                'Help & Feedback',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
