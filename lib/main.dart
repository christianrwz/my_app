import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController =
      TextEditingController(); // Address field controller

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email Field (Required)
          CustomFormField(
            label: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            formKey: _formKey, // Pass the formKey
            validator: (value) {
              if (value == null || value.isEmpty || !value.isValidEmail) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Password Field (Required)
          CustomFormField(
            label: 'Password',
            controller: _passwordController,
            obscureText: true,
            formKey: _formKey, // Pass the formKey
            validator: (value) {
              if (value == null || value.isEmpty || !value.isValidPassword) {
                return 'Password must contain an uppercase letter, lowercase letter, number, and special character';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Phone Number Field (Required)
          CustomFormField(
            label: 'Mobile Number',
            controller: _phoneController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // Only allow digits
              PhoneNumberFormatter(), // Apply the custom formatter
            ],
            autoFormatOnChange: true,
            formKey: _formKey, // Pass the formKey
            validator: (value) {
              if (value == null || value.length != 11) {
                return 'Please enter a valid mobile number (e.g., 09171234567)';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          // Address Field (Optional)
          CustomFormField(
            label: 'Address',
            controller: _addressController,
            isRequired: false, // This field is optional
            formKey: _formKey, // Pass the formKey
            validator: (value) {
              // Optional field doesn't require validation
              return null;
            },
          ),
          SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Proceed with the form submission
                print("Form is valid! Submitting...");
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
