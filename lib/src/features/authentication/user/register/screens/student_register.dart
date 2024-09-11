import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';
import '../controllers/student_signup_conroller.dart';

class StudentSignUp extends StatefulWidget {
  const StudentSignUp({super.key});

  @override
  _StudentSignUpState createState() => _StudentSignUpState();
}

class _StudentSignUpState extends State<StudentSignUp> {
  final signUpController = Get.put(StudentSignUpController());

  // Variables to manage the selected gender and marital status
  String selectedGender = 'Male'; // Default value
  String selectedMaritalStatus = 'Single'; // Default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: signUpController.signupFormKey,
            child: Column(
              children: [
                const Text(
                  'EduguardLK',
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
                const Text('SIGN UP', style: TextStyle(fontSize: 20.0)),
                const SizedBox(height: 24.0),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: signUpController.firstName,
                        decoration:
                            const InputDecoration(label: Text('First Name')),
                        validator: (value) => value!.isEmpty
                            ? 'First Name cannot be empty'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: TextFormField(
                        controller: signUpController.lastName,
                        decoration:
                            const InputDecoration(label: Text('Last Name')),
                        validator: (value) => value!.isEmpty
                            ? 'Last Name cannot be empty'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),

                TextFormField(
                  controller: signUpController.age,
                  decoration: const InputDecoration(label: Text('Age')),
                  validator: (value) =>
                      value!.isEmpty ? 'Age cannot be empty' : null,
                ),
                const SizedBox(height: 12.0),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  items: ['Male', 'Female', 'Other'].map((gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                  decoration: const InputDecoration(label: Text('Gender')),
                  validator: (value) =>
                      value == null ? 'Please select your gender' : null,
                ),
                const SizedBox(height: 12.0),

                // Marital Status Dropdown
                DropdownButtonFormField<String>(
                  value: selectedMaritalStatus,
                  items: ['Single', 'Married', 'Divorced'].map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMaritalStatus = value!;
                    });
                  },
                  decoration:
                      const InputDecoration(label: Text('Marital Status')),
                  validator: (value) => value == null
                      ? 'Please select your marital status'
                      : null,
                ),
                const SizedBox(height: 12.0),

                TextFormField(
                  controller: signUpController.email,
                  decoration: const InputDecoration(label: Text('Email')),
                  validator: (value) =>
                      value!.isEmpty ? 'Email cannot be empty' : null,
                ),
                const SizedBox(height: 12.0),

                TextFormField(
                  controller: signUpController.contactNumber,
                  decoration:
                      const InputDecoration(label: Text('Contact Number')),
                  validator: (value) => value!.isEmpty
                      ? 'Contact number is required'
                      : null,
                ),
                const SizedBox(height: 12.0),

                // Emergency Contacts
                TextFormField(
                  controller: signUpController.emergencyContacts,
                  decoration: const InputDecoration(
                    label: Text('Emergency Contacts'),
                    hintText: 'Enter comma-separated contacts',
                  ),
                  validator: (value) => value!.isEmpty
                      ? 'Emergency Contacts cannot be empty'
                      : null,
                ),
                const SizedBox(height: 12.0),

                Obx(() => TextFormField(
                      controller: signUpController.password,
                      obscureText: signUpController.hidePassword.value,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        suffixIcon: IconButton(
                          icon: Icon(signUpController.hidePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            signUpController.hidePassword.value =
                                !signUpController.hidePassword.value;
                          },
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Password cannot be empty' : null,
                    )),
                const SizedBox(height: 24.0),

                Obx(() => CheckboxListTile(
                      title:
                          const Text('I agree to privacy policy and terms of use'),
                      value: signUpController.termsCheck.value,
                      onChanged: (value) {
                        signUpController.termsCheck.value = value!;
                      },
                    )),
                const SizedBox(height: 24.0),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (signUpController.signupFormKey.currentState!
                          .validate()) {
                        signUpController.signup();
                      }
                    },
                    child: const Text('Create Account'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
