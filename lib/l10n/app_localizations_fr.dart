// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get title => 'Journal de TI';

  @override
  String get welcome => 'Bienvenue !';

  @override
  String get hello => 'Bonjour FR';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get later => 'Plus tard';

  @override
  String get app_menu_version => '';

  @override
  String get app_update_page => 'Mise à jour';

  @override
  String get app_update_available => 'Mise à jour disponible';

  @override
  String get app_update_old_version => 'Version actuelle';

  @override
  String get app_update_new_version => 'Nouvelle version';

  @override
  String get app_update_button => 'Mettre à jour';

  @override
  String get app_update_check => 'Vérifier les mises à jour';

  @override
  String get skbar_backup_message =>
      'N\'oubliez pas de faire le backup régulier de votre base de données et de votre dossier Documents/JounalTI.';

  @override
  String get skbar_update_isupdate => 'Votre version est à jour.';

  @override
  String get skbar_update_ok => 'Mise à jour réussie.';

  @override
  String get skbar_update_false => 'Erreur lors de la mise à jour.';

  @override
  String get about_title => 'À propos';

  @override
  String get about_text =>
      'Cette application permet de consigner des faits observés en lien avec des situations de harcèlement électromagnétique, sonore, et de gangstalking supposées.\n\nElle ne fait pas office de preuve, mais ce veut être une aide pour recenser des expériences perçues comme du harcélement.\n\nL\'application utilise la géolocalisation approximative de votre téléphone\n\nLes données peuvent être enregistrées dans un fichier au format MS Excel©, et vous pouvez générer un rapport d\'observation au format PDF exportable et partagable par e-mail ou autre.\n\nCette application vous est proposée TELLE QUELLE, sans aucune garantie.';

  @override
  String get help_title => 'Aide';

  @override
  String get help_title_sub =>
      'Les explications sur le fonctionnement de Journal de TI';

  @override
  String get help_section_app => 'Application';

  @override
  String get help_section_options => 'Options';

  @override
  String get help_section_obs => 'Observations';

  @override
  String get help_section_import_export => 'Import/Export';

  @override
  String get help_section_db => 'Base de données';

  @override
  String get help_text_app =>
      'L\'application permet de créer et alimenter une base de données comportants les enregistrements de vos observations.\n\nLors de la création d\'une observation, votre localisation approximative vous permettra de déterimer le lieu de votre observation.\n\nVous avez différents champs :\nDate : La date ajoutée automatiquement, mais modifiable.\nHeure : L\'heure ajoutée automatiquement, mais modifiable.\nLocalisation approximative : La localisation automatique du lieu de l\'obervation.\nLieu de l\'observation : Le lieu plus précis de votreobservation.\nDétail du lieu : Les détails évuentuels sur le lieu.\nComportement observé : Les comportements observés.\nPersonnes impliquées : Les personnes impliquées dans l\'obervation.\nType d\'interaction : Le type de interactions observée.\nLien d\'interaction : Votre lien avec les personnes impliquées dans l\'observation.\nRécurrence : Si c\'est un comportement ou une situation récurrente.\nImpacts pychologiques : Les impacts pychologiques qu\'a eu cette situation sur vous.\nImpacts physiques : Les impacts physiques qu\'a eu évenement sur vous.\nTémoins : Les personnes pouvant témoigner de cette situation.\nRemarques : Vos remarques complémentaires.\n\nVous pourrez modifier ou effacer ultérieurement votre obseration dans l\'onglet Liste du formulaire.';

  @override
  String get help_text_options =>
      'Le menu de l\'application propose plusieurs options :\nNouvelle observation : Vous permet de créer une Nouvelle observation.\nExporter en PDF : Pour créer et exporter les rapport et les graphique en PDF.\nExporter en Excel : Pour créer et exporter les données en Excel.\nOptions DB : Vous permet de d\'importer / exporter votre base de données vers le dossier Documents/JournalTI.\nLangue : Vous permet de choisir le langue de l\'application.\nAide : Pour accéder à l\'Aide.,\nÀ propos : Pour accéder à l\'à propos,\nQuitter : Pour quitter l\'application.';

  @override
  String get help_text_obs =>
      'Dans l\'onglet \'Observation\', vous pouvez enregistrer les événements que vous percevez, y compris l\'heure, le lieu, les interactions, et les impacts ressentis.';

  @override
  String get help_text_import_export =>
      'Vos données et fichiers sont enregistrés dans le dossier Documents/JournalTI.\n\nVous y retrouverez les documents PDF rapport_.... et chart_...., ainsi que la copie de votre base de données si vous en avez fais une, observations_export.db';

  @override
  String get help_text_db =>
      'Faites des copies régulières de votre dossier Documents/JournalTI.\n\nSi vous avez désinstallée l\'application par mégarde, si le dossier Documents/JournalTI est toujours présent avec le fichier observations_export.db, vous pourrez la réimporter depuis les options du menu Base de données.';

  @override
  String get db_page_date_unknow => 'Date inconnue';

  @override
  String get db_page_lieu_unknow => 'Lieu inconnu';

  @override
  String get db_page_location_unknow => 'Adresse approximative inconnue';

  @override
  String get db_page_date_lieu_unknow => 'Date et lieu inconnus';

  @override
  String get db_page_records => 'Enregistrements';

  @override
  String get alert_dialog_confirm => 'Confirmation';

  @override
  String get alert_dialog_confirm_delete =>
      'Voulez-vous vraiment supprimer cet enregistrement ?';

  @override
  String get alert_dialog_cancel => 'Annuler';

  @override
  String get alert_dialog_delete => 'Supprimer';

  @override
  String get alert_dialog_del_ok => 'Suppression réussie';

  @override
  String get alert_dialog_del_rec_ok => 'Enregistrement supprimé.';

  @override
  String get alert_dialog_ok => 'OK';

  @override
  String get alert_dialog_del_all_files => 'Supprimer tous les fichiers';

  @override
  String get alert_dialog_confirm_delete_all =>
      'Voulez-vous vraiment supprimer tous les fichiers ?';

  @override
  String get alert_dialog_exit => 'Quitter';

  @override
  String get alert_dialog_exit_confirm =>
      'Voulez-vous quitter l\'application ?';

  @override
  String get alert_dialog_delete_db =>
      'Voulez-vous vraiment supprimer toute la base de données ?\nCette action est IRRÉVERSIBLE !';

  @override
  String get alert_dialog_delete_db_ok =>
      'La base de données a bien été supprimée.';

  @override
  String get skbar_granted_refused => 'Permission refusée.';

  @override
  String get skbar_granted_file_refused =>
      'Permission refusée. Impossible d\'ouvrir le fichier.';

  @override
  String get skbar_export_empty => 'Aucune observation à exporter';

  @override
  String get skbar_export_ok => 'Export Excel terminé';

  @override
  String get skbar_export_db_ok => 'Base de données exportée avec succès';

  @override
  String get skbar_import_db_ok => 'Base de données importée avec succès';

  @override
  String get skbar_save_db_ok => 'Observation enregistrée dans DB';

  @override
  String get skbar_form_complet =>
      'Veuillez remplir tous les champs obligatoires';

  @override
  String get skbar_no_file => 'Fichier non trouvé';

  @override
  String get skbar_pdf_file => 'PDF créé avec';

  @override
  String get skbar_pdf_chart_created => 'Graphique PDF généré avec succès';

  @override
  String get pdf_page_title => 'Fichiers PDF enregistrés';

  @override
  String get pdf_page_delete_select => 'Supprimer la sélection';

  @override
  String get pdf_page_delete_all => 'Supprimer tout';

  @override
  String get pdf_page_empty_dir => 'Aucun PDF trouvé';

  @override
  String get pdf_page_reports => 'Fichiers de rapport';

  @override
  String get pdf_page_charts => 'Fichiers de graphiques';

  @override
  String get pdf_chart_title => 'Graphiques statistiques';

  @override
  String get pdf_chart_subtitle => '\'Graphique des Lieux, Types, Liens\'';

  @override
  String get logger_open_ok => 'Ouverture réussie';

  @override
  String get xlsx_page_title => 'Fichiers EXCEL enregistrés';

  @override
  String get xlsx_page_generate => 'Cliquez pour regénérer le fichier Tableur';

  @override
  String get xlsx_page_export => 'Exporter toutes les observations en Excel';

  @override
  String get xlsx_page_empty_dir => 'Aucun fichier XLSX trouvé';

  @override
  String get journal_page_tab_obs => 'Observation';

  @override
  String get journal_page_tab_lst => 'Liste';

  @override
  String get journal_page_export_pdf => 'Exporter en PDF';

  @override
  String get journal_page_export_charts => 'Exporter les graphiques';

  @override
  String get journal_page_share_export =>
      'Voulez-vous partager le fichier PDF après l\'exportation ?';

  @override
  String get button_yes => 'Oui';

  @override
  String get button_no => 'Non';

  @override
  String get button_delete => 'Supprimer';

  @override
  String get button_cancel => 'Annuler';

  @override
  String get button_import => 'Importer';

  @override
  String get button_save => 'Sauvegarder';

  @override
  String get button_modify => 'Modifier';

  @override
  String get button_refresh => 'Réinitialiser';

  @override
  String get button_up => 'Revenir en haut';

  @override
  String get language_page_title => 'Choisir la langue';

  @override
  String get obs_detail_page_title => 'Détails';

  @override
  String get obs_detail_page_title_sheet => 'Fiche d\'observation';

  @override
  String get obs_id => 'Id';

  @override
  String get obs_date => 'Date';

  @override
  String get obs_hour => 'Heure';

  @override
  String get obs_place => 'Lieu';

  @override
  String get obs_detail_place => 'Détail du lieu';

  @override
  String get obs_comportement => 'Comportement observé';

  @override
  String get obs_personnes => 'Personnes impliquées';

  @override
  String get obs_interaction_type => 'Type d\'nteraction';

  @override
  String get obs_interaction_link => 'Lien d\'interaction';

  @override
  String get obs_repeat => 'Schéma similaire (déjà observé)';

  @override
  String get obs_psy_impacts => 'Impacts psychologiques';

  @override
  String get obs_phy_impacts => 'Impacts physiques';

  @override
  String get obs_temoins => 'Témoins éventuels';

  @override
  String get obs_remarques => 'Autres remarques';

  @override
  String get obs_localisation => 'Localisation approximative';

  @override
  String get obs_detail_page_delete => 'Supprimer l\'observation';

  @override
  String get obs_form_page_title => 'Modifier une observation';

  @override
  String get obs_list_page_list => 'Enregistrements';

  @override
  String get obs_list_page_refresh => 'Rafraîchir';

  @override
  String get obs_list_page_no_date_place => 'Observation sans lieu ou date';

  @override
  String get obs_list_page_list_more => 'Charger plus';

  @override
  String get options_page_db => 'Options DB';

  @override
  String get options_page_db_tab_rec => 'Enregistrements';

  @override
  String get options_page_db_tab_db => 'Base de données';

  @override
  String get options_page_db_list => 'Base de données';

  @override
  String get options_page_db_export => 'Exporter la Base de données';

  @override
  String get options_page_db_export_sub =>
      'Exporter la Base de données vers le dossier Document';

  @override
  String get options_page_db_import => 'Importer la Base de données';

  @override
  String get options_page_db_import_sub =>
      'Depuis le dossier Documents/JournalTI (observations_export.db)';

  @override
  String get options_page_db_import_confirm => 'Confirmer l\'importation';

  @override
  String get options_page_db_import_confirm_sub =>
      'Importer ce fichier et écraser la base actuelle ?';

  @override
  String get options_page_db_delete_all => 'Supprimer toute la base';

  @override
  String get options_page_db_delete_all_sub => 'Opération irréversible';

  @override
  String get geoloc_unknow => 'Adresse inconnue';

  @override
  String get pdf_utils_section_datetime => 'Date et Heure';

  @override
  String get pdf_utils_section_place => 'Lieu / Contexte';

  @override
  String get pdf_utils_section_observation => 'Observation';

  @override
  String get pdf_utils_section_impacts => 'Impacts ressentis';

  @override
  String get pdf_utils_section_other => 'Autres';

  @override
  String get pdf_utils_report_title => 'Rapport d\'observations';

  @override
  String get pdf_utils_report_place => 'Etabli à';

  @override
  String get pdf_utils_report_date => 'Date';

  @override
  String get pdf_utils_report_hour => 'Heure';

  @override
  String get pdf_utils_report_nb_obs => 'Nombre d\'observations';

  @override
  String get app_menu_title => 'Menu';

  @override
  String get app_menu_observation => 'Nouvelle observation';

  @override
  String get app_menu_pdf_files => 'Exporter en PDF';

  @override
  String get app_menu_pdf_report => 'Créer Rapport PDF';

  @override
  String get app_menu_xlsx_export => 'Exporter en Excel';

  @override
  String get app_menu_db_options => 'Options DB';

  @override
  String get app_menu_language => 'Langue';

  @override
  String get app_menu_help => 'Aide';

  @override
  String get app_menu_about => 'À propos';

  @override
  String get app_menu_exit => 'Quitter';

  @override
  String get obs_list_street => 'Rue';

  @override
  String get obs_list_home => 'Domicile';

  @override
  String get obs_list_work => 'Travail';

  @override
  String get obs_list_elevator => 'Ascenseur/Escaliers';

  @override
  String get obs_list_transport => 'Transport en commun';

  @override
  String get obs_list_station => 'Gare/Aéroport';

  @override
  String get obs_list_gym => 'Salle de sport';

  @override
  String get obs_list_waiting_room => 'Salle d\'attente';

  @override
  String get obs_list_park => 'Parc/Jardin';

  @override
  String get obs_list_other => 'Autre';

  @override
  String get obs_list_interaction_niveau1 =>
      'Relations proches (famille, ami·e, conjoint·e)';

  @override
  String get obs_list_interaction_niveau2 =>
      'Entourage élargi (collègue, voisin·e, connaissance)';

  @override
  String get obs_list_interaction_niveau3 =>
      'Interactions institutionnelles (professionnel·le, service)';

  @override
  String get obs_list_interaction_niveau4 =>
      'Activités sociales ou en ligne (réseaux sociaux, groupes)';

  @override
  String get obs_list_interaction_niveau5 =>
      'Personne inconnue (public, inconnu en ligne)';

  @override
  String get obs_list_interaction_niveau6 =>
      'Autre (à préciser dans remarques)';

  @override
  String get obs_list_interact_visual => 'Visuelle';

  @override
  String get obs_list_interact_verbal => 'Verbale';

  @override
  String get obs_list_interact_sound => 'Sonore';

  @override
  String get obs_list_interact_tactile => 'Tactile';

  @override
  String get obs_list_interact_other => 'Autre';

  @override
  String get obs_list_impact_phy_pain =>
      'Douleurs ciblées (membres, visage, parties génitales)';

  @override
  String get obs_list_impact_phy_oppression =>
      'Sensation d\'oppression thoracique, manipulation respiratoire';

  @override
  String get obs_list_impact_phy_voice_intra_audible =>
      'Son/Voix intracrâniennes audibles';

  @override
  String get obs_list_impact_phy_voice_intra_sub =>
      'Son/Voix intracrâniennes subliminales';

  @override
  String get obs_list_impact_phy_voice_ext_audible =>
      'Son/Voix externes audibles';

  @override
  String get obs_list_impact_phy_voice_ext_sub =>
      'Son/Voix externes subliminales';

  @override
  String get obs_list_impact_phy_heat =>
      'Bouffées de chaleur, brûlures localisées';

  @override
  String get obs_list_impact_phy_vibration =>
      'Vibrations corporelles, tremblements musculaires';

  @override
  String get obs_list_impact_phy_electric =>
      'Picotements électriques, fourmillements, sensations d’aiguilles';

  @override
  String get obs_list_impact_phy_shock =>
      'Chocs corporels, impulsions soudaines';

  @override
  String get obs_list_impact_phy_pressure_head =>
      'Pression crânienne, sur les muscles de crâne';

  @override
  String get obs_list_impact_phy_pressure_body =>
      'Pressions ciblées sur certaines zones du corps';

  @override
  String get obs_list_impact_phy_whistle =>
      'Acouphènes artificiels, sifflements, ondes sonores';

  @override
  String get obs_list_impact_phy_excitation =>
      'Excitation nerveuse ou génitale forcée';

  @override
  String get obs_list_impact_phy_fatigue =>
      'Fatigue brutale, somnolence récurrente, épuisement';

  @override
  String get obs_list_impact_phy_sleep =>
      'Perturbation du sommeil, empêchement de dormir, réveils forcés, rêves contrôlés';

  @override
  String get obs_list_impact_phy_balance =>
      'Troubles de la coordination et équilibre';

  @override
  String get obs_list_impact_phy_hallucinations =>
      'Visions forcées, hallucinations visuelles ou sensorielles';

  @override
  String get obs_list_impact_phy_members =>
      'Contrôle musculaire à distance, mouvements forcés de membres';

  @override
  String get obs_list_impact_phy_other_perception =>
      'Autre perception anormale';

  @override
  String get obs_list_impact_phy_other => 'Autre, à préciser dans Remarques';

  @override
  String get obs_list_impact_psy_surprise =>
      'Choc ou étonnement soudain face à des sensations ou phénomènes inexpliqués';

  @override
  String get obs_list_impact_psy_incomprehension =>
      'Difficulté à comprendre la cause ou le sens des événements';

  @override
  String get obs_list_impact_psy_anxiety =>
      'Inquiétude persistante face à la répétition ou à l’intensité des symptômes';

  @override
  String get obs_list_impact_psy_fear =>
      'Peur de perdre le contrôle de son corps ou de son esprit';

  @override
  String get obs_list_impact_psy_anger =>
      'Colère contre l’agresseur présumé ou l’impuissance du contexte';

  @override
  String get obs_list_impact_psy_irritation =>
      'Agacement provoqué par la gêne constante ou les interruptions forcées';

  @override
  String get obs_list_impact_psy_humiliation =>
      'Sentiment d’être rabaissé ou violé dans son intimité corporelle';

  @override
  String get obs_list_impact_psy_sadness =>
      'Tristesse ou désespoir liés à la persistance des attaques';

  @override
  String get obs_list_impact_psy_guilt =>
      'Culpabilité injustifiée, tendance à se blâmer soi-même';

  @override
  String get obs_list_impact_psy_helplessness =>
      'Impression de ne rien pouvoir faire pour arrêter ou prévenir les symptômes';

  @override
  String get obs_list_impact_psy_hypervigilance =>
      'Surveillance constante de l’environnement et de ses propres sensations';

  @override
  String get obs_list_impact_psy_confusion =>
      'Désorientation mentale, altération de la perception de la réalité';

  @override
  String get obs_list_impact_psy_shame =>
      'Honte liée aux symptômes intimes ou visibles';

  @override
  String get obs_list_impact_psy_disgust =>
      'Dégoût envers la situation ou les effets subis';

  @override
  String get obs_list_impact_psy_resignation =>
      'Résignation progressive face à l’absence de solution perçue';

  @override
  String get obs_list_impact_psy_isolation =>
      'Sentiment d’isolement social et incompréhension des autres';

  @override
  String get obs_list_impact_psy_other =>
      'Autre réaction émotionnelle ou cognitive, à préciser dans Remarques';
}
