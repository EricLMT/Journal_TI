import 'package:flutter/material.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';


Widget buildClickableCard({
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    ),
  );
}
/*
ListView(
  children: [
    buildClickableCard(
      title: 'Aide Menu',
      subtitle: 'Explication de la navigation principale.',
      onTap: () {
        // Naviguer ou afficher une boîte de dialogue
      },
    ),
    buildClickableCard(
      title: 'Aide Observation',
      subtitle: 'Comment remplir une observation correctement.',
      onTap: () {
        // Afficher plus d'infos
      },
    ),
    buildClickableCard(
      title: 'Aide Liste',
      subtitle: 'Comment retrouver vos observations enregistrées.',
      onTap: () {
        // Une autre action
      },
    ),
  ],
)
 */