// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'TI Journal';

  @override
  String get welcome => 'Welcome!';

  @override
  String get hello => 'Hello EN';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get later => 'Later';

  @override
  String get app_menu_version => '';

  @override
  String get app_update_page => 'Update';

  @override
  String get app_update_available => 'Update available';

  @override
  String get app_update_old_version => 'Your version';

  @override
  String get app_update_new_version => 'New version';

  @override
  String get app_update_button => 'Update';

  @override
  String get app_update_check => 'Check update';

  @override
  String get skbar_backup_message =>
      'Don\'t forget to regularly backup your database and your Documents/JounalTI folder.';

  @override
  String get skbar_update_isupdate => 'Your version is up to date.';

  @override
  String get skbar_update_ok => 'Update success.';

  @override
  String get skbar_update_false => 'Update false.';

  @override
  String get about_title => 'About';

  @override
  String get about_text =>
      'This app allows you to log observed facts related to suspected electromagnetic, sound, and gangstalking harassment situations.\n\nIt is not a proof, but an aid to record experiences perceived as harassment.\n\nThe app uses your phone\'s approximate geolocation.\n\nData can be saved to an MS Excel© file, and you can generate an observation report in a shareable PDF format.\n\nThis app is provided AS IS, without any warranty.';

  @override
  String get help_title => 'Help';

  @override
  String get help_title_sub => 'Explanations on how Journal de TI works';

  @override
  String get help_section_app => 'Application';

  @override
  String get help_section_options => 'Options';

  @override
  String get help_section_obs => 'Observations';

  @override
  String get help_section_import_export => 'Import/Export';

  @override
  String get help_section_db => 'Data Base';

  @override
  String get help_text_app =>
      'The application allows you to create and feed a database containing the records of your observations.\n\nWhen creating an observation, your approximate location will allow you to determine the location of your observation.\n\nYou have different fields: Date: The date added automatically, but editable.\nTime: The time added automatically, but editable.\nApproximate location: The automatic location of the observation location.\nObservation location: The more precise location of your observation.\nLocation details: Any details about the location.\nObserved behavior: The behaviors observed.\nPeople involved: The people involved in the observation.\nInteraction type: The type of interactions observed.\nInteraction link: Your link with the people involved in the observation.\nRecurrence: If it is a recurring behavior or situation.\nPsychological impacts: The impacts psychological impacts this situation had on you.\nPhysical impacts: The physical impacts this event had on you.\nWitnesses: People who can testify to this situation.\nComments: Your additional comments.\n\nYou can modify or delete your observation later in the List tab of the form.';

  @override
  String get help_text_options =>
      'The application menu offers several options:\nNew observation: Allows you to create a new observation.\nExport to PDF: To create and export reports and graphs in PDF.\nExport to Excel: To create and export data in Excel.\nDB Options: Allows you to import/export your database to the Documents/JournalTI folder.\nLanguage: Allows you to choose the application language.\nHelp: To access Help.\nAbout: To access About.\nExit: To exit the application.';

  @override
  String get help_text_obs =>
      'In the \'Observation\' tab, you can record the events you observe, including time, location, interactions, and perceived impacts.';

  @override
  String get help_text_import_export =>
      'Your data and files are saved in the Documents/JournalTI folder.\n\nYou will find the rapport_.... and chart_.... PDF documents there, as well as a copy of your database, if you have made one, observations_export.db.';

  @override
  String get help_text_db =>
      'Make regular copies of your Documents/JournalTI folder.\n\nIf you have accidentally uninstalled the application, if the Documents/JournalTI folder is still present with the observations_export.db file, you can reimport it from the Database menu options.';

  @override
  String get db_page_date_unknow => 'Unknown date';

  @override
  String get db_page_lieu_unknow => 'Unknown location';

  @override
  String get db_page_location_unknow => 'Unknown approximate address';

  @override
  String get db_page_date_lieu_unknow => 'Unknown date and location';

  @override
  String get db_page_records => 'Records';

  @override
  String get alert_dialog_confirm => 'Confirmation';

  @override
  String get alert_dialog_confirm_delete =>
      'Do you really want to delete this record?';

  @override
  String get alert_dialog_cancel => 'Cancel';

  @override
  String get alert_dialog_delete => 'Delete';

  @override
  String get alert_dialog_del_ok => 'Successfully deleted';

  @override
  String get alert_dialog_del_rec_ok => 'Record deleted.';

  @override
  String get alert_dialog_ok => 'OK';

  @override
  String get alert_dialog_del_all_files => 'Delete all files';

  @override
  String get alert_dialog_confirm_delete_all =>
      'Do you really want to delete all files?';

  @override
  String get alert_dialog_exit => 'Exit';

  @override
  String get alert_dialog_exit_confirm => 'Do you want to exit the app?';

  @override
  String get alert_dialog_delete_db =>
      'Do you really want to delete the entire database?\nThis action is IRREVERSIBLE!';

  @override
  String get alert_dialog_delete_db_ok =>
      'The database has been successfully deleted.';

  @override
  String get skbar_granted_refused => 'Permission denied.';

  @override
  String get skbar_granted_file_refused =>
      'Permission denied. Cannot open file.';

  @override
  String get skbar_export_empty => 'No observation to export';

  @override
  String get skbar_export_ok => 'Excel export completed';

  @override
  String get skbar_export_db_ok => 'Database exported successfully';

  @override
  String get skbar_import_db_ok => 'Database imported successfully';

  @override
  String get skbar_save_db_ok => 'Observation saved to DB';

  @override
  String get skbar_form_complet => 'Please fill in all required fields';

  @override
  String get skbar_no_file => 'File not found';

  @override
  String get skbar_pdf_file => 'PDF created with';

  @override
  String get skbar_pdf_chart_created => 'PDF chart successfully generated';

  @override
  String get pdf_page_title => 'Saved PDF files';

  @override
  String get pdf_page_delete_select => 'Delete selection';

  @override
  String get pdf_page_delete_all => 'Delete all';

  @override
  String get pdf_page_empty_dir => 'No PDF found';

  @override
  String get pdf_page_reports => 'Report Files';

  @override
  String get pdf_page_charts => 'Chart Files';

  @override
  String get pdf_chart_title => 'Statistical Charts';

  @override
  String get pdf_chart_subtitle =>
      '\'Statistical Charts Location, Interact Types, Interact Links\'';

  @override
  String get logger_open_ok => 'Opened successfully';

  @override
  String get xlsx_page_title => 'Saved EXCEL files';

  @override
  String get xlsx_page_generate => 'Click to regenerate spreadsheet file';

  @override
  String get xlsx_page_export => 'Export all observations to Excel';

  @override
  String get xlsx_page_empty_dir => 'No XLSX file found';

  @override
  String get journal_page_tab_obs => 'Observation';

  @override
  String get journal_page_tab_lst => 'List';

  @override
  String get journal_page_export_pdf => 'Export to PDF';

  @override
  String get journal_page_export_charts => 'Export charts';

  @override
  String get journal_page_share_export =>
      'Do you want to share the PDF file after export?';

  @override
  String get button_yes => 'Yes';

  @override
  String get button_no => 'No';

  @override
  String get button_delete => 'Delete';

  @override
  String get button_cancel => 'Cancel';

  @override
  String get button_import => 'Import';

  @override
  String get button_save => 'Save';

  @override
  String get button_modify => 'Modify';

  @override
  String get button_refresh => 'Reset';

  @override
  String get button_up => 'Scroll to top';

  @override
  String get language_page_title => 'Choose Language';

  @override
  String get obs_detail_page_title => 'Details';

  @override
  String get obs_detail_page_title_sheet => 'Observation Sheet';

  @override
  String get obs_id => 'Id';

  @override
  String get obs_date => 'Date';

  @override
  String get obs_hour => 'Time';

  @override
  String get obs_place => 'Location';

  @override
  String get obs_detail_place => 'Location details';

  @override
  String get obs_comportement => 'Observed behavior';

  @override
  String get obs_personnes => 'People involved';

  @override
  String get obs_interaction_type => 'Interact Type';

  @override
  String get obs_interaction_link => 'Interact Link';

  @override
  String get obs_repeat => 'Similar pattern (already observed)';

  @override
  String get obs_psy_impacts => 'Psychological impacts';

  @override
  String get obs_phy_impacts => 'Physical impacts';

  @override
  String get obs_temoins => 'Possible witnesses';

  @override
  String get obs_remarques => 'Other comments';

  @override
  String get obs_localisation => 'Localisation approximative';

  @override
  String get obs_detail_page_delete => 'Delete observation';

  @override
  String get obs_form_page_title => 'Modify observation';

  @override
  String get obs_list_page_list => 'Records';

  @override
  String get obs_list_page_refresh => 'Refresh';

  @override
  String get obs_list_page_no_date_place =>
      'Observation without location or date';

  @override
  String get obs_list_page_list_more => 'Load more';

  @override
  String get options_page_db => 'DB Options';

  @override
  String get options_page_db_tab_rec => 'Records';

  @override
  String get options_page_db_tab_db => 'Database';

  @override
  String get options_page_db_list => 'Database';

  @override
  String get options_page_db_export => 'Export Database';

  @override
  String get options_page_db_export_sub => 'Export database to Document folder';

  @override
  String get options_page_db_import => 'Import Database';

  @override
  String get options_page_db_import_sub =>
      'From Documents/JournalTI folder (observations_export.db)';

  @override
  String get options_page_db_import_confirm => 'Confirm import';

  @override
  String get options_page_db_import_confirm_sub =>
      'Import this file and overwrite current database?';

  @override
  String get options_page_db_delete_all => 'Delete entire database';

  @override
  String get options_page_db_delete_all_sub => 'Irreversible operation';

  @override
  String get geoloc_unknow => 'Unknown address';

  @override
  String get pdf_utils_section_datetime => 'Date & Time';

  @override
  String get pdf_utils_section_place => 'Location / Context';

  @override
  String get pdf_utils_section_observation => 'Observation';

  @override
  String get pdf_utils_section_impacts => 'Felt impacts';

  @override
  String get pdf_utils_section_other => 'Others';

  @override
  String get pdf_utils_report_title => 'Observations report';

  @override
  String get pdf_utils_report_place => 'Established in';

  @override
  String get pdf_utils_report_date => 'Date';

  @override
  String get pdf_utils_report_hour => 'Time';

  @override
  String get pdf_utils_report_nb_obs => 'Number of observations';

  @override
  String get app_menu_title => 'Menu';

  @override
  String get app_menu_observation => 'New observation';

  @override
  String get app_menu_pdf_files => 'Export to PDF';

  @override
  String get app_menu_pdf_report => 'Create PDF report';

  @override
  String get app_menu_xlsx_export => 'Export to Excel';

  @override
  String get app_menu_db_options => 'DB Options';

  @override
  String get app_menu_language => 'Language';

  @override
  String get app_menu_help => 'Help';

  @override
  String get app_menu_about => 'About';

  @override
  String get app_menu_exit => 'Exit';

  @override
  String get obs_list_street => 'Street';

  @override
  String get obs_list_home => 'Home';

  @override
  String get obs_list_work => 'Work';

  @override
  String get obs_list_elevator => 'Elevator/Stairs';

  @override
  String get obs_list_transport => 'Public transport';

  @override
  String get obs_list_station => 'Station/Airport';

  @override
  String get obs_list_gym => 'Gym';

  @override
  String get obs_list_waiting_room => 'Waiting room';

  @override
  String get obs_list_park => 'Park/Garden';

  @override
  String get obs_list_other => 'Other';

  @override
  String get obs_list_interaction_niveau1 =>
      'Close relationships (family, friends, spouse)';

  @override
  String get obs_list_interaction_niveau2 =>
      'Extended circle (colleagues, neighbors, acquaintances)';

  @override
  String get obs_list_interaction_niveau3 =>
      'Institutional interactions (professional, departmental)';

  @override
  String get obs_list_interaction_niveau4 =>
      'Social or online activities (social networks, groups)';

  @override
  String get obs_list_interaction_niveau5 =>
      'Unknown person (public, unknown online)';

  @override
  String get obs_list_interaction_niveau6 => 'Other (specify in the comments)';

  @override
  String get obs_list_interact_visual => 'Visual';

  @override
  String get obs_list_interact_verbal => 'Verbal';

  @override
  String get obs_list_interact_sound => 'Sound';

  @override
  String get obs_list_interact_tactile => 'Tactile';

  @override
  String get obs_list_interact_other => 'Other';

  @override
  String get obs_list_impact_phy_pain =>
      'Targeted pain (limbs, face, genital areas)';

  @override
  String get obs_list_impact_phy_oppression =>
      'Chest oppression sensation, respiratory manipulation';

  @override
  String get obs_list_impact_phy_voice_intra_audible =>
      'Audible intracranial sound/voices';

  @override
  String get obs_list_impact_phy_voice_intra_sub =>
      'Subliminal intracranial sound/voices';

  @override
  String get obs_list_impact_phy_voice_ext_audible =>
      'Audible external sound/voices';

  @override
  String get obs_list_impact_phy_voice_ext_sub =>
      'Subliminal external sound/voices';

  @override
  String get obs_list_impact_phy_heat => 'Hot flashes, localized burns';

  @override
  String get obs_list_impact_phy_vibration => 'Body vibrations, muscle tremors';

  @override
  String get obs_list_impact_phy_electric =>
      'Electric tingling, numbness, needle-like sensations';

  @override
  String get obs_list_impact_phy_shock => 'Body shocks, sudden impulses';

  @override
  String get obs_list_impact_phy_pressure_head =>
      'Cranial pressure, pressure on skull muscles';

  @override
  String get obs_list_impact_phy_pressure_body =>
      'Targeted pressure on certain body areas';

  @override
  String get obs_list_impact_phy_whistle =>
      'Artificial tinnitus, whistling, sound waves';

  @override
  String get obs_list_impact_phy_excitation =>
      'Forced nervous or genital excitation';

  @override
  String get obs_list_impact_phy_fatigue =>
      'Sudden fatigue, recurrent drowsiness, exhaustion';

  @override
  String get obs_list_impact_phy_sleep =>
      'Sleep disturbances, inability to sleep, forced awakenings, controlled dreams';

  @override
  String get obs_list_impact_phy_balance =>
      'Coordination and balance disorders';

  @override
  String get obs_list_impact_phy_hallucinations =>
      'Forced visions, visual or sensory hallucinations';

  @override
  String get obs_list_impact_phy_members =>
      'Remote muscular control, forced limb movements';

  @override
  String get obs_list_impact_phy_other_perception =>
      'Other abnormal perception';

  @override
  String get obs_list_impact_phy_other => 'Other, to be specified in Remarks';

  @override
  String get obs_list_impact_psy_surprise =>
      'Shock or sudden astonishment in response to unexplained sensations or phenomena';

  @override
  String get obs_list_impact_psy_incomprehension =>
      'Difficulty understanding the cause or meaning of events';

  @override
  String get obs_list_impact_psy_anxiety =>
      'Persistent worry due to the repetition or intensity of symptoms';

  @override
  String get obs_list_impact_psy_fear =>
      'Fear of losing control over one’s body or mind';

  @override
  String get obs_list_impact_psy_anger =>
      'Anger toward the presumed aggressor or the surrounding helplessness';

  @override
  String get obs_list_impact_psy_irritation =>
      'Irritation caused by constant discomfort or forced interruptions';

  @override
  String get obs_list_impact_psy_humiliation =>
      'Feeling degraded or violated in one’s bodily intimacy';

  @override
  String get obs_list_impact_psy_sadness =>
      'Sadness or despair caused by the persistence of attacks';

  @override
  String get obs_list_impact_psy_guilt =>
      'Unjustified guilt, tendency to blame oneself';

  @override
  String get obs_list_impact_psy_helplessness =>
      'Feeling unable to stop or prevent the symptoms';

  @override
  String get obs_list_impact_psy_hypervigilance =>
      'Constant monitoring of the environment and one’s own sensations';

  @override
  String get obs_list_impact_psy_confusion =>
      'Mental disorientation, altered perception of reality';

  @override
  String get obs_list_impact_psy_shame =>
      'Shame related to intimate or visible symptoms';

  @override
  String get obs_list_impact_psy_disgust =>
      'Disgust toward the situation or the effects endured';

  @override
  String get obs_list_impact_psy_resignation =>
      'Progressive resignation in the face of a perceived lack of solution';

  @override
  String get obs_list_impact_psy_isolation =>
      'Feeling socially isolated and misunderstood by others';

  @override
  String get obs_list_impact_psy_other =>
      'Other emotional or cognitive reaction, to be specified in Remarks';
}
