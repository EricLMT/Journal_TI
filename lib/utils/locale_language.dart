import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/l10n/app_localizations.dart';


class LocaleProvider extends ChangeNotifier {
  //Locale _locale = const Locale('fr'); // Langue par défaut
  Locale? _locale;
  Locale? get locale => _locale;
  //Locale get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang_code', locale.languageCode);
    _locale = locale;
    notifyListeners();
  }

  Future<void> clearLocale() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lang_code');
    _locale = null;
    notifyListeners();
  }

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('lang_code');
    if (langCode != null) {
      _locale = Locale(langCode);
      notifyListeners();
    }
  }
}

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('fr'),
  ];

  static String getLanguageName(String code) {
    switch (code) {
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      default:
        return 'Unknown';
    }
  }
}

extension AppLocalizationsExtension on AppLocalizations {
  String getTranslation(String key) {
    final map = <String, String>{
      // --- Lieux d'observation ---
      'obs_list_street': obs_list_street,
      'obs_list_home': obs_list_home,
      'obs_list_work': obs_list_work,
      'obs_list_elevator': obs_list_elevator,
      'obs_list_transport': obs_list_transport,
      'obs_list_station': obs_list_station,
      'obs_list_gym': obs_list_gym,
      'obs_list_waiting_room': obs_list_waiting_room,
      'obs_list_park': obs_list_park,
      'obs_list_other': obs_list_other,

      // --- Type d'interaction ---
      'obs_list_interact_visual': obs_list_interact_visual,
      'obs_list_interact_verbal': obs_list_interact_verbal,
      'obs_list_interact_sound': obs_list_interact_sound,
      'obs_list_interact_tactile': obs_list_interact_tactile,
      'obs_list_interact_other': obs_list_interact_other,

      // --- Lien d'interaction ---
      'obs_list_interaction_niveau1': obs_list_interaction_niveau1,
      'obs_list_interaction_niveau2': obs_list_interaction_niveau2,
      'obs_list_interaction_niveau3': obs_list_interaction_niveau3,
      'obs_list_interaction_niveau4': obs_list_interaction_niveau4,
      'obs_list_interaction_niveau5': obs_list_interaction_niveau5,
      'obs_list_interaction_niveau6': obs_list_interaction_niveau6,

      // --- Impacts physiques ---
      'obs_list_impact_phy_pain': obs_list_impact_phy_pain,
      'obs_list_impact_phy_oppression': obs_list_impact_phy_oppression,
      'obs_list_impact_phy_voice_intra_audible': obs_list_impact_phy_voice_intra_audible,
      'obs_list_impact_phy_voice_intra_sub': obs_list_impact_phy_voice_intra_sub,
      'obs_list_impact_phy_voice_ext_audible': obs_list_impact_phy_voice_ext_audible,
      'obs_list_impact_phy_voice_ext_sub': obs_list_impact_phy_voice_ext_sub,
      'obs_list_impact_phy_heat': obs_list_impact_phy_heat,
      'obs_list_impact_phy_vibration': obs_list_impact_phy_vibration,
      'obs_list_impact_phy_electric': obs_list_impact_phy_electric,
      'obs_list_impact_phy_shock': obs_list_impact_phy_shock,
      'obs_list_impact_phy_pressure_head': obs_list_impact_phy_pressure_head,
      'obs_list_impact_phy_pressure_body': obs_list_impact_phy_pressure_body,
      'obs_list_impact_phy_whistle': obs_list_impact_phy_whistle,
      'obs_list_impact_phy_excitation': obs_list_impact_phy_excitation,
      'obs_list_impact_phy_fatigue': obs_list_impact_phy_fatigue,
      'obs_list_impact_phy_sleep': obs_list_impact_phy_sleep,
      'obs_list_impact_phy_balance': obs_list_impact_phy_balance,
      'obs_list_impact_phy_hallucinations': obs_list_impact_phy_hallucinations,
      'obs_list_impact_phy_members': obs_list_impact_phy_members,
      'obs_list_impact_phy_other_perception': obs_list_impact_phy_other_perception,
      'obs_list_impact_phy_other': obs_list_impact_phy_other,

      // --- Impacts psychologiques ---
      'obs_list_impact_psy_surprise': obs_list_impact_psy_surprise,
      'obs_list_impact_psy_incomprehension': obs_list_impact_psy_incomprehension,
      'obs_list_impact_psy_anxiety': obs_list_impact_psy_anxiety,
      'obs_list_impact_psy_fear': obs_list_impact_psy_fear,
      'obs_list_impact_psy_anger': obs_list_impact_psy_anger,
      'obs_list_impact_psy_irritation': obs_list_impact_psy_irritation,
      'obs_list_impact_psy_humiliation': obs_list_impact_psy_humiliation,
      'obs_list_impact_psy_sadness': obs_list_impact_psy_sadness,
      'obs_list_impact_psy_guilt': obs_list_impact_psy_guilt,
      'obs_list_impact_psy_helplessness': obs_list_impact_psy_helplessness,
      'obs_list_impact_psy_hypervigilance': obs_list_impact_psy_hypervigilance,
      'obs_list_impact_psy_confusion': obs_list_impact_psy_confusion,
      'obs_list_impact_psy_shame': obs_list_impact_psy_shame,
      'obs_list_impact_psy_disgust': obs_list_impact_psy_disgust,
      'obs_list_impact_psy_resignation': obs_list_impact_psy_resignation,
      'obs_list_impact_psy_isolation': obs_list_impact_psy_isolation,
      'obs_list_impact_psy_other': obs_list_impact_psy_other
    };

    return map[key] ?? key;
  }
}
