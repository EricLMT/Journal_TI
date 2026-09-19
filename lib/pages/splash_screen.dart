import 'package:flutter/material.dart';
import 'dart:async';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:journal_ti/utils/permissions_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';
import '/l10n/app_localizations.dart';

final logger = Logger();

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String version = '';

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    await _loadVersion();
    final locationGranted = await PermissionHelper.requestLocationPermission();
    final storageGranted = await PermissionHelper.requestStoragePermission();
    late AppLocalizations tr;


    if (!locationGranted || !storageGranted) {
      logger.i("Permission refusée. Ouverture des paramètres.");
      await openAppSettings();
      return;
    }
    tr = AppLocalizations.of(context)!;
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${tr.skbar_backup_message} '),
      duration: Duration(seconds: 3),
    ));

    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return; // Sécurité
    Navigator.pushReplacementNamed(context, '/journal');
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (!mounted) return; // Sécurité
    setState(() {
      version = '${info.version}+${info.buildNumber}';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  Text(
                    'Journal de TI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.satellite_alt),
                      SizedBox(width: 16),
                      Icon(Icons.signal_wifi_off),
                      SizedBox(width: 16),
                      Icon(Icons.track_changes),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Image.asset(
                    'assets/images/ti_banderole_trans.jpg',
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.transcribe),
                      SizedBox(width: 16),
                      Icon(Icons.voice_over_off),
                      SizedBox(width: 16),
                      Icon(Icons.wifi_off),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Version : $version',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
            ),
         ),
        ),
      ),
    );
  }
}
