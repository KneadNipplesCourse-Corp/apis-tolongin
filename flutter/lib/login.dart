import 'package:flutter/material.dart';
import 'package:flutter_restapi/controller/product_controller.dart';
import 'package:flutter_restapi/products.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final ProductController controller = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // A light background color
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- App Logo/Icon ---
              Icon(Icons.lock_person, size: 100, color: Colors.blueAccent),
              const SizedBox(height: 30),

              // --- Welcome Text ---
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sign in to continue",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // --- Email Input Field ---
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // --- Password Input Field ---
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // --- Login Button ---
              Obx(
                () => SizedBox(
                  width: double.infinity, // Make button full width
                  child: ElevatedButton(
                    onPressed:
                        controller
                                .isLoading
                                .value // Use isLoading for button state
                            ? null
                            : () async {
                              final email =
                                  emailController.text
                                      .trim(); // Trim whitespace
                              final password =
                                  passwordController.text
                                      .trim(); // Trim whitespace

                              if (email.isEmpty || password.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  'Please enter both email and password.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              await controller.login(email, password);
                              if (controller.isLoggedIn.value) {
                                Get.offAllNamed('/products');
                              } else {
                                Get.snackbar(
                                  'Login Failed',
                                  'Invalid email or password. Please try again.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white,
                                );
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blueAccent, // Button background color
                      foregroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5, // Add a subtle shadow
                    ),
                    child:
                        controller.isLoading.value
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'Login',
                              style: TextStyle(fontSize: 18),
                            ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center),
            ],
          ),
        ),
      ),
    );
  }
}
