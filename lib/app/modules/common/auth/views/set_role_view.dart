import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaldmv/app/modules/common/auth/controllers/auth_controller.dart';

class SetRoleView extends StatefulWidget {
  const SetRoleView({super.key});

  @override
  State<SetRoleView> createState() => _SetRoleViewState();
}

class _SetRoleViewState extends State<SetRoleView> {
  String? selectedRole;
  Map<String, dynamic>? registrationData;

  @override
  void initState() {
    super.initState();
    // Get registration data from arguments
    registrationData = Get.arguments as Map<String, dynamic>?;
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
              SizedBox(height: 32.h),
              // Title
              Text(
                'Select User Type',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              // Subtitle
              Text(
                'Select a profile type which match your activity.',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 40.h),
              // Role Cards
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Referee and Regular User Row
                      Row(
                        children: [
                          // Referee Card
                          Expanded(
                            child: _RoleCard(
                              imagePath: 'assets/role/refree.png',
                              label: 'Referee',
                              isSelected: selectedRole == 'referee',
                              onTap: () {
                                // Auto navigate to referee type selection
                                Get.toNamed('/referee-type', arguments: registrationData);
                              },
                            ),
                          ),
                          SizedBox(width: 16.w),
                          // Regular User Card
                          Expanded(
                            child: _RoleCard(
                              imagePath: 'assets/role/user.png',
                              label: 'Regular User',
                              isSelected: selectedRole == 'regular_user',
                              onTap: () {
                                setState(() {
                                  selectedRole = 'regular_user';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      // League Officials Card
                      Center(
                        child: SizedBox(
                          width: (MediaQuery.of(context).size.width - 64.w) / 2,
                          child: _RoleCard(
                            imagePath: 'assets/role/league_officials.png',
                            label: 'League Officials',
                            isSelected: selectedRole == 'league_officials',
                            onTap: () {
                              setState(() {
                                selectedRole = 'league_officials';
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Proceed Button
              if (selectedRole != null && selectedRole != 'referee')
                Padding(
                  padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (registrationData == null) {
                          Get.snackbar("Error", "Registration data not found");
                          return;
                        }

                        final authController = Get.find<AuthController>();
                        
                        if (selectedRole == 'regular_user') {
                          await authController.completeRegistration(
                            name: registrationData!['name'],
                            email: registrationData!['email'],
                            password: registrationData!['password'],
                            role: 'USER',
                          );
                        } else if (selectedRole == 'league_officials') {
                          await authController.completeRegistration(
                            name: registrationData!['name'],
                            email: registrationData!['email'],
                            password: registrationData!['password'],
                            role: 'LEAGUE_OFFICIALS',
                          );
                        }
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const _RoleCard({
    required this.imagePath,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: const Color(0xFFF3F4F6),
          border: isSelected
              ? Border.all(color: const Color(0xFF2563EB), width: 3)
              : null,
        ),
        child: Stack(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
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
          ],
        ),
      ),
    );
  }
}
