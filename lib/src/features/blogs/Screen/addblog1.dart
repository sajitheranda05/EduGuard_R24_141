import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/authentication/user/register/controllers/signup_controller.dart';
import 'package:eduguard/src/features/authentication/user/register/screens/email_verification.dart';
import 'package:eduguard/src/features/blogs/controllers/blogcontroller.dart';
import 'package:eduguard/src/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addblog1 extends StatelessWidget {
  const Addblog1({super.key});

  @override
  Widget build(BuildContext context) {
    final Addblogcontroller = Get.put(SignUpController());

    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /* Text(
                    'EduguardLK',
                    style:
                        TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  ),*/
                  Text('ADD YOUR BLOG',
                      style: TextStyle(
                          fontSize: 28.0, fontWeight: FontWeight.bold))
                ],
              ),
              const SizedBox(height: 24.0),
              Form(
                  key: Addblogcontroller.signupFormKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: Addblogcontroller.firstName,
                              validator: (value) =>
                                  AppValidations.validateEmptyText(
                                      'Blog Name', value),
                              expands: false,
                              decoration: const InputDecoration(
                                  label: Text('Blog Name')),
                              obscureText: false,
                              maxLength: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: Addblogcontroller.lastName,
                              validator: (value) =>
                                  AppValidations.validateEmptyText(
                                      'Blog', value),
                              expands: false,
                              decoration:
                                  const InputDecoration(label: Text('Blog')),
                              obscureText: false,
                              maxLength: 1000,
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: Addblogcontroller.age,
                        validator: (value) => AppValidations.validateEmptyText(
                            'Blogger Name', value),
                        decoration:
                            const InputDecoration(label: Text('Blogger Name')),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),

                      /*TextFormField(
                        controller: signUpcontroller.email,
                        validator: (value) => AppValidations.validateEmail(value),
                        decoration: const InputDecoration(label: Text('Email')),
                      ),
                      const SizedBox(height: 12.0,),*/

                      /*TextFormField(
                        controller: signUpcontroller.contactNumber,
                        validator: (value) => AppValidations.validatePhoneNumber(value),
                        decoration: const InputDecoration(label: Text('Contact Number')),
                      ),
                      const SizedBox(height: 12.0,),*/

                      /* Obx(
                        () => TextFormField(
                          controller: Addblogcontroller.password,
                          validator: (value) =>
                              AppValidations.validatePassword(value),
                          obscureText: Addblogcontroller.hidePassword.value,
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  Addblogcontroller.hidePassword.value =
                                      !Addblogcontroller.hidePassword.value;
                                },
                                icon: Icon(Addblogcontroller.hidePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                          ),
                        ),
                      ),*/
                      /*const SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 21,
                            child: Obx(
                              () => Checkbox(
                                  value: Addblogcontroller.termsCheck.value,
                                  onChanged: (value) =>
                                      Addblogcontroller.termsCheck.value =
                                          !Addblogcontroller.termsCheck.value),
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          const Text(
                              'I agree to privacy policy and terms of use'),
                        ],
                      ),*/
                      const SizedBox(
                        height: 24.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            //Get.to(() => const EmailVerification());
                            Addblogcontroller.signup();
                          },
                          child: const Text('Add The Blog'),
                        ),
                      )
                      /*SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const EmailVerification());
                            //signUpcontroller.signup();
                          },
                          child: const Text('Email Verification'),
                        ),
                      ),*/
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
