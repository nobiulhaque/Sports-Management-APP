import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaldmv/app/widgets/custom_profile_card.dart';

class RegularProfileHeaderCard extends StatelessWidget {
  final String name;
  final String email;
  final String profession;
  final String location;
  final String imagePath;

  const RegularProfileHeaderCard({
    required this.name,
    required this.email,
    required this.profession,
    required this.location,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomProfileCard(
        elevation: 2,
        color: const Color.fromARGB(255, 24, 58, 131),
        borderRadius: 20,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              CircleAvatar(
                radius: 45.r,
                backgroundColor: Colors.white24,
                backgroundImage:
                    imagePath.isNotEmpty && imagePath.startsWith('http')
                    ? NetworkImage(imagePath) as ImageProvider
                    : AssetImage(
                        imagePath.isNotEmpty
                            ? imagePath
                            : 'assets/images/u3.png',
                      ),
                child: imagePath.isEmpty
                    ? Icon(Icons.person, color: Colors.white, size: 40.r)
                    : null,
              ),
              SizedBox(height: 12.h),
              Text(
                name,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                email,
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
              ),
              Text(
                profession,
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
              ),
              Text(
                location,
                style: TextStyle(fontSize: 14.sp, color: Colors.white70),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
