import 'package:bloc_clean_arch/common/widgets/tuts/navigation/basic_screens/account.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/navigation/basic_screens/home.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/navigation/basic_screens/messages.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/navigation/basic_screens/notifications.dart';
import 'package:flutter/material.dart';

class BasicTabBars extends StatefulWidget {
  const BasicTabBars({super.key});

  @override
  State<BasicTabBars> createState() => _BasicTabBarsState();
}

class _BasicTabBarsState extends State<BasicTabBars> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,

        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
               const Tab(
                icon: Icon(Icons.home),
                text: 'Home',
              ),
              // Notifications tab
              const Tab(
                icon: Icon(Icons.notifications_outlined),
                text: 'Notifications',
              ),
              // Account tab
              const Tab(
                icon: Icon(Icons.person),
                text: 'Account',
              ),
               Tab(
                icon: Badge.count(
                  count: 2,
                  child: const Icon(Icons.message_outlined),
                ),
                text: 'Messages',
              ),
            ]),
          ),
          body: const TabBarView(children: [
            BasicHome(),
            BasicNotifications(),
            BasicAccount(),
            BasicMessages(),
            ]),
        ));
  }
}
