import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


 void resetFormulaire(GlobalKey<FormBuilderState> formKey) async {
    final maintenant = DateTime.now(); //.toIso8601String();

    formKey.currentState?.reset();
    formKey.currentState?.patchValue({
      'date': maintenant,
      'heure': maintenant,
      'localisation': '',
      'lieu': null,
      'contexte': '',
      'comportement': '',
      'personnes': '',
      'interaction': null,
      'repetition': null,
      'impactspsychologiques': <String>[],
      'impactsphysiques': <String>[],
      'temoins': '',
      'remarques': '',
    });
  }
