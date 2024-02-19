import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingProvider extends ChangeNotifier {
  late PermissionStatus scheduleExactTimePermission;
  late PermissionStatus notificationPermission;
  
  SettingProvider() {
    init();
  }

  Future<void> init() async {
    scheduleExactTimePermission = await Permission.scheduleExactAlarm.status;
    notificationPermission = await Permission.notification.status;
    print("scheduleExactTimePermission: $scheduleExactTimePermission");
    print("notificationPermission: $notificationPermission");
    notifyListeners();
  }
}
