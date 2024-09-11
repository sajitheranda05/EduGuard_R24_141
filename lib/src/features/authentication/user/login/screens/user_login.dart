import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/authentication/user/login/controllers/signin_controller.dart';
import 'package:eduguard/src/features/authentication/user/login/screens/forget_password.dart';
import 'package:eduguard/src/features/authentication/user/register/screens/student_register.dart';
import 'package:eduguard/src/features/authentication/user/register/screens/user_register.dart';
import 'package:eduguard/src/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLogin extends StatelessWidget {
  final dynamic roleType;

  const UserLogin({super.key, this.roleType});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(SignInController());

    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'EduguardLK',
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
                Text('SIGN IN', style: TextStyle(fontSize: 20.0))
              ],
            ),
            Form(
              key: loginController.loginFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    controller: loginController.email,
                    validator: (value) => AppValidations.validateEmail(value),
                    decoration: const InputDecoration(label: Text('Email')),
                  ),
                  Obx(
                    () => TextFormField(
                      controller: loginController.password,
                      validator: (value) =>
                          AppValidations.validatePassword(value),
                      obscureText: loginController.hidePassword.value,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        suffixIcon: IconButton(
                            onPressed: () {
                              loginController.hidePassword.value =
                                  !loginController.hidePassword.value;
                            },
                            icon: Icon(loginController.hidePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          value: loginController.rememberMe.value,
                          onChanged: (value) {
                            loginController.rememberMe.value =
                                !loginController.rememberMe.value;
                          }),
                    ),
                    const Text('Remember Me')
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Get.to(() => const ForgetPassword());
                    },
                    child: const Text('Forgot Password?')),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  loginController.emailandPasswordSignIn(roleType);
                },
                child: const Text('SIGN IN'),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  roleType =="STUDENT" ?  Get.to(() => const StudentSignUp()) :
                  Get.to(() => const UserSignUp());
                },
                child: const Text('Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
