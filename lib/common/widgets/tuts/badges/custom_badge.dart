import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({super.key});

  /**
   * // Simple badge theme
  static const BadgeThemeData badgeTheme = BadgeThemeData(
    backgroundColor: AppColors.error,
    textColor: Colors.white,
    largeSize: badgeSize,
    padding: EdgeInsets.symmetric(horizontal: 6),
  );
   */

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               IconButton(
                onPressed: (){}, 
                icon: const Badge(
                  label: Text('New'),
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.receipt),
                )),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: (){},
                  icon: Badge.count(
                    backgroundColor: Colors.red,
                    // isLabelVisible: false,
                    // offset: const Offset(8, 8),
                    count: 4,
                    child: const Icon(
                      Icons.notifications,
                      // size: 24,
                    ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
