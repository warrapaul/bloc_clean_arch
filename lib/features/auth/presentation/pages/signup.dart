import 'package:bloc_clean_arch/common/bloc/button/button_cubit.dart';
import 'package:bloc_clean_arch/common/widgets/bloc_button/basic_app_button.dart';
import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/features/auth/data/model/signup_req_params.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecase/signup.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:bloc_clean_arch/features/auth/presentation/widgets/input_field.dart';
import 'package:bloc_clean_arch/features/home/presentation/pages/home.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
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
                  context.read<AuthCubit>().loginSuccessful();
                  context.goNamed(AppRoutePaths.home);
                }
                if (state is ButtonFailure) {
                  var snackBar = SnackBar(content: Text(state.errorMessage));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: SafeArea(
                  minimum: const EdgeInsets.only(top: 60, right: 16, left: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        AuthInputField(
                          hintText: 'FirstName',
                          controller: _firstnameController,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthInputField(
                          hintText: 'MiddleName',
                          controller: _middleNameController,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthInputField(
                          hintText: 'LastName',
                          controller: _lastNameController,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthInputField(
                          hintText: 'National Id',
                          controller: _nationalIdController,
                        ),
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
                          hintText: 'Phone number',
                          controller: _phoneNumberController,
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
                        _createAccountButton(context),
                        const SizedBox(
                          height: 30,
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style.copyWith(
                                color: const Color.fromARGB(255, 97, 95, 95),
                                fontSize: 14.0),
                            children: <TextSpan>[
                              const TextSpan(text: "Have an account already? "),
                              TextSpan(
                                text: 'Login ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.goNamed(AppRoutePaths.login);
                                  },
                              ),
                              const TextSpan(text: 'here'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }

  Widget _createAccountButton(BuildContext context) {
    return Builder(builder: (context) {
      return BasicAppButton(
          title: 'Signup',
          onPressed: () {
            context.read<ButtonCubit>().execute(
                  usecase: sl<SignupUsecase>(),
                  params: SignupReqParams(
                    firstName: _firstnameController.text,
                    middleName: _middleNameController.text,
                    lastName: _lastNameController.text,
                    nationalId: int.parse(_nationalIdController.text),
                    email: _emailController.text,
                    phoneNumber: _phoneNumberController.text,
                    password: _passwordController.text,
                  ),
                );
          });
    });
  }
}
