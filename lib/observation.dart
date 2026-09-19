class Observation {
  final int? id; 
  final DateTime date;
  final DateTime heure;
  final String? lieu;
  final String? contexte;
  final String? comportement;
  final String? personnes;
  final String? interactiontype;
  final String? interactionlink;
  final String? repetition;
  final List<String>? impactspsychologiques;
  final List<String>? impactsphysiques;
  final String? temoins;
  final String? remarques;
  final String? localisation;

  Observation({
    required this.id,
    required this.date,
    required this.heure,
    this.lieu,
    this.contexte,
    this.comportement,
    this.personnes,
    this.interactiontype,
    this.interactionlink,
    this.repetition,
    this.impactspsychologiques,
    this.impactsphysiques,
    this.temoins,
    this.remarques,
    this.localisation,
  });


  /// 🔁 Convertir depuis une Map (JSON, DB)
  factory Observation.fromMap(Map<String, dynamic> map) {
    return Observation(
      id: map['id'],
      date: DateTime.parse(map['date']),
      heure: DateTime.parse(map['heure']),
      lieu: map['lieu'],
      contexte: map['contexte'],
      comportement: map['comportement'],
      personnes: map['personnes'],
      interactiontype: map['interactiontype'],
      interactionlink: map['interactionlink'],
      repetition: map['repetition'], // == true || map['repetition'] == 'true',
      impactspsychologiques: (map['impactspsychologiques'] is String)
          ? (map['impactspsychologiques'] as String)
          .split(',')
          .map((e) => e.trim())
          .toList()
          : List<String>.from(map['impactspsychologiques'] ?? []),

      impactsphysiques: (map['impactsphysiques'] is String)
          ? (map['impactsphysiques'] as String)
          .split(',')
          .map((e) => e.trim())
          .toList()
          : List<String>.from(map['impactsphysiques'] ?? []),

      temoins: map['temoins'],
      remarques: map['remarques'],
      localisation: map['localisation'],
    );
  }

  factory Observation.fromFormData(Map<String, dynamic> data) {
    return Observation(
      id: data['id'],
      date: data['date'] as DateTime,
      heure: data['heure'] as DateTime,
      lieu: data['lieu'],
      contexte: data['contexte'],
      comportement: data['comportement'],
      personnes: data['personnes'],
      interactiontype: data['interactiontype'],
      interactionlink: data['interactionlink'],
      repetition: data['repetition'], // == true,
      impactspsychologiques: List<String>.from(data['impactspsychologiques'] ?? []),
      impactsphysiques: List<String>.from(data['impactsphysiques'] ?? []),
      temoins: data['temoins'],
      remarques: data['remarques'],
      localisation: data['localisation'],
    );
  }


  /// 🔁 Convertir vers une Map (JSON, DB)
  Map<String, dynamic> toReadableMap() {
    return {
      'Id': id,
      'Date': date.toIso8601String(),
      'Heure': heure.toIso8601String(),
      'Lieu': lieu,
      'Contexte': contexte,
      'Comportement': comportement,
      'Personnes': personnes,
      'Type interaction': interactiontype,
      'Lien interaction': interactionlink,
      'Répétition': repetition,
      'Impacts psychologiques': impactspsychologiques,
      'Impacts physiques': impactsphysiques,
      'Témoins': temoins,
      'Remarques': remarques,
      'Localisation approximative': localisation,
    };
  }

/// 🔁 Convertir vers une Map (JSON, DB)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'heure': heure.toIso8601String(),
      'lieu': lieu,
      'contexte': contexte,
      'comportement': comportement,
      'personnes': personnes,
      'interactiontype': interactiontype,
      'interactionlink': interactionlink,
      'repetition': repetition,
      'impactspsychologiques': impactspsychologiques,
      'impactsphysiques': impactsphysiques,
      'temoins': temoins,
      'remarques': remarques,
      'localisation': localisation,
    };
  }

  /// 📝 Pour affichage ou export texte brut
  @override
  String toString() {
    return '''
🗓 Date : ${date.toLocal()}
🕒 Heure : ${heure.toLocal()}
📍 Lieu : $lieu - $contexte
👥 Personnes : $personnes
💬 Type Interaction : $interactiontype
💬 Lien Interaction : $interactionlink
🔁 Répétition : $repetition //== true ? "Oui" : "Non"}
🧠 Impacts psychologiques : ${impactspsychologiques?.join(", ") ?? "-"}
⚡ Impacts physiques : ${impactsphysiques?.join(", ") ?? "-"}
👀 Témoins : $temoins
📝 Remarques : $remarques
📌 Localisation : $localisation
''';
  }
}

//////////////////////  LISTES ////////////////////////
const List<String> lieuObservation = [
  'obs_list_street',
  'obs_list_home',
  'obs_list_work',
  'obs_list_elevator',
  'obs_list_transport',
  'obs_list_station',
  'obs_list_gym',
  'obs_list_waiting_room',
  'obs_list_park',
  'obs_list_other',
];

final List<String> lienInteraction = [
  'obs_list_interaction_niveau1', // Niveau 1 : Relations intimes / proches / Amicales
  'obs_list_interaction_niveau2', // Niveau 2 : Entourage élargi / professionnel / voisinage
  'obs_list_interaction_niveau3', // Niveau 3 : Interactions fonctionnelles / institutionnelles
  'obs_list_interaction_niveau4', // Niveau 4 : Activités sociales / Réseaux sociaux / en ligne
  'obs_list_interaction_niveau5', // Niveau 5 : Personnes inconnues / Inconnus en ligne
  'obs_list_interaction_niveau6', // Niveau 6 : Autre à préciser dans remarques
];

const List<String> typeInteraction = [
  'obs_list_interact_visual',
  'obs_list_interact_verbal',
  'obs_list_interact_sound',
  'obs_list_interact_tactile',
  'obs_list_interact_other',
];

const List<String> ressentisPhysique = [
  'obs_list_impact_phy_pain',
  'obs_list_impact_phy_oppression',
  'obs_list_impact_phy_voice_intra_audible',
  'obs_list_impact_phy_voice_intra_sub',
  'obs_list_impact_phy_voice_ext_audible',
  'obs_list_impact_phy_voice_ext_sub',
  'obs_list_impact_phy_heat',
  'obs_list_impact_phy_vibration',
  'obs_list_impact_phy_electric',
  'obs_list_impact_phy_shock',
  'obs_list_impact_phy_pressure_head',
  'obs_list_impact_phy_pressure_body',
  'obs_list_impact_phy_whistle',
  'obs_list_impact_phy_excitation',
  'obs_list_impact_phy_fatigue',
  'obs_list_impact_phy_sleep',
  'obs_list_impact_phy_balance',
  'obs_list_impact_phy_hallucinations',
  'obs_list_impact_phy_members',
  'obs_list_impact_phy_other_perception',
  'obs_list_impact_phy_other',
];

const List<String> ressentisPsychologique = [
  'obs_list_impact_psy_surprise',
  'obs_list_impact_psy_incomprehension',
  'obs_list_impact_psy_anxiety',
  'obs_list_impact_psy_fear',
  'obs_list_impact_psy_anger',
  'obs_list_impact_psy_irritation',
  'obs_list_impact_psy_humiliation',
  'obs_list_impact_psy_sadness',
  'obs_list_impact_psy_guilt',
  'obs_list_impact_psy_helplessness',
  'obs_list_impact_psy_hypervigilance',
  'obs_list_impact_psy_confusion',
  'obs_list_impact_psy_shame',
  'obs_list_impact_psy_disgust',
  'obs_list_impact_psy_resignation',
  'obs_list_impact_psy_isolation',
  'obs_list_impact_psy_other'
];
List<String> ressentisPhysiqueSelectionnes = [];
List<String> ressentisPsychologiqueSelectionnes = [];

