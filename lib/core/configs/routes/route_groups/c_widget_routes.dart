import 'package:bloc_clean_arch/common/widgets/tuts/badges/custom_badge.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/bottom_sheet/bottom_sheet_home.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/buttons/button_home.dart';
import 'package:bloc_clean_arch/common/widgets/c_widgets_home.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/carousel/c_carousel_slider.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/dialogs/dialog_home.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/forms/basic_form_1.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/gridView/grid_view_home.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/images/images_home.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/infinite_scroll/infinite_scroll_home.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/shimmer/shimmer_home.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/tabs/basic_tab_bars.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/test/test_one.dart';
import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/features/chat_messaging/presentation/pages/chat_message_home.dart';
import 'package:bloc_clean_arch/features/chat_messaging/presentation/pages/chat_message_t.dart';
import 'package:bloc_clean_arch/features/reusable_widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CWidgetRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      name: AppRoutePaths.infiniteScrollHomePage,
      path: AppRoutePaths.infiniteScrollHomePage,
      builder: (BuildContext context, GoRouterState state) {
        return const InfiniteScrollHomePage();
      },
    ),
    GoRoute(
      name: AppRoutePaths.appWidgetsHome,
      path: AppRoutePaths.appWidgetsHome,
      builder: (BuildContext context, GoRouterState state) {
        return const AppWidgetsPage();
      },
    ),
    GoRoute(
      name: AppRoutePaths.gridViewHome,
      path: AppRoutePaths.gridViewHome,
      builder: (BuildContext context, GoRouterState state) {
        return const GridViewHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.cWidgets,
      path: AppRoutePaths.cWidgets,
      builder: (BuildContext context, GoRouterState state) {
        return const CWidgetsHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.crouselSlider,
      path: AppRoutePaths.crouselSlider,
      builder: (BuildContext context, GoRouterState state) {
        return const CCarouselSlider();
      },
    ),
    GoRoute(
      name: AppRoutePaths.shimmerHome,
      path: AppRoutePaths.shimmerHome,
      builder: (BuildContext context, GoRouterState state) {
        return const ShimmerHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.imagesHome,
      path: AppRoutePaths.imagesHome,
      builder: (BuildContext context, GoRouterState state) {
        return const ImagesHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.bottomSheetHome,
      path: AppRoutePaths.bottomSheetHome,
      builder: (BuildContext context, GoRouterState state) {
        return const BottomSheetHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.basicTabBars,
      path: AppRoutePaths.basicTabBars,
      builder: (BuildContext context, GoRouterState state) {
        return const BasicTabBars();
      },
    ),
    GoRoute(
      name: AppRoutePaths.buttonHome,
      path: AppRoutePaths.buttonHome,
      builder: (BuildContext context, GoRouterState state) {
        return const ButtonHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.dialogHome,
      path: AppRoutePaths.dialogHome,
      builder: (BuildContext context, GoRouterState state) {
        return const DialogHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.basicForm1,
      path: AppRoutePaths.basicForm1,
      builder: (BuildContext context, GoRouterState state) {
        return BasicForm1();
      },
    ),
    GoRoute(
      name: AppRoutePaths.customBadge,
      path: AppRoutePaths.customBadge,
      builder: (BuildContext context, GoRouterState state) {
        return const CustomBadge();
      },
    ),
    GoRoute(
      name: AppRoutePaths.testOne,
      path: AppRoutePaths.testOne,
      builder: (BuildContext context, GoRouterState state) {
        return TestOne();
      },
    ),
    GoRoute(
      name: AppRoutePaths.chatMessaging,
      path: AppRoutePaths.chatMessaging,
      builder: (BuildContext context, GoRouterState state) {
        return const ChatMessageT(); //ChatMessageHomePage();
      },
    ),
  ];
}
