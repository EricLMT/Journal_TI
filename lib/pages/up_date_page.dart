import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final logger = Logger();

  final String versionUrl = "https://www.cybersociety.be/journal_ti/version.txt";
  final String apkDownloadUrl = "https://www.cybersociety.be/journal_ti/journal_ti_release.apk";

  String _remoteVersion = '';
  String _localVersion = '';
  bool _hasUpdate = false;
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkForUpdate());
  }

  Future<void> checkForUpdate() async {
    final tr = AppLocalizations.of(context)!;

    try {
      final response = await http.get(Uri.parse(versionUrl));
      if (response.statusCode == 200) {
        _remoteVersion = response.body.trim();
        _localVersion = await getLocalVersion();
        logger.e("HTTP response : ${response.statusCode}");
        logger.e("Remote version : ${_remoteVersion}");
        logger.e("Locale version : ${_localVersion}");
        if (_remoteVersion != _localVersion) {
          setState(() {
            _hasUpdate = true;
            _checked = true;
          });
          _showUpdateDialog(tr);
        } else {
          setState(() {
            _hasUpdate = false;
            _checked = true;
          });
        }
      } else {
        logger.e("Erreur HTTP : ${response.statusCode}");
        setState(() {
          _checked = true;
        });
      }
    } catch (e) {
      logger.e("Erreur de mise à jour : $e");
      setState(() {
        _checked = true;
      });
    }
  }

  Future<String> getLocalVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version.trim();
  }

  void _showUpdateDialog(AppLocalizations tr) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(tr.app_update_page),
        content: Text('${tr.app_update_available} ($_remoteVersion)'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(tr.button_cancel),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.download),
            label: Text(tr.app_update_button),
            onPressed: () {
              Navigator.of(ctx).pop();
              _launchApkDownload();
            },
          ),
        ],
      ),
    );
  }

  void _launchApkDownload() async {
    final tr = AppLocalizations.of(context)!;

    final uri = Uri.parse(apkDownloadUrl);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      logger.e("Erreur lors de l'ouverture du lien de téléchargement : $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr.skbar_update_false)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(tr.app_update_page)),
      body: Center(
        child: _checked
            ? Text(
          _hasUpdate
              ? '${tr.app_update_available} ($_remoteVersion)'
              : tr.skbar_update_isupdate,
          style: const TextStyle(fontSize: 16),
        )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
