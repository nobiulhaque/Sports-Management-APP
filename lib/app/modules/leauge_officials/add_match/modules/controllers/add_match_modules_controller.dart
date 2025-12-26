import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio; // Aliased to avoid conflicts
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kaldmv/app/data/models/my_league_referees_model.dart';
import 'package:kaldmv/core/services/api_service.dart';
import 'package:kaldmv/core/utils/utils.dart';

class AddMatchModulesController extends GetxController {
  
  // Text Controllers
  final team1NameController = TextEditingController();
  final team2NameController = TextEditingController();
  final matchStageController = TextEditingController();
  final divisionController = TextEditingController();
  final locationController = TextEditingController();
  final guidelinesController = TextEditingController();

  // Fees & Allowances
  final mainRefereeFeeController = TextEditingController();
  final mainRefereeTravelController = TextEditingController();
  final assReferee1FeeController = TextEditingController();
  final assReferee1TravelController = TextEditingController();
  final assReferee2FeeController = TextEditingController();
  final assReferee2TravelController = TextEditingController();
  final fourthOfficialFeeController = TextEditingController();
  final fourthOfficialTravelController = TextEditingController();

  final selectedDate = Rxn<DateTime>();
  final selectedTime = Rxn<TimeOfDay>();
  
  // Referee Selection
  final mainReferee = Rxn<MyLeagueRefereesData>();
  final assReferee1 = Rxn<MyLeagueRefereesData>();
  final assReferee2 = Rxn<MyLeagueRefereesData>();
  final fourthOfficial = Rxn<MyLeagueRefereesData>();

  final homeTeamLogo = Rxn<File>();
  final awayTeamLogo = Rxn<File>();
  final ImagePicker _picker = ImagePicker();
  final isLoading = false.obs;

  Future<void> pickImage(bool isHomeTeam) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (isHomeTeam) {
        homeTeamLogo.value = File(image.path);
      } else {
        awayTeamLogo.value = File(image.path);
      }
    }
  }

  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  void updateTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  Future<void> selectReferee(String role) async {
    String filterRole = '';
    switch (role) {
      case 'main':
        filterRole = 'MAIN_REFEREE';
        break;
      case 'ass1':
        filterRole = 'ASS_REFEREE1';
        break;
      case 'ass2':
        filterRole = 'ASS_REFEREE2';
        break;
      case 'fourth':
        filterRole = 'FOURTH_REFEREE';
        break;
    }

    // Navigate to list and wait for result
    // We expect the View to handle returning a Referee object or data if in selection mode
    final result = await Get.toNamed('/refereforleauge', arguments: {'isSelection': true, 'role': filterRole});
    
    if (result != null && result is MyLeagueRefereesData) {
      switch (role) {
        case 'main':
          mainReferee.value = result;
          break;
        case 'ass1':
          assReferee1.value = result;
          break;
        case 'ass2':
          assReferee2.value = result;
          break;
        case 'fourth':
          fourthOfficial.value = result;
          break;
      }
    }
  }

  Future<void> addMatch() async {
    if (team1NameController.text.isEmpty || team2NameController.text.isEmpty) {
     // Utils.snackBar('Error', 'Please enter team names');
      return;
    }
    if (selectedDate.value == null || selectedTime.value == null) {
      //Utils.snackBar('Error', 'Please select date and time');
      return;
    }
    
    if (mainReferee.value == null || assReferee1.value == null || assReferee2.value == null || fourthOfficial.value == null) {
      //Utils.snackBar('Error', 'Please select all referees');
      return;
    }
    // Add other validations as needed...

    try {
      isLoading.value = true;

      // Prepare Body Data JSON
      final bodyDataMap = {
        "team1Name": team1NameController.text,
        "team2Name": team2NameController.text,
        "matchStage": matchStageController.text.isNotEmpty ? matchStageController.text : "League Match",
        "division": divisionController.text.isNotEmpty ? divisionController.text : "Division 1",
        "matchDate": DateFormat('yyyy-MM-dd').format(selectedDate.value!),
        "matchTime": DateFormat('hh:mma').format(DateTime(2024, 1, 1, selectedTime.value!.hour, selectedTime.value!.minute)),
        "location": locationController.text,
        "mainRefereeFee": int.tryParse(mainRefereeFeeController.text) ?? 0,
        "mainRefereeTravelAllowance": int.tryParse(mainRefereeTravelController.text) ?? 0,
        "assReferee1Fee": int.tryParse(assReferee1FeeController.text) ?? 0,
        "assReferee1TravelAllowance": int.tryParse(assReferee1TravelController.text) ?? 0,
        "assReferee2Fee": int.tryParse(assReferee2FeeController.text) ?? 0,
        "assReferee2TravelAllowance": int.tryParse(assReferee2TravelController.text) ?? 0,
        "fourthOfficialRefereeFee": int.tryParse(fourthOfficialFeeController.text) ?? 0,
        "fourthOfficialRefereeTravelAllowance": int.tryParse(fourthOfficialTravelController.text) ?? 0,
        "guidelinesRequirements": guidelinesController.text,
        "mainRefereeId": mainReferee.value?.id, 
        "assReferee1Id": assReferee1.value?.id,
        "assReferee2Id": assReferee2.value?.id,
        "fourthOfficialId": fourthOfficial.value?.id,
      };

      print('Body Data: $bodyDataMap');

      // FormData
      final formData = dio.FormData.fromMap({
        'bodyData': jsonEncode(bodyDataMap),
      });

      if (homeTeamLogo.value != null) {
        formData.files.add(MapEntry(
          'team1Logo',
          await dio.MultipartFile.fromFile(homeTeamLogo.value!.path),
        ));
      }
      if (awayTeamLogo.value != null) {
        formData.files.add(MapEntry(
          'team2Logo',
          await dio.MultipartFile.fromFile(awayTeamLogo.value!.path),
        ));
      }

      final response = await ApiService().post(
        path: '/matches/add-matched',
        data: formData,
      );

      if (response != null && response['success'] == true) {
        showSuccessDialog();
      } else {
       // Utils.snackBar('Error', response?['message'] ?? 'Failed to create match');
      }

    } catch (e) {
     // Utils.snackBar('Error', 'Something went wrong: $e');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    team1NameController.clear();
    team2NameController.clear();
    matchStageController.clear();
    divisionController.clear();
    locationController.clear();
    guidelinesController.clear();
    mainRefereeFeeController.clear();
    mainRefereeTravelController.clear();
    assReferee1FeeController.clear();
    assReferee1TravelController.clear();
    assReferee2FeeController.clear();
    assReferee2TravelController.clear();
    fourthOfficialFeeController.clear();
    fourthOfficialTravelController.clear();
    
    selectedDate.value = null;
    selectedTime.value = null;
    mainReferee.value = null;
    assReferee1.value = null;
    assReferee2.value = null;
    fourthOfficial.value = null;
    homeTeamLogo.value = null;
    awayTeamLogo.value = null;
  }

  void showSuccessDialog() {
    Get.defaultDialog(
      title: "Success",
      middleText: "Match created successfully",
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close dialog
            Get.offNamed('/leage-official-matches'); // Navigate to matches
          },
          child: const Text("See All Matches"),
        ),
        TextButton(
          onPressed: () {
            clearForm();
            Get.back(); // Close dialog
          },
          child: const Text("Create another match"),
        ),
      ],
    );
  }
}
