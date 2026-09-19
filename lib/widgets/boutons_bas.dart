import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:journal_ti/utils/locale_language.dart';
//import 'package:journal_ti/widgets/boutons_bas.dart';
import '/l10n/app_localizations.dart';


class BoutonsBas extends StatelessWidget {
  final bool hasScrolledToBottom;
  final GlobalKey<FormBuilderState> formKey;
  final VoidCallback onReset;
  final VoidCallback onSubmit;

  const BoutonsBas({
    super.key,
    required this.hasScrolledToBottom,
    required this.formKey,
    required this.onReset,
    required this.onSubmit,
  });



  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [          
          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: Text(
              tr.button_save,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            onPressed: hasScrolledToBottom ? onSubmit : null,
          ),
          const SizedBox(height: 16, width: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: Text(
              tr.button_refresh,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            onPressed: onReset,
          ),
          //SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 2),
        ],
      ),
    );
  }
}
