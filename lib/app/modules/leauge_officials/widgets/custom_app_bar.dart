import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// Make sure you have this import for your CustomSvgIcon

class CustomAppBarLeauge extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBarLeauge({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(80.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              // Back Button
              GestureDetector(
                onTap: () {Get.back();
                  print("Tap");
                } ,

                child: Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: const BoxDecoration(
                    color: Color(0xff1d9e1f7),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xfff1e3a8a),
                      size: 20.sp,
                    ),
                  ),
                ),
              ),

              // Title
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                        color: Color(0xFF111111),
                    ),
                  ),
                ),
              ),

              // Optional placeholder for right icon spacing
              SizedBox(
                width: 44.w,
                height: 44.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
