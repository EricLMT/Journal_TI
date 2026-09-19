import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/services.dart';
import '/l10n/app_localizations.dart';

//import FROM APP;
import 'package:journal_ti/utils/geoloc_utils.dart';
//import 'package:journal_ti/utils/pdf_utils.dart';
//import 'package:journal_ti/utils/forms_utils.dart';
import 'package:journal_ti/widgets/app_menu.dart';
import 'package:journal_ti/widgets/form_observation.dart';
import 'package:journal_ti/pages/observation_list_page.dart';





class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}


class _JournalPageState extends State<JournalPage> with SingleTickerProviderStateMixin {
  //final _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  Key _formKeyWidget = UniqueKey();
  late TabController _tabController;
  final _scrollController = ScrollController();

  void _resetFormulaire(GlobalKey<FormBuilderState> formKey) async {
    await detecterAdresse(_formKey);
    setState(() {
      _formKey.currentState?.reset();
      _formKeyWidget = UniqueKey();
    });

  }


  @override
  void initState() {
    super.initState();
    _resetFormulaire(_formKey);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Journal de TI'
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,           // couleur sélectionnée
          unselectedLabelColor: Colors.grey,   // non sélectionnée
          indicatorColor: Colors.black,       // soulignement
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          tabs: [
            Tab(text: tr.journal_page_tab_obs),
            //Tab(text: 'Observation'),
            //Tab(text: 'Impacts'),
            Tab(text: tr.journal_page_tab_lst),
          ],
        ),
      ),
      drawer:  AppDrawer(
        onNouvelleObservation: () async {
          _resetFormulaire(_formKey);
          await detecterAdresse(_formKey);
          _tabController.animateTo(0);
        },
        onVoirFichiers: () async {
          Navigator.pushNamed(context, '/pdfs');
        },
        onExporterVersExcel: () async {
          Navigator.pushNamed(context, '/xlsx');
        },
        //onExporterVersPdf: () async {
        //},
        onOptions: () {
          Navigator.pushNamed(context, '/options');
        },
        onApropos: () {
          Navigator.pushNamed(context, '/apropos');
        },
        onQuitter: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(tr.alert_dialog_exit),
              content: Text(tr.alert_dialog_exit_confirm),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(tr.button_cancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Ferme la boîte
                    SystemNavigator.pop();  // Ferme l'application
                  },
                  child: Text(tr.alert_dialog_exit),
                ),
              ],
            ),
          );        
        },
      ),
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            key: _formKeyWidget,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    FormObservation(),
                    ObservationsListePage(),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery
                  .of(context)
                  .viewPadding
                  .bottom + 2),
              SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 2),
            ],
          ),
        ),
      ),
    );
  }
}
