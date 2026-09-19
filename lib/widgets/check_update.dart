import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:journal_ti/utils/locale_language.dart';
import '/l10n/app_localizations.dart';
import 'package:logger/logger.dart';



final logger = Logger();
class UpdateChecker extends StatefulWidget {
  const UpdateChecker({Key? key}) : super(key: key);

  @override
  State<UpdateChecker> createState() => _UpdateCheckerState();
}

class _UpdateCheckerState extends State<UpdateChecker> {
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
    checkForUpdate();
    //WidgetsBinding.instance.addPostFrameCallback((_) => checkForUpdate());
  }

  Future<void> checkForUpdate() async {
    final tr = AppLocalizations.of(context)!;

    try {
      final response = await http.get(Uri.parse(versionUrl));
      if (response.statusCode == 200) {
        _remoteVersion = response.body.trim();
        _localVersion = await getLocalVersion();

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
        logger.e("Erreur lors de la récupération de la version");
        setState(() {
          _checked = true;
        });
      }
    } catch (e) {
      logger.e("Exception de mise à jour : $e");
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
    if (await canLaunchUrl(Uri.parse(apkDownloadUrl))) {
      await launchUrl(Uri.parse(apkDownloadUrl), mode: LaunchMode.externalApplication);
    } else {
      logger.e("Impossible d'ouvrir le lien de téléchargement");
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
          title: Text(tr.app_update_page),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: UpdateChecker(),
        ),
    /*return _checked
        ? Center(
      child: Text(
        _hasUpdate ? tr.app_update_available : tr.skbar_update_isupdate,
        style: TextStyle(fontSize: 16),
      ),
    )
        : const Center(child: CircularProgressIndicator());

     */
    );
  }
}
