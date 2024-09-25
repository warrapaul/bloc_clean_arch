import 'package:bloc_clean_arch/features/users/presentation/bloc/cubit/user_profile/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (_) => UserProfileCubit()..displayUserProfile(),
      
      child: Scaffold(body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
      if (state is UserProfileInitial) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is UserProfileLoaded) {
        return Center(
          child: Column(
            children: [
              Text('Username: ${state.user.firstName} ${state.user.lastName}'),
              const SizedBox(
                height: 10,
              ),
              Text('Phone: ${state.user.phoneNumber}'),
              const SizedBox(
                height: 10,
              ),
              Text('Email: ${state.user.email}'),
            ],
          ),
        );
      }

      if (state is UserProfileFailure) {
        return Center(
          child: Text(state.errorMessage),
        );
      }
      return Container();
    }))
    );
  }
}
