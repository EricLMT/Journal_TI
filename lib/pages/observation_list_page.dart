import 'package:flutter/material.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
//import 'dart:io';
import 'dart:async';
import 'package:journal_ti/observation.dart';

//import FROM APP;
import 'package:journal_ti/utils/db_utils.dart';
import 'package:journal_ti/pages/observation_detail_page.dart';
import 'package:journal_ti/utils/locale_language.dart';
import '/l10n/app_localizations.dart';


class ObservationsListePage extends StatefulWidget {
  const ObservationsListePage({super.key});

  @override
  State<ObservationsListePage> createState() => _ObservationsListePageState();
}


class _ObservationsListePageState extends State<ObservationsListePage> {
  final int pageSize = 10;
  int currentPage = 0;
  bool isLoading = false;
  bool hasMore = true;
  List<Observation> observations = [];

  @override
  void initState() {
    super.initState();
    loadMore();
  }
  void _refreshList() {
    if (!mounted) return;
    setState(() {
      observations.clear();
      currentPage = 0;
      hasMore = true;
      isLoading = false;
    });
    loadMore();
  }

  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;
    if (!mounted) return;
    setState(() => isLoading = true);

    final newItems = await DBHelper.getObservationsPaginated(
        offset: currentPage * pageSize, limit: pageSize);

    if (!mounted) return;
    setState(() {
      observations.addAll(newItems);
      isLoading = false;
      hasMore = newItems.length == pageSize;
      currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      // appBar: AppBar(title: const Text('Observations')),
      body: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
                  tr.obs_list_page_list,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: Text(tr.button_refresh),
                onPressed: _refreshList,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: observations.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < observations.length) {
                  final obs = observations[index];
                  return ListTile(
                    title: Text(
                      obs.lieu != null && obs.date != null
                          ? '${tr.obs_detail_page_title_sheet} n° ${obs.id} :\n '
                          '${DateFormat('dd/MM/yyyy').format(obs.date)} - ${tr.getTranslation(obs.lieu ?? '')}'
                          : tr.obs_list_page_no_date_place,
                    ),
                    subtitle: Text(obs.comportement ?? '—'),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ObservationDetailPage(observation: obs),
                        ),
                      );
                      // Si on revient avec un "true", alors on rafraîchit
                      if (result == true && mounted) {
                        setState(() {
                          observations.clear();
                          _refreshList(); // recharge depuis DB
                        });
                      }
                    },
                  );
                } else {
                  // Bouton "Charger plus"
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: loadMore,
                        child: Text(tr.obs_list_page_list_more),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 2),
        ],
      ),
    );
  }
}