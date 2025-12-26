
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  
  // Suppress specific image loading errors
  FlutterError.onError = (FlutterErrorDetails details) {
    if (!details.toString().contains('HTTP request failed, statusCode: 403')) {
      FlutterError.presentError(details);
    }
  };
  
  runApp(const MyApp());
}



