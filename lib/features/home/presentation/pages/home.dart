import 'package:bloc_clean_arch/common/widgets/buttons/app_loading_button.dart';
import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/core/theme/cubit/theme_cubit.dart';
import 'package:bloc_clean_arch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bloc_clean_arch/features/users/presentation/bloc/cubit/user_profile/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserProfileCubit()..displayUserProfile(),
        ),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, authState) {
          if (authState is UnAuthenticated) {
            context.goNamed(AppRoutePaths.login);
          } else if (authState is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Logout failed: ${authState.message}')),
            );
          }
        },
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, userProfileState) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Home'),
                    actions: [
                      IconButton(
                        icon: Icon(
                          context.read<ThemeCubit>().state.themeMode ==
                                  ThemeMode.dark
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                          color: context.read<ThemeCubit>().state.themeMode ==
                                  ThemeMode.dark
                              ? Colors.yellow[700]
                              : Colors.blue[800],
                        ),
                        onPressed: () {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                        tooltip: 'Toggle Theme',
                      ),
                      if (userProfileState is UserProfileLoaded)
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            _getInitials(userProfileState.user.firstName,
                                userProfileState.user.lastName),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      IconButton(onPressed: ()=>context.read<AuthCubit>().logout,
                       icon: const Icon(Icons.logout))
                      
                    ],
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.goNamed(AppRoutePaths.profile);
                          },
                          child: const Text('Profile'),
                        ),
                        FilledButton(
                            onPressed: () {
                              context.pushNamed(AppRoutePaths.cWidgets);
                            },
                            child: const Text('Custom Widgets')),
                        if (userProfileState is UserProfileLoaded) ...[
                          const SizedBox(height: 20),
                          Text(
                              'Welcome, ${userProfileState.user.firstName} ${userProfileState.user.lastName}!'),
                        ],

                        AppLoadingButton(
                          text: 'login',
                          isLoading: true,
                          onPressed: () {
                            
                          },
                          isRounded: false,
                        ),

                         AppLoadingButton(
                          text: 'login long msg',
                          isLoading: true,
                          onPressed: () {},
                          isRounded: true,
                        ),
                        
                                   ],
                    ),
                  ),
                );
              
            
          },
        ),
      ),
    );
  }

  String _getInitials(String firstName, String lastName) {
    return '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
        .toUpperCase();
  }
}
