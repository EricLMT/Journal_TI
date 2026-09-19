import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';

final logger = Logger();


class PermissionHelper {
  static bool _isRequesting = false;

  static Future<bool> requestStoragePermission() async {
    if (_isRequesting) return false;
    _isRequesting = true;
    try {
      final status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        logger.i("Permission ExternalStorage refusée. Aller dans les paramètres.");
      }
      return status.isGranted;
    } finally {
      _isRequesting = false;
    }
  }

  static Future<bool> requestLocationPermission() async {
    if (_isRequesting) return false;
    _isRequesting = true;
    try {
      final status = await Permission.location.request();
      if (!status.isGranted) {
        logger.i("Permission Location refusée. Aller dans les paramètres.");
      }
      return status.isGranted;
    } finally {
      _isRequesting = false;
    }
  }
}