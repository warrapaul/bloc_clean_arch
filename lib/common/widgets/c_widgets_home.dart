import 'package:bloc_clean_arch/common/widgets/navigation/basic_screens/account.dart';
import 'package:bloc_clean_arch/common/widgets/navigation/basic_screens/home.dart';
import 'package:bloc_clean_arch/common/widgets/navigation/basic_screens/messages.dart';
import 'package:bloc_clean_arch/common/widgets/navigation/basic_screens/notifications.dart';
import 'package:bloc_clean_arch/common/widgets/navigation/components/c_bottom_nav.dart';
import 'package:bloc_clean_arch/common/widgets/navigation/components/c_navigation_drawer.dart';
import 'package:bloc_clean_arch/common/widgets/navigation/components/c_popup_anchor_menu.dart';
import 'package:flutter/material.dart';

/*
 AppBar - displays info and actions relating to the current screen
 can consist TabBar and FlexibleSpaceBar,
 - when used in scaffold they are fixed at the top, for scrollable use SliverAppBar
 - scaffold by default takes are of sytem UI intrusion prevention for appBar
 - if leading is ommitted and Scaffold has a Drawer, btn to opern drawer is inserted automatically
 otherwise if nearest Navigator have previous routes, BackButton is inserted
 * compose 
 > leading
 > title
 > actions - array of widgets - consider PopupMenuButton
 > flexibleSpace
 > bottom - typically used for tabs


 ** PopupMenuButton
 - postion in actions with more_vert icon
 - displays a menu when pressed and calls onSelected passing value of the selected menu item
 - can have either child or icon (behaving like iconButton) if non is provided - defaults to overflow icon same as more_vert
 - consider uing MenuAnchor

 ** MenuAnchor
 - more flexible and customizable with better support for nested menus
 - more control over behaviour and positioning
 - can be triggered by any widget
 - needs stateful for controller


*** NavigationBar
- replaced BottomNavigationBar
- theme using NavigationBarThemeData and provide destinations using NavigationDestinations



*** Avoid combining primary navigation components
> NavigationBar for compact window sizes
> NavigationRails for medium and expanded windows
> Drawers for expanded, large and extra-large


** stardard navigation drawer
- for expanded, large and extra large windows
- can be permanetly visible
- For web experiences on laptop and desktop devices, 
use either a standard navigation drawer, or a navigation rail that
 transitions into a modal navigation drawer
** modal naviagation drawer, for medium and compact screens


** use NavigationDrawer instead of Drawer for material3


 */
class CWidgetsHome extends StatefulWidget {
  const CWidgetsHome({super.key});

  @override
  State<CWidgetsHome> createState() => _HomePageState();
}

class _HomePageState extends State<CWidgetsHome> {
  int currentPageIndex = 0;
  final List<Widget> _screens = [
    const BasicHome(),
    const BasicNotifications(),
    const BasicAccount(),
    const BasicMessages(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('homePage'),
        actions: [
          const Icon(Icons.search),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Badge(
              // label: Text('2'),
              backgroundColor: Colors.red,
              child: Icon(Icons.notifications),
            ),
          ),
          CPopupAnchorMenu(),
          //  CPopupMenu()
        ],
      ),
      drawer: CNavigationDrawer(),
      bottomNavigationBar: CBottomNav(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: _screens[currentPageIndex],
    );
  }
}
