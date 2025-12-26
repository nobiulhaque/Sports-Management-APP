import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kaldmv/app/modules/leauge_officials/add_match/modules/views/widgets/compansation_card.dart';
import 'package:kaldmv/app/modules/leauge_officials/add_match/modules/views/widgets/roleTile.dart';
import 'package:kaldmv/core/constants/app_colors.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../home_leauge/views/widgets/custom_infoCard.dart';
import '../../../widgets/custom_app_bar.dart';
import '../controllers/add_match_modules_controller.dart';

class AddMatchModulesView extends GetView<AddMatchModulesController> {
   AddMatchModulesView({super.key});
  final controller = Get.put(AddMatchModulesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBarLeauge(title: "Add Matches"),
      body: Obx(() {
        if (controller.isLoading.value) {
           return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomInfoCard(
                icon: const Icon(Icons.sports_soccer, size: 18, color: Colors.black),
                title: "Match Information",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputCard(
                      title: "Teams Name",
                      child: Row(
                        children: [
                          Expanded(child: _buildTextField("FC Dallas", controller: controller.team1NameController)),
                          const SizedBox(width: 16),
                          const Text(
                            "VS",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 16),
                          Expanded(child: _buildTextField("LA Galaxy", controller: controller.team2NameController)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInputCard(title: "Match Stage", child: _buildTextField("Quarter Final", controller: controller.matchStageController)),
                    const SizedBox(height: 24),
                    _buildInputCard(title: "Division", child: _buildTextField("Division Name", controller: controller.divisionController)),
                    const SizedBox(height: 32),
                    _buildLogoUploadSection(),
                    const SizedBox(height: 24),
                    _buildInputCard(
                      title: "Date / Time",
                      child: Row(
                        children: [
                          Expanded(child: _buildDatePicker(context)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildTimePicker(context)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInputCard(
                      title: "Set Location",
                      child: _buildTextField("National Sports Complex", controller: controller.locationController),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              CustomInfoCard(
                icon: const Icon(Icons.sports_soccer_outlined, color: AppColors.primary),
                title: "Add Compensation",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AllowanceCard(
                      allowanceTitles: const ['Referee', 'Travel Allowance'],
                      controllers: [controller.mainRefereeFeeController, controller.mainRefereeTravelController],
                    ),
                    const SizedBox(height: 20),
                    AllowanceCard(
                      allowanceTitles: const ['Asst. Referee 1', 'Travel Allowance'],
                      controllers: [controller.assReferee1FeeController, controller.assReferee1TravelController],
                    ),
                    const SizedBox(height: 20),
                    AllowanceCard(
                      allowanceTitles: const ['Asst. Referee 2', 'Travel Allowance'],
                      controllers: [controller.assReferee2FeeController, controller.assReferee2TravelController],
                    ),
                    const SizedBox(height: 20),
                    AllowanceCard(
                      allowanceTitles: const ['4th Official', 'Travel Allowance'],
                      controllers: [controller.fourthOfficialFeeController, controller.fourthOfficialTravelController],
                    ),
                  ],
                ),
              ),
              CustomInfoCard(
                icon:  Icon(Icons.sports_soccer_outlined, color: AppColors.primary),
                title: "Add Referees",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => RoleTile(
                      label: controller.mainReferee.value != null 
                          ? "Referee: ${controller.mainReferee.value?.referee?.user?.name}" 
                          : "Referee",
                      iconPath: "assets/icons/refreee.png",
                      onTap: () => controller.selectReferee('main'),
                    )),
                    Obx(() => RoleTile(
                      label: controller.assReferee1.value != null 
                          ? "Asst. Referee 1: ${controller.assReferee1.value?.referee?.user?.name}" 
                          : "Asst. Referee 1",
                      iconPath: "assets/icons/refreee.png",
                      onTap: () => controller.selectReferee('ass1'),
                    )),
                    Obx(() => RoleTile(
                      label: controller.assReferee2.value != null 
                          ? "Asst. Referee 2: ${controller.assReferee2.value?.referee?.user?.name}" 
                          : "Asst. Referee 2",
                      iconPath: "assets/icons/refreee.png",
                      onTap: () => controller.selectReferee('ass2'),
                    )),
                    Obx(() => RoleTile(
                      label: controller.fourthOfficial.value != null 
                          ? "4th Official: ${controller.fourthOfficial.value?.referee?.user?.name}" 
                          : "4th Official",
                      iconPath: "assets/icons/refreee.png",
                      onTap: () => controller.selectReferee('fourth'),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildInputCard(title: "Match Guidelines & Requirements", child: _buildTextField("write text", controller: controller.guidelinesController)),
              ),

              const SizedBox(height: 20),
              Utils.primaryButton(
                context: context,
                title: "Submit",
                onTap: () {
                   controller.addMatch();
                },
                backgroundColor: AppColors.primary,
                textColor: AppColors.white,
                radius: 8,
                width: 335,
                height: 50,
                fontSize: 18,
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }

  // ------------------Widgets-----------------

  Widget _buildInputCard({required String title, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, {TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2)),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: Color(0xFF1E3A8A)),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          controller.updateDate(picked);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF1E3A8A), width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.grey[500], size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Obx(() => Text(
                controller.selectedDate.value != null
                    ? DateFormat('dd/MM/yyyy').format(controller.selectedDate.value!)
                    : "Date",
                style: TextStyle(
                  color: controller.selectedDate.value != null ? Colors.black87 : Colors.grey[500],
                  fontSize: 16,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: Color(0xFF1E3A8A)),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          controller.updateTime(picked);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF1E3A8A), width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.access_time, color: Colors.grey[500], size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Obx(() => Text(
                controller.selectedTime.value != null
                    ? controller.selectedTime.value!.format(context)
                    : "Time",
                style: TextStyle(
                  color: controller.selectedTime.value != null ? Colors.black87 : Colors.grey[500],
                  fontSize: 16,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoUploadSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: ShapeDecoration(
        color: const Color(0xFFF9FAFB),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Teams Logo',
            style: TextStyle(
              color: Color(0xFF495565),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.33,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Obx(() => _buildSingleLogoUpload(
                imageFile: controller.homeTeamLogo.value,
                onTap: () => controller.pickImage(true),
              )),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'VS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Obx(() => _buildSingleLogoUpload(
                imageFile: controller.awayTeamLogo.value,
                onTap: () => controller.pickImage(false),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSingleLogoUpload({File? imageFile, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          color: const Color(0xFFF1F5FF),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF1E3A8A)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: imageFile != null 
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                imageFile, 
                height: 100, 
                width: double.infinity, 
                fit: BoxFit.cover
              ),
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Icon(Icons.cloud_upload_outlined, size: 32, color: Color(0xFF61758A)),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Upload Team Logo',
                  style: TextStyle(
                    color: Color(0xFF61758A),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF8E9ECB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: const Text(
                    'Add Attachment',
                    style: TextStyle(
                      color: Color(0xFFF9F9F9),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}