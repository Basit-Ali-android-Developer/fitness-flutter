import 'package:fitness/core/constants/app_colors.dart';
import 'package:fitness/core/constants/request_status.dart';
import 'package:fitness/core/network/repository.dart';
import 'package:fitness/core/utils/toast_helper.dart';
import 'package:fitness/core/widgets/primary_button.dart';
import 'package:fitness/screens/dashboard/presentation/screen/dashboard_Screen.dart';
import 'package:fitness/screens/profile/logic/complete_profile_cubit.dart';
import 'package:fitness/screens/profile/logic/complete_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfile> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _ageController = TextEditingController();
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteProfileCubit(AuthRepositoryImpl()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.maybePop(context),
          ),
        ),
        body: SafeArea(
          child: BlocListener<CompleteProfileCubit, CompleteProfileState>(
            // Only fire toast when status actually changes
            listenWhen: (previous, current) => previous.status != current.status,
            listener: (context, state) {
              if (state.status == RequestStatus.error) {
                ToastHelper.showError(
                  context,
                  state.errorMessage ?? 'Failed to update profile',
                );
              } else if (state.status == RequestStatus.success) {
                ToastHelper.showSuccess(
                  context,
                  'Profile completed successfully!',
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const DashboardScreen()),
                      (route) => false,
                );
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Let's complete your\nprofile",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "We use this information to calculate your personal daily calorie and macro goals with medical-grade precision.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6C757D),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Inputs static to screen rebuilds
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            label: "Height",
                            controller: _heightController,
                            hintText: "160",
                            unit: "cm",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildInputField(
                            label: "Weight",
                            controller: _weightController,
                            hintText: "56",
                            unit: "kg",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    _buildInputField(
                      label: "Age",
                      controller: _ageController,
                      hintText: "26",
                      unit: "years",
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Gender Identity",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Isolated BlocBuilder for Gender Selector only

                    BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
                      buildWhen: (previous, current) =>
                      previous.selectedGender != current.selectedGender,
                      builder: (context, state) {
                        final cubit = context.read<CompleteProfileCubit>();
                        return Row(
                          children: ['Male', 'Female', 'Other'].map((gender) {
                            final isSelected = state.selectedGender == gender;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => cubit.selectGender(gender),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 4),
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryGreen
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.02),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      gender,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? AppColors.primaryGreen
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 28),

                    // Privacy Banner
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE8F5E9),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/privacy_svg.svg',
                              width: 22,
                              height: 22,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primaryGreen,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Privacy first",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Your data is encrypted and only used to personalize your wellness journey. You can update this anytime in settings.",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF6C757D),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Isolated BlocBuilder for Submit Button
                    BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
                      buildWhen: (previous, current) =>
                      previous.status != current.status,
                      builder: (context, state) {
                        final cubit = context.read<CompleteProfileCubit>();
                        final isLoading = state.status == RequestStatus.loading;

                        return PrimaryButton(
                          title: "Continue",
                          isLoading: isLoading,
                          backgroundColor: AppColors.primaryGreen,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.submitProfile(
                                height: _heightController.text.trim(),
                                weight: _weightController.text.trim(),
                                age: _ageController.text.trim(),
                              );
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required String unit,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFA0AEC0),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    unit,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF718096),
                    ),
                  ),
                ],
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.primaryGreen,
                width: 1.5,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Required";
            }
            return null;
          },
        ),
      ],
    );
  }
}