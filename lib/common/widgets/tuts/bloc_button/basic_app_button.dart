import 'package:bloc_clean_arch/common/bloc/button/button_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicAppButton extends StatelessWidget {
  const BasicAppButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.height,
      this.width});

  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonCubit, ButtonState>(builder: (context, state) {
          if (state is ButtonLoading) {
            return _loadingButton(context);
          }
          return _initialButton(context);
        });
  }

  Widget _loadingButton(BuildContext context) {
    return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          minimumSize:
              Size(width ?? MediaQuery.of(context).size.width, height ?? 60),
              disabledBackgroundColor: Colors.blueGrey
        ),
        child: const CircularProgressIndicator(color: Colors.white));
  }

  Widget _initialButton(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
          BoxShadow(
            color: const Color(0xff3461FD).withOpacity(0.8),
            offset: const Offset(0, 5),
            blurRadius: 17,
          )
        ]),
        child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize:
              Size(width ?? MediaQuery.of(context).size.width, height ?? 60),
        ),
        child: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ))
        );
  }
}
