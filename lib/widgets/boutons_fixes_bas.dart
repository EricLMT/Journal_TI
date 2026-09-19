import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:journal_ti/utils/db_utils.dart'; 



class BoutonsFixesBas extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  //final VoidCallback onReset;
  //final VoidCallback onSubmit;
  final ScrollController scrollController;

  const BoutonsFixesBas({
    super.key,
    required this.formKey,
    required this.scrollController,
    //required this.onReset,
    //required this.onSubmit,
  });

  void _scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }
  void _onReset() {
    formKey.currentState?.reset();
  }

  //void _onSubmit() async {
  //}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [          
          //ElevatedButton.icon(
          //  icon: const Icon(Icons.save),
          //  label: const Text(
          //    'Sauvegarder',
          //    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          //  ),
          //  onPressed: _onSubmit,
          //),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text(
              'Réinitialiser',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            onPressed: _onReset,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_upward),
            onPressed: _scrollToTop,
            label: const Text(
              'Revenir en haut',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          //SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 2),
        ],
      ),
    );
  }
}
