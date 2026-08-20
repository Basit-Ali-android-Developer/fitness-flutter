import 'package:fitness/core/constants/request_status.dart';
import 'package:fitness/core/network/repository.dart';
import 'package:fitness/core/utils/toast_helper.dart';
import 'package:fitness/core/widgets/primary_button.dart';
import 'package:fitness/core/widgets/primary_text_field.dart';
import 'package:fitness/screens/auth/logic/login_cubit.dart';
import 'package:fitness/screens/auth/logic/login_state.dart';
import 'package:fitness/screens/profile/presentation/screen/complete_profile.dart';
import 'package:fitness/screens/signup/presentation/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/core/constants/app_colors.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(AuthRepositoryImpl()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Form(
                key: _formKey,
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state.status == RequestStatus.error) {
                      ToastHelper.showError(
                        context,
                        state.errorMessage ?? 'Login Failed',
                      );
                    } else if (state.status == RequestStatus.success) {
                      ToastHelper.showSuccess(context, 'Login successfully!');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => CompleteProfile()),
                            (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state.status == RequestStatus.loading;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),


                        const Text(
                          "Vitality Logic",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGreen,
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),


                        const SizedBox(height: 6),


                        const Text(
                          "Continue your journey to peak vitality.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6C757D),
                          ),
                        ),


                        const SizedBox(height: 24),


                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  'assets/images/login_image.png',
                                  height: 140,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Email Label & Input
                              const Text(
                                "Email Address",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black800,
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
                                    return "Please enter your email";
                                  }
                                  if (!value.contains('@')) {
                                    return "Please enter a valid email";
                                  }
                                  return null;
                                },
                              ),


                              const SizedBox(height: 16),

                              // Password Label & Input
                              const Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black800,
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
                                        .read<LoginCubit>()
                                        .togglePasswordVisibility();
                                  },
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter your password";
                                  }
                                  if (value.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                              ),


                              const SizedBox(height: 24),

                              // Login Button
                              PrimaryButton(
                                title: "Login",
                                isLoading: isLoading,
                                backgroundColor: AppColors.primaryGreen,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<LoginCubit>().login(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Don't have an account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
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
                                    builder: (context) =>  SignUpScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: AppColors.primaryGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),


                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "By logging in, you agree to our Terms of Service and Privacy Policy. Vitality Logic ensures your health data is encrypted and secure.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFFA0AEC0),
                              height: 1.4,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
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