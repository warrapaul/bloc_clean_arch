import 'package:bloc_clean_arch/common/bloc/button/button_cubit.dart';
import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecase/logout.dart';
import 'package:bloc_clean_arch/features/users/presentation/bloc/cubit/user_profile/user_profile_cubit.dart';
import 'package:bloc_clean_arch/service_locator.dart';
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
        BlocProvider(create: (context) => ButtonCubit()),
      ],
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, userProfileState) {
          return BlocConsumer<ButtonCubit, ButtonState>(
            listener: (context, buttonState) {
              if (buttonState is ButtonSucess) {
                // Navigate to login page after successful logout
                context.goNamed(AppRoutes.login);
              } else if (buttonState is ButtonFailure) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('Logout failed: ${buttonState.errorMessage}')),
                );
              }
            },
            builder: (context, buttonState) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Home'),
                  actions: [
                    if (userProfileState is UserProfileLoaded)
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          _getInitials(userProfileState.user.firstName,
                              userProfileState.user.lastName),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    IconButton(
                      onPressed: buttonState is ButtonLoading
                          ? null
                          : () => _logoutButton(context),
                      icon: buttonState is ButtonLoading
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.logout),
                    ),
                  ],
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed(AppRoutes.profile);
                        },
                        child: const Text('Profile'),
                      ),
                      if (userProfileState is UserProfileLoaded) ...[
                        const SizedBox(height: 20),
                        Text(
                            'Welcome, ${userProfileState.user.firstName} ${userProfileState.user.lastName}!'),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _logoutButton(BuildContext context) {
    context.read<ButtonCubit>().execute(
          usecase: sl<LogoutUsecase>(),
        );
  }

  String _getInitials(String firstName, String lastName) {
    return '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
        .toUpperCase();
  }
}