import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'package:logger/logger.dart';
import 'package:journal_ti/utils/db_utils.dart';
import 'package:journal_ti/utils/forms_utils.dart';
import 'package:journal_ti/utils/geoloc_utils.dart';
import 'package:journal_ti/utils/locale_language.dart';
import 'package:journal_ti/widgets/boutons_bas.dart';
import '/l10n/app_localizations.dart';
import 'package:journal_ti/observation.dart';



final logger = Logger();
late AppLocalizations tr;

class FormObservation extends StatefulWidget {
  const FormObservation({super.key});

  //final Map<String, dynamic>? observation; // null pour une nouvelle
  //const ObservationFormPage({Key? key, this.observation}) : super(key: key);

  @override
  State<FormObservation> createState() => _FormObservationState();
}

class _FormObservationState extends State<FormObservation> {
  final _formKey = GlobalKey<FormBuilderState>();
  final ScrollController _scrollController = ScrollController();

  bool _hasScrolledToBottom = false;


  @override
  void initState() {
    super.initState();
    //if (widget.observation != null) {
    //  _formKey.currentState?.patchValue(widget.observation!);
    //} else {
      resetFormulaire(_formKey);
      detecterAdresse(_formKey); // Lancer la détection à l’ouverture
    //}
    _scrollController.addListener(_onScroll); // si tu as un listener
  }

  void _onScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.offset > 0 &&
          !_hasScrolledToBottom) {
        if (!mounted) return;
        setState(() {
          _hasScrolledToBottom = true;
        });
      }
    });
  }

  //@override

  void _handleReset() {
    _formKey.currentState?.reset();
    if (!mounted) return;
    setState(() => _hasScrolledToBottom = false);
    resetFormulaire(_formKey);
    detecterAdresse(_formKey);
    // Revenir en haut
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _handleSubmit() async {
    tr = AppLocalizations.of(context)!;

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final rawData = _formKey.currentState!.value;
      final data = Map<String, dynamic>.from(rawData);

      // LAISSE COMME DateTime — NE PAS formater !
      //data['date'] = data['date'];
      //data['heure'] = data['heure'];

      //final lieuKey = data['lieu'] as String?; // ex: 'obs_list_street'
      //final interactionKey = data['interaction'] as String?; // ex: 'obs_list_interact_visual'
      final impactsPsyKeys = List<String>.from(data['impactspsychologiques'] ?? []);
      final impactsPhyKeys = List<String>.from(data['impactsphysiques'] ?? []);

      //if (lieuKey != null) {
      //  data['lieu'] = AppLocalizations.of(context)!.getTranslation(lieuKey);
      //}

      //if (interactionKey != null) {
      //  data['interaction'] =
      //      AppLocalizations.of(context)!.getTranslation(interactionKey);
      //}

      data['impactspsychologiques'] = impactsPsyKeys
          .map((key) => key) //.AppLocalizations.of(context)!.getTranslation(key))
          .toList();

      data['impactsphysiques'] = impactsPhyKeys
          .map((key) => key) //AppLocalizations.of(context)!.getTranslation(key))
          .toList();


      if (data['impactspsychologiques'] is List) {
        data['impactspsychologiques'] =
        (data['impactspsychologiques'] as List).isEmpty ? ''
            //? 'Aucun'
            : (data['impactspsychologiques'] as List).join(', ');
      }
      if (data['impactsphysiques'] is List) {
        data['impactsphysiques'] = (data['impactsphysiques'] as List).isEmpty
            ? '' //'''Aucun'
            : (data['impactsphysiques'] as List).join(', ');
      }


      //await generatePdf(context, data, partager: false);
      //if (widget.observation != null) {
      // C'est une modification
      // await DBHelper.updateObservation(data);
      //} else {
      // C'est un ajout

      await DBHelper.sauvegarderSQLObservation(data);
      //}

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(tr.skbar_save_db_ok),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr.skbar_form_complet)),
      );
    }
    _handleReset();
   // Navigator.pop(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tr = AppLocalizations.of(context)!;

    ///final obs = widget.observation;

    //final dateObs = DateTime.now().toIso8601String();
    //final hourObs = DateTime.now().toIso8601String();

    final lieu = lieuObservation.map((key) =>
        DropdownMenuItem<String>(
          value: key,
          child: Text(tr.getTranslation(key)),
        )).toList();

    final interactiontype = typeInteraction.map((key) =>
        DropdownMenuItem<String>(
          value: key,
          child: Text(tr.getTranslation(key)),
        )).toList();

    final interactionlink = lienInteraction.map((key) =>
        DropdownMenuItem<String>(
          value: key,
          child: Text(tr.getTranslation(key)),
        )).toList();

    //final impactspsychologiques = ressentisPsychologique.map((key) => DropdownMenuItem<String>(
    //  value: key,
    //  child: Text(tr.getTranslation(key)),
    //)).toList();

    //final impactsphysiques = ressentisPhysique.map((key) => DropdownMenuItem<String>(
    //  value: key,
    //  child: Text(tr.getTranslation(key)),
    //)).toList();

    //return Scaffold(
    //appBar: AppBar(title: const Text("Fiche d'observation")),
    //body:
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            Text('Nouvelle Observation',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            Row(
              children: [

                Expanded(
                  child: FormBuilderDateTimePicker(
                    name: 'date',
                    initialValue: DateTime.now(),
                    inputType: InputType.date,
                    format: DateFormat('dd/MM/yyyy'),
                    decoration: InputDecoration(
                      labelText: tr.obs_date,
                      labelStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FormBuilderDateTimePicker(
                    name: 'heure',
                    initialValue: DateTime.now(),
                    inputType: InputType.time,
                    format: DateFormat('HH:mm'),
                    decoration: InputDecoration(
                      labelText: tr.obs_hour,
                      labelStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            FormBuilderTextField(
              name: 'localisation',
              readOnly: true,
              decoration: InputDecoration(
                labelText: tr.obs_localisation,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FormBuilderDropdown(
              name: 'lieu',
              decoration: InputDecoration(
                labelText: tr.obs_place,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              items: lieu.cast<DropdownMenuItem<dynamic>>(),
              onChanged: (val) {},
            ),
            FormBuilderTextField(
              name: 'contexte',
              decoration: InputDecoration(
                labelText: tr.obs_detail_place,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FormBuilderTextField(
              name: 'comportement',
              decoration:
              InputDecoration(
                labelText: tr.obs_comportement,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FormBuilderTextField(
              name: 'personnes',
              decoration:
              InputDecoration(
                labelText: tr.obs_personnes,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FormBuilderDropdown(
              name: 'interactiontype',
              decoration:
              InputDecoration(
                labelText: tr.obs_interaction_type,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              items: interactiontype.cast<DropdownMenuItem<dynamic>>(),
              onChanged: (val) {},
            ),
            FormBuilderDropdown(
              name: 'interactionlink',
              decoration:
              InputDecoration(
                labelText: tr.obs_interaction_link,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              items: interactionlink.cast<DropdownMenuItem<dynamic>>(),
              onChanged: (val) {},
            ), FormBuilderRadioGroup(
              name: 'repetition',
              decoration: InputDecoration(
                labelText: tr.obs_repeat,
                labelStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              options: [
                FormBuilderFieldOption(value: 'yes', child: Text(tr.button_yes)),
                FormBuilderFieldOption(value: 'no', child: Text(tr.button_no)),
              ],
            ),
            FormBuilderField<List<String>>(
              name: 'impactspsychologiques',
              initialValue: const [],
              builder: (FormFieldState<List<String>> field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: tr.obs_psy_impacts,
                    labelStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    errorText: field.errorText,
                  ),
                  child: Column(
                    children: ressentisPsychologique.map((ressenti) {
                      return CheckboxListTile(
                        title: Text(
                            AppLocalizations.of(context)!.getTranslation(
                                ressenti)),
                        value: field.value!.contains(ressenti),
                        dense: true,
                        // réduit la hauteur automatiquement
                        contentPadding: EdgeInsets.zero,
                        // supprime les marges internes
                        onChanged: (bool? checked) {
                          final current = List<String>.from(field.value ?? []);
                          if (checked == true) {
                            current.add(ressenti);
                          } else {
                            current.remove(ressenti);
                          }
                          field.didChange(current); // ← essentiel !
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            FormBuilderField<List<String>>(
              name: 'impactsphysiques',
              initialValue: const [],
              builder: (FormFieldState<List<String>> field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: tr.obs_phy_impacts,
                    labelStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    errorText: field.errorText,
                  ),
                  child: Column(
                    children: ressentisPhysique.map((ressenti) {
                      return CheckboxListTile(
                        title: Text(
                            AppLocalizations.of(context)!.getTranslation(
                                ressenti)),
                        value: field.value!.contains(ressenti),
                        dense: true,
                        // réduit la hauteur automatiquement
                        contentPadding: EdgeInsets.zero,
                        // supprime les marges internes
                        onChanged: (bool? checked) {
                          final current = List<String>.from(field.value ?? []);
                          if (checked == true) {
                            current.add(ressenti);
                          } else {
                            current.remove(ressenti);
                          }
                          field.didChange(current); // ← essentiel !
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            FormBuilderTextField(
              name: 'temoins',
              decoration:
              InputDecoration(
                labelText: tr.obs_temoins,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FormBuilderTextField(
              name: 'remarques',
              decoration: InputDecoration(
                labelText: tr.obs_remarques,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BoutonsBas(
                  formKey: _formKey,
                  hasScrolledToBottom: _hasScrolledToBottom,
                  onReset: _handleReset,
                  onSubmit: _handleSubmit,
                ),
                const SizedBox(height: 20),
                //ElevatedButton(
                //  onPressed: _handleSubmit,
                //  child: Text(obs != null ? 'Mettre à jour' : 'Enregistrer'),
                //),
                //ElevatedButton(
                //  onPressed: _handleReset,
                //  child: Text('Actualiser'),
                //),
              ],
            ),
            //const SizedBox(height: 32),
            SizedBox(height: MediaQuery
                .of(context)
                .viewPadding
                .bottom + 16),
          ],
        ),
      ),
    );
  }
}
