import 'package:bloc_clean_arch/core/constants/app_media.dart';
import 'package:flutter/material.dart';


class AppAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Basic Me'),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(AppMedia.appLogo, fit: BoxFit.contain, height: 30,),
      ),

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
