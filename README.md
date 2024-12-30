# navigate without context
*** routes
GoRouter(
     routes: <GoRoute>[
        initialLocation: AppRoutePaths.home 
        GoRoute(
          path: '/test1',
          builder: (BuildContext context, GoRouterState state) => const Test1(),
        ),
        GoRoute(
          path: '/test2/:id',
          builder: (BuildContext context, GoRouterState state) => Test2(id: state.pathParameters['id']!, ),
        ),
     ],
)

**** Test1 - statelessWidget
// button
    onPressed: () {
        AppRouter.router.go('/test2/123');
    },

// test2
    onPressed: () {
        AppRouter.router.go('/test1');
    },


# run futter app with CORS
flutter run -d chrome --web-browser-flag "--disable-web-security"