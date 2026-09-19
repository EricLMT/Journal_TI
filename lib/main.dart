import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
//import FROM APP;
// DOC : https://docs.flutter.dev/ui/widgets
import 'app.dart';
import 'utils/locale_language.dart';


final logger = Logger();

//void main() => runApp(const MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localeProvider = LocaleProvider();
  await localeProvider.loadLocale();

  runApp(
    ChangeNotifierProvider<LocaleProvider>.value(
      value: localeProvider,
      child: const MyApp(),
    ),
  );
}







