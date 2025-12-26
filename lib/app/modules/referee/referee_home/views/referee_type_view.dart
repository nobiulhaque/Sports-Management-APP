import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/common/auth/controllers/auth_controller.dart';

class RefereeTypeView extends StatefulWidget {
  const RefereeTypeView({super.key});

  @override
  State<RefereeTypeView> createState() => _RefereeTypeViewState();
}

class _RefereeTypeViewState extends State<RefereeTypeView> {
  String? selectedType;
  Map<String, dynamic>? registrationData;

  @override
  void initState() {
    super.initState();
    // Get registration data from arguments
    registrationData = Get.arguments as Map<String, dynamic>?;
  }

  // Map UI selection to API role values
  String _getRoleForAPI(String selectedType) {
    switch (selectedType) {
      case 'referee':
        return 'MAIN_REFEREE';
      case 'asst_referee_01':
        return 'ASS_REFEREE1';
      case 'asst_referee_02':
        return 'ASS_REFEREE2';
      case '4th_official':
        return 'FOURTH_REFEREE';
      default:
        return 'MAIN_REFEREE';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              InkWell(
                onTap: () => Get.back(),
                child: Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EAF6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 20.sp,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              // Title
              Text(
                'Select Referee Type:',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15.h),
              // Referee Type Cards
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Referee and Asst. Referee 01 Row
                      Row(
                        children: [
                          // Referee Card
                          Expanded(
                            child: _RefereeTypeCard(
                              imagePath: 'assets/role/refree.png',
                              label: 'Main Referee',
                              isSelected: selectedType == 'referee',
                              onTap: () {
                                setState(() {
                                  selectedType = 'referee';
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 16.w),
                          // Asst. Referee 01 Card
                          Expanded(
                            child: _RefereeTypeCard(
                              imagePath: 'assets/role/asst_referee1.png',
                              label: 'Asst. Referee 01',
                              isSelected: selectedType == 'asst_referee_01',
                              onTap: () {
                                setState(() {
                                  selectedType = 'asst_referee_01';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      // Asst. Referee 02 and 4th Official Row
                      Row(
                        children: [
                          // Asst. Referee 02 Card
                          Expanded(
                            child: _RefereeTypeCard(
                              imagePath: 'assets/role/asst_referee2.png',
                              label: 'Asst. Referee 02',
                              isSelected: selectedType == 'asst_referee_02',
                              onTap: () {
                                setState(() {
                                  selectedType = 'asst_referee_02';
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 16.w),
                          // 4th Official Card
                          Expanded(
                            child: _RefereeTypeCard(
                              imagePath: 'assets/role/4th_official.png',
                              label: 'Fourth Referee Official',
                              isSelected: selectedType == '4th_official',
                              onTap: () {
                                setState(() {
                                  selectedType = '4th_official';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              // Proceed Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: selectedType == null
                      ? null
                      : () async {
                          if (registrationData == null) {
                            Get.snackbar("Error", "Registration data not found");
                            return;
                          }

                          final authController = Get.find<AuthController>();
                          final apiRole = _getRoleForAPI(selectedType!);

                          // Complete registration with referee role
                          await authController.completeRegistration(
                            name: registrationData!['name'],
                            email: registrationData!['email'],
                            password: registrationData!['password'],
                            role: apiRole,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    disabledBackgroundColor: const Color(0xFFE5E7EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _RefereeTypeCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RefereeTypeCard({
    required this.imagePath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E3A8A) : Colors.transparent,
            width: 2,
          ),
          color: const Color(0xFFF3F4F6),
        ),
        child: Stack(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(7.r),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 200.h,
                    color: const Color(0xFFF3F4F6),
                    child: const Icon(Icons.person, size: 80),
                  );
                },
              ),
            ),
            // Label overlay at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  label,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Selected checkmark
            if (isSelected)
              Positioned(
                top: 7.h,
                right: 7.w,
                child: Icon(Icons.check_circle_outline,color: Color(0xFF1E3A8A),)
              ),
          ],
        ),
      ),
    );
  }
}
