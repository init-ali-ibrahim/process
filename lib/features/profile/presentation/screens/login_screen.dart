import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:form_validator/form_validator.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/core/util/logger.dart';
import 'package:process/features/profile/data/repo/profile_repo.dart';
import 'package:process/features/profile/presentation/riverpod/profile_riverpod.dart';
import 'package:process/features/profile/presentation/widgets/login/login_appbar_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late ProfileRepo repo;

  @override
  void initState() {
    super.initState();
    repo = ProfileRepo();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  bool _obscureText = true;
  final maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  String formatPhoneNumber(String input) {
    String digitsOnly = input.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.startsWith('7') || digitsOnly.startsWith('8')) {
      digitsOnly = '7${digitsOnly.substring(1)}';
    }

    return digitsOnly;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  InputDecoration _getInputDecoration(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[600]),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final phoneFormat = formatPhoneNumber(_phoneController.text);

        await repo.login(
          phone: phoneFormat,
          password: _passwordController.text,
        )
            .then((_) async {
          await ref.read(profileProvider.notifier).getUser();
          router.pop();
        });
      } catch (e) {
        logger.e('e: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade100,
      appBar: const LoginAppbarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),

                  TextFormField(
                    controller: _phoneController,
                    inputFormatters: [maskFormatter],
                    keyboardType: TextInputType.number,
                    decoration: _getInputDecoration('Номер телефона'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите номер телефона';
                      }
                      if (value.length < 18) {
                        return 'Введите полный номер телефона';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: _getInputDecoration(
                      'Пароль',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[500],
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    validator: ValidationBuilder(localeName: 'ru').required('Введите пароль').minLength(8, 'Пароль должен содержать минимум 8 символов').build(),
                  ),
                  const SizedBox(height: 32),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.5),
                      children: <TextSpan>[
                        const TextSpan(text: 'Нажимая Далее, вы принимаете условия '),
                        TextSpan(
                          text: 'Политики конфиденциальности',
                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        const TextSpan(text: ' и '),
                        TextSpan(
                          text: 'Пользовательского соглашения',
                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        const TextSpan(text: ' и даете согласие на обработку персональных данных'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        _submitForm();
                      } catch (e) {
                        logger.e(e);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Далее',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
