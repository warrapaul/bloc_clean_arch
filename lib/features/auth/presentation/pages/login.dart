import 'package:bloc_clean_arch/common/widgets/buttons/app_loading_button.dart';
import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/features/auth/data/models/login_req_dto.dart';
import 'package:bloc_clean_arch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bloc_clean_arch/features/auth/presentation/widgets/input_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          } else if (state is Authenticated) {
            context.goNamed(AppRoutePaths.home);
          }
        },
        builder: (context, state) {
          return switch (state) {
            // AuthLoading() => const Center(child: CircularProgressIndicator()),
            _ => loginForm(context, state)
          };
        },
      ),
    ));
  }

  Widget loginForm(BuildContext context, AuthState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        AuthInputField(
          hintText: 'Email',
          controller: _emailController,
        ),
        const SizedBox(
          height: 30,
        ),
        AuthInputField(
          hintText: 'Password',
          controller: _passwordController,
        ),
        const SizedBox(height: 30),
        AppLoadingButton(
          text: 'login',
          onPressed: (){
            final loginReqDto = LoginReqDto(
                email: _emailController.text,
                password: _passwordController.text,
              );
              context.read<AuthCubit>().login(loginReqDto);
          },
          isLoading: state is AuthLoading,
        ),
        const SizedBox(height: 30),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style.copyWith(
                color: const Color.fromARGB(255, 97, 95, 95), fontSize: 14.0),
            children: <TextSpan>[
              const TextSpan(text: "Don't have an account? "),
              TextSpan(
                text: 'Sign up ',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.goNamed(AppRoutePaths.signup);
                  },
              ),
              const TextSpan(text: 'here'),
            ],
          ),
        )
      ],
    );
  }
}

// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => ButtonCubit(),
//         child: Scaffold(
//           body: BlocProvider(
//             create: (context) => ButtonCubit(),
//             child: BlocListener<ButtonCubit, ButtonState>(
//               listener: (context, state) {
//                 if (state is ButtonSucess) {
//                   // context.replaceNamed(AppRoutes.home); // navigate and remove the previous page from stack
//                   context.read<AuthaCubit>().loginSuccessful();

//                   context.goNamed(AppRoutePaths.home);
//                 }
//                 if (state is ButtonFailure) {
//                   var snackBar = SnackBar(content: Text(state.errorMessage));
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                 }
//               },
//               child: SafeArea(
//                   child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   AuthInputField(
//                     hintText: 'Email',
//                     controller: _emailController,
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   AuthInputField(
//                     hintText: 'Password',
//                     controller: _passwordController,
//                   ),
//                   const SizedBox(height: 30),
//                   _loginButton(context),
//                   const SizedBox(height: 30),
//                   RichText(
//                     text: TextSpan(
//                       style: DefaultTextStyle.of(context).style.copyWith(
//                           color: const Color.fromARGB(255, 97, 95, 95),
//                           fontSize: 14.0),
//                       children: <TextSpan>[
//                         const TextSpan(text: "Don't have an account? "),
//                         TextSpan(
//                           text: 'Sign up ',
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blueAccent,
//                               decoration: TextDecoration.underline),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () {
//                               context.goNamed(AppRoutePaths.signup);
//                             },
//                         ),
//                         const TextSpan(text: 'here'),
//                       ],
//                     ),
//                   )
//                 ],
//               )),
//             ),
//           ),
//         ));
//   }

//   Widget _loginButton(BuildContext context) {
//     return Builder(builder: (context) {
//       return BasicAppButton(
//           title: 'Login',
//           onPressed: () {
//             context.read<ButtonCubit>().execute(
//                   usecase: sl<LoginUsecase>(),
//                   params: LoginReqParams(
//                     email: _emailController.text,
//                     password: _passwordController.text,
//                   ),
//                 );
//           });
//     });
//   }
// }
