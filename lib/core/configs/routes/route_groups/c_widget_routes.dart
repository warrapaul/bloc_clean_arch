import 'package:bloc_clean_arch/common/widgets/badges/custom_badge.dart';
import 'package:bloc_clean_arch/common/widgets/bottom_sheet/bottom_sheet_home.dart';
import 'package:bloc_clean_arch/common/widgets/buttons/button_home.dart';
import 'package:bloc_clean_arch/common/widgets/c_widgets_home.dart';
import 'package:bloc_clean_arch/common/widgets/carousel/c_carousel_slider.dart';
import 'package:bloc_clean_arch/common/widgets/dialogs/dialog_home.dart';
import 'package:bloc_clean_arch/common/widgets/forms/basic_form_1.dart';
import 'package:bloc_clean_arch/common/widgets/gridView/grid_view_home.dart';
import 'package:bloc_clean_arch/common/widgets/images/images_home.dart';
import 'package:bloc_clean_arch/common/widgets/shimmer/shimmer_home.dart';
import 'package:bloc_clean_arch/common/widgets/tabs/basic_tab_bars.dart';
import 'package:bloc_clean_arch/common/widgets/test/test_one.dart';
import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/features/reusable_widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CWidgetRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      name: AppRoutePaths.appWidgetsHome,
      path: AppRoutePaths.appWidgetsHome,
      builder: (BuildContext context, GoRouterState state) {
        return AppWidgetsPage();
      },
    ),
    GoRoute(
      name: AppRoutePaths.gridViewHome,
      path: AppRoutePaths.gridViewHome,
      builder: (BuildContext context, GoRouterState state) {
        return GridViewHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.cWidgets,
      path: AppRoutePaths.cWidgets,
      builder: (BuildContext context, GoRouterState state) {
        return CWidgetsHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.crouselSlider,
      path: AppRoutePaths.crouselSlider,
      builder: (BuildContext context, GoRouterState state) {
        return CCarouselSlider();
      },
    ),
    GoRoute(
      name: AppRoutePaths.shimmerHome,
      path: AppRoutePaths.shimmerHome,
      builder: (BuildContext context, GoRouterState state) {
        return ShimmerHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.imagesHome,
      path: AppRoutePaths.imagesHome,
      builder: (BuildContext context, GoRouterState state) {
        return ImagesHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.bottomSheetHome,
      path: AppRoutePaths.bottomSheetHome,
      builder: (BuildContext context, GoRouterState state) {
        return BottomSheetHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.basicTabBars,
      path: AppRoutePaths.basicTabBars,
      builder: (BuildContext context, GoRouterState state) {
        return BasicTabBars();
      },
    ),
    GoRoute(
      name: AppRoutePaths.buttonHome,
      path: AppRoutePaths.buttonHome,
      builder: (BuildContext context, GoRouterState state) {
        return ButtonHome();
      },
    ),
    GoRoute(
      name: AppRoutePaths.dialogHome,
      path: AppRoutePaths.dialogHome,
      builder: (BuildContext context, GoRouterState state) {
        return DialogHome();
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
        return CustomBadge();
      },
    ),
    GoRoute(
      name: AppRoutePaths.testOne,
      path: AppRoutePaths.testOne,
      builder: (BuildContext context, GoRouterState state) {
        return TestOne();
      },
    ),
  ];
}
