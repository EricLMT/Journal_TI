import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
//import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:flutter/rendering.dart';
import 'package:journal_ti/utils/db_utils.dart';
import 'package:logger/logger.dart';
import '/l10n/app_localizations.dart';
import 'package:journal_ti/utils/locale_language.dart';
//import 'package:journal_ti/utils/db_utils.dart';
import 'package:path/path.dart' as path;
//import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:async';

final logger = Logger();

class StatsPdfPage extends StatefulWidget {
  const StatsPdfPage({super.key});

  @override
  State<StatsPdfPage> createState() => _StatsPdfPageState();
}

class _StatsPdfPageState extends State<StatsPdfPage> {
  final GlobalKey _chartKeylieux = GlobalKey();
  final GlobalKey _chartKeytypes = GlobalKey();
  final GlobalKey _chartKeylinks = GlobalKey();
  final GlobalKey _chartKeyimpPsy = GlobalKey();
  final GlobalKey _chartKeyimpPhy = GlobalKey();

  @override
  void initState() {
    super.initState();
    fetchLieuStats();
    fetchTypeStats();
    fetchLienStats();
    fetchImpPsyStats();
    fetchImpPhyStats();
  }
  Map<String, int> statsLieux = {};
  Map<String, int> statsTypes = {};
  Map<String, int> statsLiens = {};
  Map<String, int> statsImpPsy = {};
  Map<String, int> statsImpPhy = {};

  Future<void> fetchLieuStats() async {
    try {
      final result = await DBHelper.getLieuStats();
      if (mounted && result.isNotEmpty) {
        setState(() {
          statsLieux = result;
        });
      }
    } catch (e) {
      debugPrint("Erreur lors de fetchLieuStats : $e");
    }
  }

  Future<void> fetchTypeStats() async {
    try {
      final result = await DBHelper.getTypeStats();
      if (mounted && result.isNotEmpty) {
        setState(() {
          statsTypes = result;
        });
      }
    } catch (e) {
      debugPrint("Erreur lors de fetchTypeStats : $e");
    }
  }

  Future<void> fetchLienStats() async {
    try {
      final result = await DBHelper.getLienStats();
      if (mounted && result.isNotEmpty) {
        setState(() {
          statsLiens = result;
        });
      }
    } catch (e) {
      debugPrint("Erreur lors de fetchLienStats : $e");
    }
  }

  Future<void> fetchImpPsyStats() async {
    try {
      final result = await DBHelper.getTopImpPsyStats();
      if (mounted && result.isNotEmpty) {
        setState(() {
          statsImpPsy = result;
        });
      }
    } catch (e) {
      debugPrint("Erreur lors de fetchLienStats : $e");
    }
  }

  Future<void> fetchImpPhyStats() async {
    try {
      final result = await DBHelper.getTopImpPhyStats();
      if (mounted && result.isNotEmpty) {
        setState(() {
          statsImpPhy = result;
        });
      }
    } catch (e) {
      debugPrint("Erreur lors de fetchLienStats : $e");
    }
  }


  Future<Uint8List> _captureChartAsImage(GlobalKey key) async {
    final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> _generatePdfWithChart(BuildContext context, {bool partager = false}) async {
    final tr = AppLocalizations.of(context)!;

    final chart1Image = await _captureChartAsImage(_chartKeylieux);
    final chart2Image = await _captureChartAsImage(_chartKeytypes);
    final chart3Image = await _captureChartAsImage(_chartKeylinks);
    final chart4Image = await _captureChartAsImage(_chartKeyimpPsy);
    final chart5Image = await _captureChartAsImage(_chartKeyimpPhy);


    final pdf = pw.Document();

    final image1 = pw.MemoryImage(chart1Image);
    final image2 = pw.MemoryImage(chart2Image);
    final image3 = pw.MemoryImage(chart3Image);
    final image4 = pw.MemoryImage(chart4Image);
    final image5 = pw.MemoryImage(chart5Image);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text("Stats - Page 1"),
            pw.SizedBox(height: 20),
            pw.Image(image1),
            pw.SizedBox(height: 20),
            pw.Image(image2),
            pw.SizedBox(height: 20),
            pw.Image(image3),
          ],
        ),
      ),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text("Stats - Page 2"),
            pw.SizedBox(height: 20),
            pw.Image(image4),
            pw.SizedBox(height: 20),
            pw.Image(image5),
          ],
        ),
      ),
    );

    final now = DateTime.now();
    final dateStr = DateFormat('dd-MM-yyyy').format(now);
    final heureStr = DateFormat('HH\'h\'mm').format(now);

    // Création dossier
    final directory = Directory('/storage/emulated/0/Documents/JournalTI');
    if (!await directory.exists()) await directory.create(recursive: true);

    // Nom du fichier
    final fileName = "chart_observations_${dateStr}_$heureStr.pdf";
    final filePath = path.join(directory.path, fileName);

    // Sauvegarde
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(tr.skbar_pdf_chart_created),
    ));

    // Partage
    if (partager) {
      await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
    }
    //await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final itemslieux = statsLieux.entries.toList();
    final itemstypes = statsTypes.entries.toList();
    final itemslinks = statsLiens.entries.toList();
    final itemsimppsy = statsImpPsy.entries.toList();
    final itemsimpphy = statsImpPhy.entries.toList();

    return Scaffold(
      appBar: AppBar(title: Text(tr.pdf_chart_title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(tr.pdf_chart_subtitle),
             Divider(),
            const SizedBox(height: 20),
            Text(tr.obs_place),
            RepaintBoundary(
            key: _chartKeylieux,
            child: SizedBox(
              height: 150,
              child: BarChart(
                BarChartData(
                  barGroups: itemslieux
                      .asMap()
                      .entries
                      .map(
                        (e) => BarChartGroupData(
                          x: e.key,
                          barRods: [
                            BarChartRodData(
                              toY: e.value.value.toDouble(),
                              color: Colors.blue,
                              width: 16,
                              borderRadius: BorderRadius.circular(4),
                            )
                          ],
                        ),
                      )
                      .toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          // Index dans la liste
                          final index = value.toInt();
                          if (index >= 0 && index < itemslieux.length) {
                            final key = itemslieux[index].key;
                            final translated = AppLocalizations.of(context)!.getTranslation(key);
                            final limitedText = translated.length > 10 ? '${translated.substring(0, 10)}…' : translated;
                            return Text(
                              limitedText,
                              style: TextStyle(fontSize: 10),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(tr.obs_interaction_type),
          RepaintBoundary(
            key: _chartKeytypes,
            child: SizedBox(
              height: 150,
              child: BarChart(
                BarChartData(
                  barGroups: itemstypes
                      .asMap()
                      .entries
                      .map(
                        (e) => BarChartGroupData(
                      x: e.key,
                      barRods: [
                        BarChartRodData(
                          toY: e.value.value.toDouble(),
                          color: Colors.green,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  )
                      .toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          // Index dans la liste
                          final index = value.toInt();
                          if (index >= 0 && index < itemstypes.length) {
                            final key = itemstypes[index].key;
                            final translated = AppLocalizations.of(context)!.getTranslation(key);
                            final limitedText = translated.length > 10 ? '${translated.substring(0, 10)}…' : translated;
                            return Text(
                              limitedText,
                              style: TextStyle(fontSize: 10),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(tr.obs_interaction_link),
          RepaintBoundary(
            key: _chartKeylinks,
            child: SizedBox(
              height: 150,
              child: BarChart(
                BarChartData(
                  barGroups: itemslinks
                      .asMap()
                      .entries
                      .map(
                        (e) => BarChartGroupData(
                      x: e.key,
                      barRods: [
                        BarChartRodData(
                          toY: e.value.value.toDouble(),
                          color: Colors.red,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  )
                      .toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          // Index dans la liste
                          final index = value.toInt();
                          if (index >= 0 && index < itemslinks.length) {
                            final key = itemslinks[index].key;
                            final translated = AppLocalizations.of(context)!.getTranslation(key);
                            final limitedText = translated.length > 10 ? '${translated.substring(0, 10)}…' : translated;
                            return Text(
                              limitedText,
                              style: TextStyle(fontSize: 10),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          Text(tr.obs_psy_impacts),
          RepaintBoundary(
            key: _chartKeyimpPsy,
            child: SizedBox(
              height: 150,
              child: BarChart(
                BarChartData(
                  barGroups: itemsimppsy
                  .asMap()
                  .entries
                  .map(
                    (e) => BarChartGroupData(
                      x: e.key,
                      barRods: [
                        BarChartRodData(
                          toY: e.value.value.toDouble(),
                          color: Colors.purple,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  )
                      .toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          // Index dans la liste
                          final index = value.toInt();
                          if (index >= 0 && index < itemsimppsy.length) {
                            final key = itemsimppsy[index].key;
                            final translated = AppLocalizations.of(context)!.getTranslation(key);
                            final limitedText = translated.length > 10 ? '${translated.substring(0, 10)}…' : translated;
                            return Text(
                              limitedText,
                              style: TextStyle(fontSize: 10),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          Text(tr.obs_phy_impacts),
          RepaintBoundary(
            key: _chartKeyimpPhy,
            child: SizedBox(
              height: 150,
              child: BarChart(
                BarChartData(
                  barGroups: itemsimpphy
                      .asMap()
                      .entries
                      .map(
                        (e) => BarChartGroupData(
                          x: e.key,
                          barRods: [
                            BarChartRodData(
                              toY: e.value.value.toDouble(),
                              color: Colors.orange,
                              width: 16,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          // Index dans la liste
                          final index = value.toInt();
                          if (index >= 0 && index < itemsimpphy.length) {
                            final key = itemsimpphy[index].key;
                            final translated = AppLocalizations.of(context)!.getTranslation(key);
                            final limitedText = translated.length > 10 ? '${translated.substring(0, 10)}…' : translated;
                            return Text(
                              limitedText,
                              style: TextStyle(fontSize: 10),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.picture_as_pdf),
            label: Text(tr.journal_page_export_pdf),
            onPressed: () async {
              final partager = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(tr.journal_page_export_pdf),
                  content: Text(tr.journal_page_share_export),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(tr.button_no),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(tr.button_yes),
                    ),
                  ],
                ),
              );
              if (partager != null && context.mounted) {
                await _generatePdfWithChart(context, partager: partager);
              }
            },
          ),
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 2),

              //ElevatedButton(
          //  onPressed: _generatePdfWithChart,
          //  child: Text("Générer le PDF avec graphique"),
          //),
        ],
      ),
      ),
    );
  }
}
