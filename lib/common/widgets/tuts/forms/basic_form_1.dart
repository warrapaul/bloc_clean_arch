import 'package:bloc_clean_arch/common/widgets/tuts/forms/widets/custom_disabled_text_form_field.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/forms/widets/custom_dropdown_button.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/forms/widets/custom_dropdown_menu.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/forms/widets/custom_email_form_field.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/forms/widets/custom_interger_form_field.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/forms/widets/custom_password_form_field.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/forms/widets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class BasicForm1 extends StatefulWidget {
  const BasicForm1({super.key});

  @override
  State<BasicForm1> createState() => _BasicForm1State();
}

class _BasicForm1State extends State<BasicForm1> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _regionsListController = TextEditingController();
  final TextEditingController _regsMapController = TextEditingController();
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _lastNameController.text = 'initial value';
    super.initState();
  }

  final Map<String, String> _regs = {
    'zmm': 'Zimmerman',
    'g44': 'Bithurai 44',
    'g45': 'Githurai 45'
  };

  final List<String> _regions = ['zmm', 'g44', 'lsm', 'g45'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Form 1'),
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(32.0),
            children: [
              Row(
                children: [
                  Flexible(
                      child: CustomTextFormField(
                          controller: _firstNameController,
                          hintText: 'First name')),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: CustomTextFormField(
                          controller: _lastNameController,
                          hintText: 'Last name')),
                ],
              ),
              const SizedBox(height: 20),
              CustomIntegerFormField(
                controller: _phoneNumberController,
                hintText: 'Phone Number',
                minValue: 7,
                maxLength: 13,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: CustomEmailFormField(
                        controller: _emailController, hintText: 'Email'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: CustomIntegerFormField(
                      controller: _phoneNumberController,
                      hintText: 'Age',
                      maxLength: 3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomPasswordFormField(
                  controller: _passwordController, hintText: 'Password'),
              const SizedBox(height: 20),
              CustomPasswordFormField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const CustomDisabledTextFormField(value: 'test disabled'),
              const SizedBox(height: 20),
              const Text('Using List:'),
              CustomDropdownMenu(
                hintText: 'List Regions',
                items: _regions,
                onChanged: (value) {
                  print('Selected: $value');
                },
                controller: _regionsListController,
              ),
              const Text('Using Maps:'),
              CustomDropdownMenu(
                hintText: 'Map Regions',
                items: _regs,
                onChanged: (value) {
                  print('Selected: $value');
                },
                controller: _regsMapController,
              ),


              const SizedBox(height: 20),

              const Text('DropdownButton List:'),
              CustomDropdownButton(
                hintText: 'List Regions',
                items: _regions,
                onChanged: (value) {
                  print('Selected: $value');
                },
                controller: _regionsListController,
              ),
              const Text('DropdownButton Maps:'),
              CustomDropdownButton(
                hintText: 'Map Regions',
                items: _regs,
                onChanged: (value) {
                  print('Selected: $value');
                },
                controller: _regsMapController,
              ),
              const SizedBox(height: 20),
              
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('Valid form');
                    }
                  },
                  child: const Icon(Icons.check))
            ],
          )),
    );
  }
}
