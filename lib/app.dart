import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/core/configs/theme/theme.dart';
import 'package:bloc_clean_arch/features/users/presentation/bloc/cubit/user_profile/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
            BlocProvider(
              create: (context) => AuthCubit()..appStarted(), //register cubit and call a function
              ),
           
        ],
        child:  BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final isAuthenticated = state is AuthenticatedState;
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.appTheme,
                routerConfig: AppRouter.createRouter(isAuthenticated),
              );
            }
        ),
    );
  }      
      
}

