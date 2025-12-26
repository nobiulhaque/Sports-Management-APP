import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Role {
  final String key;
  final String label;
  final String imagePath;
  final String route;

  const Role({
    required this.key,
    required this.label,
    required this.imagePath,
    required this.route,
  });
}

class RegularUserSetRoleController extends GetxController {
  // Selected role key (e.g. 'scout', 'coach', ...)
  final RxnString selectedRole = RxnString();

  // Loading state for when we persist / navigate
  final RxBool isLoading = false.obs;

  // Optional error message
  final RxnString errorMessage = RxnString();

  // Define available roles (update imagePath/route values as needed)
  final List<Role> roles = const [
    Role(
      key: 'scout',
      label: 'Scout',
      imagePath: 'assets/regular_user_type/u1.png',
      route: '/home-regular-user',
    ),
    Role(
      key: 'coach',
      label: 'Coach',
      imagePath: 'assets/regular_user_type/u2.png',
      route: '/home-coach',
    ),
    Role(
      key: 'player',
      label: 'Player',
      imagePath: 'assets/regular_user_type/u3.png',
      route: '/home-player',
    ),
    Role(
      key: 'analyst',
      label: 'Analyst',
      imagePath: 'assets/regular_user_type/u4.png',
      route: '/home-analyst',
    ),
    Role(
      key: 'journalist',
      label: 'Journalist',
      imagePath: 'assets/regular_user_type/u5.png',
      route: '/home-journalist',
    ),
    Role(
      key: 'parent',
      label: 'Parent',
      imagePath: 'assets/regular_user_type/u6.png',
      route: '/home-parent',
    ),
  ];

  // Key used when persisting the selected role
  static const String _kSavedRoleKey = 'user_role';

  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Try to load previously selected role (if any)
    final saved = _storage.read<String?>(_kSavedRoleKey);
    if (saved != null && saved.isNotEmpty) {
      selectedRole.value = saved;
    }
  }

  // Select a role (updates reactive state)
  void selectRole(String key) {
    selectedRole.value = key;
  }

  // Convenience to get Role model for the selected key
  Role? get selectedRoleModel {
    final key = selectedRole.value;
    if (key == null) return null;
    for (final r in roles) {
      if (r.key == key) return r;
    }
    return null;
  }

  // Persist selected role and navigate to its route
  Future<void> proceed() async {
    final key = selectedRole.value;
    if (key == null) {
      errorMessage.value = 'Please select a role first.';
      return;
    }

    final role = selectedRoleModel;
    if (role == null) {
      errorMessage.value = 'Selected role not found.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Persist the role (requires GetStorage.init() during app startup)
      await _storage.write(_kSavedRoleKey, key);

      // Navigate to the route for the selected role.
      if (role.route.isNotEmpty) {
        Get.offAllNamed(role.route);
      } else {
        // fallback route
        Get.offAllNamed('/home-regular-user');
      }
    } catch (e) {
      errorMessage.value = 'Failed to save role. Please try again.';
      // Optionally show a snackbar:
      // Get.snackbar('Error', errorMessage.value ?? 'Unknown error');
    } finally {
      isLoading.value = false;
    }
  }

  // Clear saved role (optional)
  Future<void> clearSavedRole() async {
    await _storage.remove(_kSavedRoleKey);
    selectedRole.value = null;
  }
}