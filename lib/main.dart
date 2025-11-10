import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/extensions.dart';
import 'package:my_app/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Custom Form Field Example")),
        body: Padding(padding: const EdgeInsets.all(16.0), child: LoginForm()),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();
  final _phoneFieldKey = GlobalKey<FormFieldState>();
  final _addressFieldKey = GlobalKey<FormFieldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFormField(
            label: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty || !value.isValidEmail) {
                return 'Please enter a valid email';
              }
              return null;
            },
            fieldKey: _emailFieldKey,
            validateOnChange: true, // ✅ live validate
          ),
          SizedBox(height: 16),
          CustomFormField(
            label: 'Password',
            controller: _passwordController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty || !value.isValidPassword) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
            fieldKey: _passwordFieldKey,
            validateOnChange: true, // ✅ live validate
          ),
          SizedBox(height: 16),
          CustomFormField(
            label: 'Mobile Number',
            hintText: '09123456789',
            controller: _phoneController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              // PhoneNumberFormatter(),
              LengthLimitingTextInputFormatter(11),
            ],
            validator: (value) {
              if (value == null || value.length != 11) {
                return 'Please enter a valid mobile number';
              }
              return null;
            },
            fieldKey: _phoneFieldKey,
            validateOnChange: true, // ✅ live validate
          ),
          SizedBox(height: 16),
          CustomFormField(
            label: 'Address',
            controller: _addressController,
            isRequired: false,
            fieldKey: _addressFieldKey,
          ),

          SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Proceed with the form submission
                print("Email: ${_emailController.text}");
                print("Password: ${_passwordController.text}");
                print("Phone Number: ${_phoneController.text}");
                print("Address: ${_addressController.text}");
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
