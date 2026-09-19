import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import '/l10n/app_localizations.dart';
//import FROM APP;
import 'package:journal_ti/pages/splash_screen.dart';
import 'package:journal_ti/pages/journal_page.dart';
import 'package:journal_ti/pages/apropos_page.dart';
import 'package:journal_ti/pages/fichiers_pdf_page.dart';
import 'package:journal_ti/pages/fichiers_xlsx_page.dart';
import 'package:journal_ti/pages/options_page.dart';
import 'package:journal_ti/pages/observation_list_page.dart';
//import 'package:journal_ti/pages/observation_form_page.dart';
import 'utils/locale_language.dart';
import 'package:provider/provider.dart';
import 'package:journal_ti/pages/help_page.dart';
import 'package:journal_ti/widgets/stats_graph.dart';
import 'package:journal_ti/pages/up_date_page.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
        title: 'Journal TI',        
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueGrey,
            primary: Colors.black,
            secondary: Colors.blueGrey[150],
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 90, 120, 180),
            foregroundColor: Colors.black,
            titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            toolbarTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey[150],
              foregroundColor: Colors.blueGrey[150],
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,              
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),       // 👈 devient la page de démarrage
          '/journal': (context) => const JournalPage(),
          '/pdfs': (context) => const FichiersPDFPage(),
          '/xlsx': (context) => const FichierXLSXPage(),
          '/apropos': (context) => const AProposPage(),
          '/options': (context) => const OptionsPage(),
          '/stats':  (context) => const StatsPdfPage(),
          '/update':  (context) => const UpdatePage(),
          '/liste': (context) => const ObservationsListePage(),
          '/help': (_) => const HelpPage(),
        },
        debugShowCheckedModeBanner: false,
        //supportedLocales: L10n.all,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        //localizationsDelegates: const [
        //  AppLocalizations.delegate,
        //  GlobalMaterialLocalizations.delegate,
        //  GlobalWidgetsLocalizations.delegate,
        //  GlobalCupertinoLocalizations.delegate,
        //],
        locale: provider.locale, // si tu veux forcer le français
        //home: const SplashScreen(),
    );
  }
}
