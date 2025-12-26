import 'package:get/get.dart';
import 'package:kaldmv/app/data/service/drawer_service.dart';

class SideDrawerController extends GetxController {
  SideDrawerController(this._drawerService);

  final DrawerService _drawerService;

  // State
  final isLoading = true.obs;
  final name = 'Loading...'.obs;
  final email = 'Loading...'.obs;
  final image = ''.obs;
  final role = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDrawerData();
  }

  Future<void> loadDrawerData() async {
    try {
      isLoading.value = true;
      final data = await _drawerService.fetchDrawerProfileDetails();

      name.value = data['name'] ?? 'Unknown';
      email.value = data['email'] ?? 'example@mail.com';
      image.value = data['image'] ?? '';
      role.value = data['role'] ?? '';

      print("✅ Drawer data updated");
    } catch (e) {
      print("❌ Error loading drawer data: $e");
      // Keep default values on error
      name.value = 'Profile';
      email.value = 'Unable to load';
    } finally {
      isLoading.value = false;
    }
  }
}
