// lib/pages/language_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:journal_ti/utils/locale_language.dart';
import '/l10n/app_localizations.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(tr.language_page_title)),
      body: ListView(
        children: L10n.all.map((locale) {
          final isSelected = locale == provider.locale;

          return ListTile(
            title: Text(L10n.getLanguageName(locale.languageCode)),
            trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
            onTap: () => provider.setLocale(locale),
          );
        }).toList(),
      ),
    );
  }
}
