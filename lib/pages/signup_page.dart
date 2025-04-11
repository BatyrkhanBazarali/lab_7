import 'package:flutter/material.dart';
import 'package:registration_app/model/user_data.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpPage extends StatefulWidget {
  final void Function(UserData) onUserCreated;

  const SignUpPage({Key? key, required this.onUserCreated}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sign_up_form'.tr()),
        backgroundColor: Colors.teal,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              final newLocale = context.locale.languageCode == 'en' ? const Locale('ru') : const Locale('en');
              context.setLocale(newLocale);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Убрали заголовок Create Account, теперь форма сразу
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Поле ввода для имени
                      _buildTextField(
                        controller: _nameController,
                        label: "full_name".tr(),
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "name_empty".tr();
                          }
                          if (value.trim().split(RegExp(r'\s+')).length < 2) {
                            return "name_min_words".tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Поле ввода для номера телефона
                      _buildTextField(
                        controller: _phoneController,
                        label: "phone_number".tr(),
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) return "phone_empty".tr();
                          // Исправляем регулярное выражение, чтобы оно принимало только цифры
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) return "phone_invalid".tr();
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Поле ввода для электронной почты
                      _buildTextField(
                        controller: _emailController,
                        label: "email".tr(),
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return "email_empty".tr();
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "email_invalid".tr();
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Многострочное поле для биографии
                      _buildMultilineTextField(
                        controller: _biographyController,
                        label: "biography".tr(),
                        helperText: "biography_hint".tr(),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "biography_empty".tr();
                          }
                          if (value.trim().split(RegExp(r'\s+')).length < 20) {
                            return "biography_min_words".tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Поле ввода для пароля
                      _buildPasswordField(
                        controller: _passwordController,
                        label: "password".tr(),
                        obscureText: _isPasswordHidden,
                        onToggle: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Поле ввода для подтверждения пароля
                      _buildPasswordField(
                        controller: _confirmPasswordController,
                        label: "confirm_password".tr(),
                        obscureText: _isConfirmPasswordHidden,
                        onToggle: () {
                          setState(() {
                            _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) return "confirm_empty".tr();
                          if (value != _passwordController.text) return "passwords_no_match".tr();
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Кнопка отправки формы
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal, // Цвет кнопки
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final newUser = UserData(
                                fullName: _nameController.text,
                                phoneNumber: _phoneController.text,
                                emailAddress: _emailController.text,
                                biography: _biographyController.text,
                              );
                              widget.onUserCreated(newUser);
                            }
                          },
                          child: Text(
                            "submit_form".tr(),
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        fillColor: Colors.teal.shade50,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        fillColor: Colors.teal.shade50,
        filled: true,
      ),
      validator: validator ?? (value) {
        if (value!.isEmpty) return "password_empty".tr();
        if (value.length < 6) return "password_short".tr();
        return null;
      },
    );
  }

  Widget _buildMultilineTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    String? helperText,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        helperText: helperText,
        fillColor: Colors.teal.shade50,
        filled: true,
      ),
      validator: validator,
    );
  }
}
