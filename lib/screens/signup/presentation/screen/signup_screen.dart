import 'package:fitness/core/constants/request_status.dart';
import 'package:fitness/core/network/repository.dart';
import 'package:fitness/core/utils/toast_helper.dart';
import 'package:fitness/core/widgets/primary_button.dart';
import 'package:fitness/core/widgets/primary_text_field.dart';
import 'package:fitness/screens/auth/presentation/screen/login_screen.dart';
import 'package:fitness/screens/signup/logic/signup_cubit.dart';
import 'package:fitness/screens/signup/logic/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/core/constants/app_colors.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(AuthRepositoryImpl()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Form(
                key: _formKey,
                child: BlocConsumer<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state.status == RequestStatus.error) {
                      ToastHelper.showError(
                        context,
                        state.errorMessage ?? 'Signup Failed',
                      );
                    } else if (state.status == RequestStatus.success) {
                      ToastHelper.showSuccess(
                        context,
                        'Account created successfully!',
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state.status == RequestStatus.loading;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),

                        // App Brand Title
                        // const Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     "Vitality Logic",
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //       color: SignUpScreen.primaryGreen,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20),


                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/signup_image.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Title & Subtitle
                        const Text(
                          "Join Vitality Logic",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Start your journey towards a healthier,\nmore balanced lifestyle today.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6C757D),
                              height: 1.3,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Full Name
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Full Name",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        PrimaryTextField(
                          controller: _nameController,
                          hintText: "John Doe",
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Email Address
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Email Address",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        PrimaryTextField(
                          controller: _emailController,
                          hintText: "name@example.com",
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Email is required";
                            }
                            if (!value.contains('@')) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Password
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        PrimaryTextField(
                          controller: _passwordController,
                          hintText: "••••••••",
                          prefixIcon: Icons.lock_outline,
                          isObscure: state.isPasswordObscured,
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isPasswordObscured
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: const Color(0xFF718096),
                              size: 20,
                            ),
                            onPressed: () {
                              context
                                  .read<SignupCubit>()
                                  .togglePasswordVisibility();
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Password is required";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Terms and Conditions Checkbox Row
                        FormField<bool>(
                          initialValue: _agreedToTerms,
                          validator: (value) {
                            if (!_agreedToTerms) {
                              return "You must accept the terms & conditions";
                            }
                            return null;
                          },
                          builder: (formFieldState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: _agreedToTerms,
                                        activeColor: AppColors.primaryGreen,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            _agreedToTerms = value ?? false;
                                          });
                                          formFieldState
                                              .didChange(_agreedToTerms);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),

                                    Expanded(
                                      child: Wrap(
                                        children: [
                                          const Text(
                                            "I agree to the ",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF4A5568),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: const Text(
                                              "Terms of Service ",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryGreen,
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            "and ",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF4A5568),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: const Text(
                                              "Privacy Policy.",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryGreen,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (formFieldState.hasError) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    formFieldState.errorText!,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.error,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 40),

                        // Create Account Primary Button
                        PrimaryButton(
                          title: "Create Account",
                          isLoading: isLoading,
                          backgroundColor: AppColors.primaryGreen,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignupCubit>().signUp(
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 48),

                        // Already have an account? Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF4A5568),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: AppColors.primaryGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}