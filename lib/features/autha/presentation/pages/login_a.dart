import 'package:bloc_clean_arch/common/bloc/button/button_cubit.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/bloc_button/basic_app_button.dart';
import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/features/autha/data/model/login_req_params.dart';
import 'package:bloc_clean_arch/features/autha/domain/usecase/login.dart';
import 'package:bloc_clean_arch/features/autha/domain/usecase/signup.dart';
import 'package:bloc_clean_arch/features/autha/presentation/bloc/auth/autha_cubit.dart';
import 'package:bloc_clean_arch/features/auth/presentation/widgets/input_field.dart';
import 'package:bloc_clean_arch/features/home/presentation/pages/home.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPagea extends StatelessWidget {
  LoginPagea({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ButtonCubit(),
        child: Scaffold(
          body: BlocProvider(
            create: (context) => ButtonCubit(),
            child: BlocListener<ButtonCubit, ButtonState>(
              listener: (context, state) {
                if (state is ButtonSucess) {
                  // context.replaceNamed(AppRoutes.home); // navigate and remove the previous page from stack

                  // Update the AuthaCubit state
                  context.read<AuthaCubit>().loginSuccessful();

                  context.goNamed(AppRoutePaths.home);
                }
                if (state is ButtonFailure) {
                  var snackBar = SnackBar(content: Text(state.errorMessage));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: SafeArea(
                  child: Column(
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
                  const SizedBox(
                    height: 30,
                  ),
                  _loginButton(context),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style.copyWith(
                          color: const Color.fromARGB(255, 97, 95, 95),
                          fontSize: 14.0),
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
              )),
            ),
          ),
        ));
  }

  Widget _loginButton(BuildContext context) {
    return Builder(builder: (context) {
      return BasicAppButton(
          title: 'Login',
          onPressed: () {
            context.read<ButtonCubit>().execute(
                  usecase: sl<LoginUsecasea>(),
                  params: LoginReqParams(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
          });
    });
  }
}
