import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'TI Journal'**
  String get title;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello EN'**
  String get hello;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @app_menu_version.
  ///
  /// In en, this message translates to:
  /// **''**
  String get app_menu_version;

  /// No description provided for @app_update_page.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get app_update_page;

  /// No description provided for @app_update_available.
  ///
  /// In en, this message translates to:
  /// **'Update available'**
  String get app_update_available;

  /// No description provided for @app_update_old_version.
  ///
  /// In en, this message translates to:
  /// **'Your version'**
  String get app_update_old_version;

  /// No description provided for @app_update_new_version.
  ///
  /// In en, this message translates to:
  /// **'New version'**
  String get app_update_new_version;

  /// No description provided for @app_update_button.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get app_update_button;

  /// No description provided for @app_update_check.
  ///
  /// In en, this message translates to:
  /// **'Check update'**
  String get app_update_check;

  /// No description provided for @skbar_backup_message.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget to regularly backup your database and your Documents/JounalTI folder.'**
  String get skbar_backup_message;

  /// No description provided for @skbar_update_isupdate.
  ///
  /// In en, this message translates to:
  /// **'Your version is up to date.'**
  String get skbar_update_isupdate;

  /// No description provided for @skbar_update_ok.
  ///
  /// In en, this message translates to:
  /// **'Update success.'**
  String get skbar_update_ok;

  /// No description provided for @skbar_update_false.
  ///
  /// In en, this message translates to:
  /// **'Update false.'**
  String get skbar_update_false;

  /// No description provided for @about_title.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about_title;

  /// No description provided for @about_text.
  ///
  /// In en, this message translates to:
  /// **'This app allows you to log observed facts related to suspected electromagnetic, sound, and gangstalking harassment situations.\n\nIt is not a proof, but an aid to record experiences perceived as harassment.\n\nThe app uses your phone\'s approximate geolocation.\n\nData can be saved to an MS Excel© file, and you can generate an observation report in a shareable PDF format.\n\nThis app is provided AS IS, without any warranty.'**
  String get about_text;

  /// No description provided for @help_title.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help_title;

  /// No description provided for @help_title_sub.
  ///
  /// In en, this message translates to:
  /// **'Explanations on how Journal de TI works'**
  String get help_title_sub;

  /// No description provided for @help_section_app.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get help_section_app;

  /// No description provided for @help_section_options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get help_section_options;

  /// No description provided for @help_section_obs.
  ///
  /// In en, this message translates to:
  /// **'Observations'**
  String get help_section_obs;

  /// No description provided for @help_section_import_export.
  ///
  /// In en, this message translates to:
  /// **'Import/Export'**
  String get help_section_import_export;

  /// No description provided for @help_section_db.
  ///
  /// In en, this message translates to:
  /// **'Data Base'**
  String get help_section_db;

  /// No description provided for @help_text_app.
  ///
  /// In en, this message translates to:
  /// **'The application allows you to create and feed a database containing the records of your observations.\n\nWhen creating an observation, your approximate location will allow you to determine the location of your observation.\n\nYou have different fields: Date: The date added automatically, but editable.\nTime: The time added automatically, but editable.\nApproximate location: The automatic location of the observation location.\nObservation location: The more precise location of your observation.\nLocation details: Any details about the location.\nObserved behavior: The behaviors observed.\nPeople involved: The people involved in the observation.\nInteraction type: The type of interactions observed.\nInteraction link: Your link with the people involved in the observation.\nRecurrence: If it is a recurring behavior or situation.\nPsychological impacts: The impacts psychological impacts this situation had on you.\nPhysical impacts: The physical impacts this event had on you.\nWitnesses: People who can testify to this situation.\nComments: Your additional comments.\n\nYou can modify or delete your observation later in the List tab of the form.'**
  String get help_text_app;

  /// No description provided for @help_text_options.
  ///
  /// In en, this message translates to:
  /// **'The application menu offers several options:\nNew observation: Allows you to create a new observation.\nExport to PDF: To create and export reports and graphs in PDF.\nExport to Excel: To create and export data in Excel.\nDB Options: Allows you to import/export your database to the Documents/JournalTI folder.\nLanguage: Allows you to choose the application language.\nHelp: To access Help.\nAbout: To access About.\nExit: To exit the application.'**
  String get help_text_options;

  /// No description provided for @help_text_obs.
  ///
  /// In en, this message translates to:
  /// **'In the \'Observation\' tab, you can record the events you observe, including time, location, interactions, and perceived impacts.'**
  String get help_text_obs;

  /// No description provided for @help_text_import_export.
  ///
  /// In en, this message translates to:
  /// **'Your data and files are saved in the Documents/JournalTI folder.\n\nYou will find the rapport_.... and chart_.... PDF documents there, as well as a copy of your database, if you have made one, observations_export.db.'**
  String get help_text_import_export;

  /// No description provided for @help_text_db.
  ///
  /// In en, this message translates to:
  /// **'Make regular copies of your Documents/JournalTI folder.\n\nIf you have accidentally uninstalled the application, if the Documents/JournalTI folder is still present with the observations_export.db file, you can reimport it from the Database menu options.'**
  String get help_text_db;

  /// No description provided for @db_page_date_unknow.
  ///
  /// In en, this message translates to:
  /// **'Unknown date'**
  String get db_page_date_unknow;

  /// No description provided for @db_page_lieu_unknow.
  ///
  /// In en, this message translates to:
  /// **'Unknown location'**
  String get db_page_lieu_unknow;

  /// No description provided for @db_page_location_unknow.
  ///
  /// In en, this message translates to:
  /// **'Unknown approximate address'**
  String get db_page_location_unknow;

  /// No description provided for @db_page_date_lieu_unknow.
  ///
  /// In en, this message translates to:
  /// **'Unknown date and location'**
  String get db_page_date_lieu_unknow;

  /// No description provided for @db_page_records.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get db_page_records;

  /// No description provided for @alert_dialog_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get alert_dialog_confirm;

  /// No description provided for @alert_dialog_confirm_delete.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this record?'**
  String get alert_dialog_confirm_delete;

  /// No description provided for @alert_dialog_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get alert_dialog_cancel;

  /// No description provided for @alert_dialog_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get alert_dialog_delete;

  /// No description provided for @alert_dialog_del_ok.
  ///
  /// In en, this message translates to:
  /// **'Successfully deleted'**
  String get alert_dialog_del_ok;

  /// No description provided for @alert_dialog_del_rec_ok.
  ///
  /// In en, this message translates to:
  /// **'Record deleted.'**
  String get alert_dialog_del_rec_ok;

  /// No description provided for @alert_dialog_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get alert_dialog_ok;

  /// No description provided for @alert_dialog_del_all_files.
  ///
  /// In en, this message translates to:
  /// **'Delete all files'**
  String get alert_dialog_del_all_files;

  /// No description provided for @alert_dialog_confirm_delete_all.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete all files?'**
  String get alert_dialog_confirm_delete_all;

  /// No description provided for @alert_dialog_exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get alert_dialog_exit;

  /// No description provided for @alert_dialog_exit_confirm.
  ///
  /// In en, this message translates to:
  /// **'Do you want to exit the app?'**
  String get alert_dialog_exit_confirm;

  /// No description provided for @alert_dialog_delete_db.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete the entire database?\nThis action is IRREVERSIBLE!'**
  String get alert_dialog_delete_db;

  /// No description provided for @alert_dialog_delete_db_ok.
  ///
  /// In en, this message translates to:
  /// **'The database has been successfully deleted.'**
  String get alert_dialog_delete_db_ok;

  /// No description provided for @skbar_granted_refused.
  ///
  /// In en, this message translates to:
  /// **'Permission denied.'**
  String get skbar_granted_refused;

  /// No description provided for @skbar_granted_file_refused.
  ///
  /// In en, this message translates to:
  /// **'Permission denied. Cannot open file.'**
  String get skbar_granted_file_refused;

  /// No description provided for @skbar_export_empty.
  ///
  /// In en, this message translates to:
  /// **'No observation to export'**
  String get skbar_export_empty;

  /// No description provided for @skbar_export_ok.
  ///
  /// In en, this message translates to:
  /// **'Excel export completed'**
  String get skbar_export_ok;

  /// No description provided for @skbar_export_db_ok.
  ///
  /// In en, this message translates to:
  /// **'Database exported successfully'**
  String get skbar_export_db_ok;

  /// No description provided for @skbar_import_db_ok.
  ///
  /// In en, this message translates to:
  /// **'Database imported successfully'**
  String get skbar_import_db_ok;

  /// No description provided for @skbar_save_db_ok.
  ///
  /// In en, this message translates to:
  /// **'Observation saved to DB'**
  String get skbar_save_db_ok;

  /// No description provided for @skbar_form_complet.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required fields'**
  String get skbar_form_complet;

  /// No description provided for @skbar_no_file.
  ///
  /// In en, this message translates to:
  /// **'File not found'**
  String get skbar_no_file;

  /// No description provided for @skbar_pdf_file.
  ///
  /// In en, this message translates to:
  /// **'PDF created with'**
  String get skbar_pdf_file;

  /// No description provided for @skbar_pdf_chart_created.
  ///
  /// In en, this message translates to:
  /// **'PDF chart successfully generated'**
  String get skbar_pdf_chart_created;

  /// No description provided for @pdf_page_title.
  ///
  /// In en, this message translates to:
  /// **'Saved PDF files'**
  String get pdf_page_title;

  /// No description provided for @pdf_page_delete_select.
  ///
  /// In en, this message translates to:
  /// **'Delete selection'**
  String get pdf_page_delete_select;

  /// No description provided for @pdf_page_delete_all.
  ///
  /// In en, this message translates to:
  /// **'Delete all'**
  String get pdf_page_delete_all;

  /// No description provided for @pdf_page_empty_dir.
  ///
  /// In en, this message translates to:
  /// **'No PDF found'**
  String get pdf_page_empty_dir;

  /// No description provided for @pdf_page_reports.
  ///
  /// In en, this message translates to:
  /// **'Report Files'**
  String get pdf_page_reports;

  /// No description provided for @pdf_page_charts.
  ///
  /// In en, this message translates to:
  /// **'Chart Files'**
  String get pdf_page_charts;

  /// No description provided for @pdf_chart_title.
  ///
  /// In en, this message translates to:
  /// **'Statistical Charts'**
  String get pdf_chart_title;

  /// No description provided for @pdf_chart_subtitle.
  ///
  /// In en, this message translates to:
  /// **'\'Statistical Charts Location, Interact Types, Interact Links\''**
  String get pdf_chart_subtitle;

  /// No description provided for @logger_open_ok.
  ///
  /// In en, this message translates to:
  /// **'Opened successfully'**
  String get logger_open_ok;

  /// No description provided for @xlsx_page_title.
  ///
  /// In en, this message translates to:
  /// **'Saved EXCEL files'**
  String get xlsx_page_title;

  /// No description provided for @xlsx_page_generate.
  ///
  /// In en, this message translates to:
  /// **'Click to regenerate spreadsheet file'**
  String get xlsx_page_generate;

  /// No description provided for @xlsx_page_export.
  ///
  /// In en, this message translates to:
  /// **'Export all observations to Excel'**
  String get xlsx_page_export;

  /// No description provided for @xlsx_page_empty_dir.
  ///
  /// In en, this message translates to:
  /// **'No XLSX file found'**
  String get xlsx_page_empty_dir;

  /// No description provided for @journal_page_tab_obs.
  ///
  /// In en, this message translates to:
  /// **'Observation'**
  String get journal_page_tab_obs;

  /// No description provided for @journal_page_tab_lst.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get journal_page_tab_lst;

  /// No description provided for @journal_page_export_pdf.
  ///
  /// In en, this message translates to:
  /// **'Export to PDF'**
  String get journal_page_export_pdf;

  /// No description provided for @journal_page_export_charts.
  ///
  /// In en, this message translates to:
  /// **'Export charts'**
  String get journal_page_export_charts;

  /// No description provided for @journal_page_share_export.
  ///
  /// In en, this message translates to:
  /// **'Do you want to share the PDF file after export?'**
  String get journal_page_share_export;

  /// No description provided for @button_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get button_yes;

  /// No description provided for @button_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get button_no;

  /// No description provided for @button_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get button_delete;

  /// No description provided for @button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get button_cancel;

  /// No description provided for @button_import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get button_import;

  /// No description provided for @button_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get button_save;

  /// No description provided for @button_modify.
  ///
  /// In en, this message translates to:
  /// **'Modify'**
  String get button_modify;

  /// No description provided for @button_refresh.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get button_refresh;

  /// No description provided for @button_up.
  ///
  /// In en, this message translates to:
  /// **'Scroll to top'**
  String get button_up;

  /// No description provided for @language_page_title.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get language_page_title;

  /// No description provided for @obs_detail_page_title.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get obs_detail_page_title;

  /// No description provided for @obs_detail_page_title_sheet.
  ///
  /// In en, this message translates to:
  /// **'Observation Sheet'**
  String get obs_detail_page_title_sheet;

  /// No description provided for @obs_id.
  ///
  /// In en, this message translates to:
  /// **'Id'**
  String get obs_id;

  /// No description provided for @obs_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get obs_date;

  /// No description provided for @obs_hour.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get obs_hour;

  /// No description provided for @obs_place.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get obs_place;

  /// No description provided for @obs_detail_place.
  ///
  /// In en, this message translates to:
  /// **'Location details'**
  String get obs_detail_place;

  /// No description provided for @obs_comportement.
  ///
  /// In en, this message translates to:
  /// **'Observed behavior'**
  String get obs_comportement;

  /// No description provided for @obs_personnes.
  ///
  /// In en, this message translates to:
  /// **'People involved'**
  String get obs_personnes;

  /// No description provided for @obs_interaction_type.
  ///
  /// In en, this message translates to:
  /// **'Interact Type'**
  String get obs_interaction_type;

  /// No description provided for @obs_interaction_link.
  ///
  /// In en, this message translates to:
  /// **'Interact Link'**
  String get obs_interaction_link;

  /// No description provided for @obs_repeat.
  ///
  /// In en, this message translates to:
  /// **'Similar pattern (already observed)'**
  String get obs_repeat;

  /// No description provided for @obs_psy_impacts.
  ///
  /// In en, this message translates to:
  /// **'Psychological impacts'**
  String get obs_psy_impacts;

  /// No description provided for @obs_phy_impacts.
  ///
  /// In en, this message translates to:
  /// **'Physical impacts'**
  String get obs_phy_impacts;

  /// No description provided for @obs_temoins.
  ///
  /// In en, this message translates to:
  /// **'Possible witnesses'**
  String get obs_temoins;

  /// No description provided for @obs_remarques.
  ///
  /// In en, this message translates to:
  /// **'Other comments'**
  String get obs_remarques;

  /// No description provided for @obs_localisation.
  ///
  /// In en, this message translates to:
  /// **'Localisation approximative'**
  String get obs_localisation;

  /// No description provided for @obs_detail_page_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete observation'**
  String get obs_detail_page_delete;

  /// No description provided for @obs_form_page_title.
  ///
  /// In en, this message translates to:
  /// **'Modify observation'**
  String get obs_form_page_title;

  /// No description provided for @obs_list_page_list.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get obs_list_page_list;

  /// No description provided for @obs_list_page_refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get obs_list_page_refresh;

  /// No description provided for @obs_list_page_no_date_place.
  ///
  /// In en, this message translates to:
  /// **'Observation without location or date'**
  String get obs_list_page_no_date_place;

  /// No description provided for @obs_list_page_list_more.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get obs_list_page_list_more;

  /// No description provided for @options_page_db.
  ///
  /// In en, this message translates to:
  /// **'DB Options'**
  String get options_page_db;

  /// No description provided for @options_page_db_tab_rec.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get options_page_db_tab_rec;

  /// No description provided for @options_page_db_tab_db.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get options_page_db_tab_db;

  /// No description provided for @options_page_db_list.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get options_page_db_list;

  /// No description provided for @options_page_db_export.
  ///
  /// In en, this message translates to:
  /// **'Export Database'**
  String get options_page_db_export;

  /// No description provided for @options_page_db_export_sub.
  ///
  /// In en, this message translates to:
  /// **'Export database to Document folder'**
  String get options_page_db_export_sub;

  /// No description provided for @options_page_db_import.
  ///
  /// In en, this message translates to:
  /// **'Import Database'**
  String get options_page_db_import;

  /// No description provided for @options_page_db_import_sub.
  ///
  /// In en, this message translates to:
  /// **'From Documents/JournalTI folder (observations_export.db)'**
  String get options_page_db_import_sub;

  /// No description provided for @options_page_db_import_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm import'**
  String get options_page_db_import_confirm;

  /// No description provided for @options_page_db_import_confirm_sub.
  ///
  /// In en, this message translates to:
  /// **'Import this file and overwrite current database?'**
  String get options_page_db_import_confirm_sub;

  /// No description provided for @options_page_db_delete_all.
  ///
  /// In en, this message translates to:
  /// **'Delete entire database'**
  String get options_page_db_delete_all;

  /// No description provided for @options_page_db_delete_all_sub.
  ///
  /// In en, this message translates to:
  /// **'Irreversible operation'**
  String get options_page_db_delete_all_sub;

  /// No description provided for @geoloc_unknow.
  ///
  /// In en, this message translates to:
  /// **'Unknown address'**
  String get geoloc_unknow;

  /// No description provided for @pdf_utils_section_datetime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get pdf_utils_section_datetime;

  /// No description provided for @pdf_utils_section_place.
  ///
  /// In en, this message translates to:
  /// **'Location / Context'**
  String get pdf_utils_section_place;

  /// No description provided for @pdf_utils_section_observation.
  ///
  /// In en, this message translates to:
  /// **'Observation'**
  String get pdf_utils_section_observation;

  /// No description provided for @pdf_utils_section_impacts.
  ///
  /// In en, this message translates to:
  /// **'Felt impacts'**
  String get pdf_utils_section_impacts;

  /// No description provided for @pdf_utils_section_other.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get pdf_utils_section_other;

  /// No description provided for @pdf_utils_report_title.
  ///
  /// In en, this message translates to:
  /// **'Observations report'**
  String get pdf_utils_report_title;

  /// No description provided for @pdf_utils_report_place.
  ///
  /// In en, this message translates to:
  /// **'Established in'**
  String get pdf_utils_report_place;

  /// No description provided for @pdf_utils_report_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get pdf_utils_report_date;

  /// No description provided for @pdf_utils_report_hour.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get pdf_utils_report_hour;

  /// No description provided for @pdf_utils_report_nb_obs.
  ///
  /// In en, this message translates to:
  /// **'Number of observations'**
  String get pdf_utils_report_nb_obs;

  /// No description provided for @app_menu_title.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get app_menu_title;

  /// No description provided for @app_menu_observation.
  ///
  /// In en, this message translates to:
  /// **'New observation'**
  String get app_menu_observation;

  /// No description provided for @app_menu_pdf_files.
  ///
  /// In en, this message translates to:
  /// **'Export to PDF'**
  String get app_menu_pdf_files;

  /// No description provided for @app_menu_pdf_report.
  ///
  /// In en, this message translates to:
  /// **'Create PDF report'**
  String get app_menu_pdf_report;

  /// No description provided for @app_menu_xlsx_export.
  ///
  /// In en, this message translates to:
  /// **'Export to Excel'**
  String get app_menu_xlsx_export;

  /// No description provided for @app_menu_db_options.
  ///
  /// In en, this message translates to:
  /// **'DB Options'**
  String get app_menu_db_options;

  /// No description provided for @app_menu_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get app_menu_language;

  /// No description provided for @app_menu_help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get app_menu_help;

  /// No description provided for @app_menu_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get app_menu_about;

  /// No description provided for @app_menu_exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get app_menu_exit;

  /// No description provided for @obs_list_street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get obs_list_street;

  /// No description provided for @obs_list_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get obs_list_home;

  /// No description provided for @obs_list_work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get obs_list_work;

  /// No description provided for @obs_list_elevator.
  ///
  /// In en, this message translates to:
  /// **'Elevator/Stairs'**
  String get obs_list_elevator;

  /// No description provided for @obs_list_transport.
  ///
  /// In en, this message translates to:
  /// **'Public transport'**
  String get obs_list_transport;

  /// No description provided for @obs_list_station.
  ///
  /// In en, this message translates to:
  /// **'Station/Airport'**
  String get obs_list_station;

  /// No description provided for @obs_list_gym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get obs_list_gym;

  /// No description provided for @obs_list_waiting_room.
  ///
  /// In en, this message translates to:
  /// **'Waiting room'**
  String get obs_list_waiting_room;

  /// No description provided for @obs_list_park.
  ///
  /// In en, this message translates to:
  /// **'Park/Garden'**
  String get obs_list_park;

  /// No description provided for @obs_list_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get obs_list_other;

  /// No description provided for @obs_list_interaction_niveau1.
  ///
  /// In en, this message translates to:
  /// **'Close relationships (family, friends, spouse)'**
  String get obs_list_interaction_niveau1;

  /// No description provided for @obs_list_interaction_niveau2.
  ///
  /// In en, this message translates to:
  /// **'Extended circle (colleagues, neighbors, acquaintances)'**
  String get obs_list_interaction_niveau2;

  /// No description provided for @obs_list_interaction_niveau3.
  ///
  /// In en, this message translates to:
  /// **'Institutional interactions (professional, departmental)'**
  String get obs_list_interaction_niveau3;

  /// No description provided for @obs_list_interaction_niveau4.
  ///
  /// In en, this message translates to:
  /// **'Social or online activities (social networks, groups)'**
  String get obs_list_interaction_niveau4;

  /// No description provided for @obs_list_interaction_niveau5.
  ///
  /// In en, this message translates to:
  /// **'Unknown person (public, unknown online)'**
  String get obs_list_interaction_niveau5;

  /// No description provided for @obs_list_interaction_niveau6.
  ///
  /// In en, this message translates to:
  /// **'Other (specify in the comments)'**
  String get obs_list_interaction_niveau6;

  /// No description provided for @obs_list_interact_visual.
  ///
  /// In en, this message translates to:
  /// **'Visual'**
  String get obs_list_interact_visual;

  /// No description provided for @obs_list_interact_verbal.
  ///
  /// In en, this message translates to:
  /// **'Verbal'**
  String get obs_list_interact_verbal;

  /// No description provided for @obs_list_interact_sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get obs_list_interact_sound;

  /// No description provided for @obs_list_interact_tactile.
  ///
  /// In en, this message translates to:
  /// **'Tactile'**
  String get obs_list_interact_tactile;

  /// No description provided for @obs_list_interact_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get obs_list_interact_other;

  /// No description provided for @obs_list_impact_phy_pain.
  ///
  /// In en, this message translates to:
  /// **'Targeted pain (limbs, face, genital areas)'**
  String get obs_list_impact_phy_pain;

  /// No description provided for @obs_list_impact_phy_oppression.
  ///
  /// In en, this message translates to:
  /// **'Chest oppression sensation, respiratory manipulation'**
  String get obs_list_impact_phy_oppression;

  /// No description provided for @obs_list_impact_phy_voice_intra_audible.
  ///
  /// In en, this message translates to:
  /// **'Audible intracranial sound/voices'**
  String get obs_list_impact_phy_voice_intra_audible;

  /// No description provided for @obs_list_impact_phy_voice_intra_sub.
  ///
  /// In en, this message translates to:
  /// **'Subliminal intracranial sound/voices'**
  String get obs_list_impact_phy_voice_intra_sub;

  /// No description provided for @obs_list_impact_phy_voice_ext_audible.
  ///
  /// In en, this message translates to:
  /// **'Audible external sound/voices'**
  String get obs_list_impact_phy_voice_ext_audible;

  /// No description provided for @obs_list_impact_phy_voice_ext_sub.
  ///
  /// In en, this message translates to:
  /// **'Subliminal external sound/voices'**
  String get obs_list_impact_phy_voice_ext_sub;

  /// No description provided for @obs_list_impact_phy_heat.
  ///
  /// In en, this message translates to:
  /// **'Hot flashes, localized burns'**
  String get obs_list_impact_phy_heat;

  /// No description provided for @obs_list_impact_phy_vibration.
  ///
  /// In en, this message translates to:
  /// **'Body vibrations, muscle tremors'**
  String get obs_list_impact_phy_vibration;

  /// No description provided for @obs_list_impact_phy_electric.
  ///
  /// In en, this message translates to:
  /// **'Electric tingling, numbness, needle-like sensations'**
  String get obs_list_impact_phy_electric;

  /// No description provided for @obs_list_impact_phy_shock.
  ///
  /// In en, this message translates to:
  /// **'Body shocks, sudden impulses'**
  String get obs_list_impact_phy_shock;

  /// No description provided for @obs_list_impact_phy_pressure_head.
  ///
  /// In en, this message translates to:
  /// **'Cranial pressure, pressure on skull muscles'**
  String get obs_list_impact_phy_pressure_head;

  /// No description provided for @obs_list_impact_phy_pressure_body.
  ///
  /// In en, this message translates to:
  /// **'Targeted pressure on certain body areas'**
  String get obs_list_impact_phy_pressure_body;

  /// No description provided for @obs_list_impact_phy_whistle.
  ///
  /// In en, this message translates to:
  /// **'Artificial tinnitus, whistling, sound waves'**
  String get obs_list_impact_phy_whistle;

  /// No description provided for @obs_list_impact_phy_excitation.
  ///
  /// In en, this message translates to:
  /// **'Forced nervous or genital excitation'**
  String get obs_list_impact_phy_excitation;

  /// No description provided for @obs_list_impact_phy_fatigue.
  ///
  /// In en, this message translates to:
  /// **'Sudden fatigue, recurrent drowsiness, exhaustion'**
  String get obs_list_impact_phy_fatigue;

  /// No description provided for @obs_list_impact_phy_sleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep disturbances, inability to sleep, forced awakenings, controlled dreams'**
  String get obs_list_impact_phy_sleep;

  /// No description provided for @obs_list_impact_phy_balance.
  ///
  /// In en, this message translates to:
  /// **'Coordination and balance disorders'**
  String get obs_list_impact_phy_balance;

  /// No description provided for @obs_list_impact_phy_hallucinations.
  ///
  /// In en, this message translates to:
  /// **'Forced visions, visual or sensory hallucinations'**
  String get obs_list_impact_phy_hallucinations;

  /// No description provided for @obs_list_impact_phy_members.
  ///
  /// In en, this message translates to:
  /// **'Remote muscular control, forced limb movements'**
  String get obs_list_impact_phy_members;

  /// No description provided for @obs_list_impact_phy_other_perception.
  ///
  /// In en, this message translates to:
  /// **'Other abnormal perception'**
  String get obs_list_impact_phy_other_perception;

  /// No description provided for @obs_list_impact_phy_other.
  ///
  /// In en, this message translates to:
  /// **'Other, to be specified in Remarks'**
  String get obs_list_impact_phy_other;

  /// No description provided for @obs_list_impact_psy_surprise.
  ///
  /// In en, this message translates to:
  /// **'Shock or sudden astonishment in response to unexplained sensations or phenomena'**
  String get obs_list_impact_psy_surprise;

  /// No description provided for @obs_list_impact_psy_incomprehension.
  ///
  /// In en, this message translates to:
  /// **'Difficulty understanding the cause or meaning of events'**
  String get obs_list_impact_psy_incomprehension;

  /// No description provided for @obs_list_impact_psy_anxiety.
  ///
  /// In en, this message translates to:
  /// **'Persistent worry due to the repetition or intensity of symptoms'**
  String get obs_list_impact_psy_anxiety;

  /// No description provided for @obs_list_impact_psy_fear.
  ///
  /// In en, this message translates to:
  /// **'Fear of losing control over one’s body or mind'**
  String get obs_list_impact_psy_fear;

  /// No description provided for @obs_list_impact_psy_anger.
  ///
  /// In en, this message translates to:
  /// **'Anger toward the presumed aggressor or the surrounding helplessness'**
  String get obs_list_impact_psy_anger;

  /// No description provided for @obs_list_impact_psy_irritation.
  ///
  /// In en, this message translates to:
  /// **'Irritation caused by constant discomfort or forced interruptions'**
  String get obs_list_impact_psy_irritation;

  /// No description provided for @obs_list_impact_psy_humiliation.
  ///
  /// In en, this message translates to:
  /// **'Feeling degraded or violated in one’s bodily intimacy'**
  String get obs_list_impact_psy_humiliation;

  /// No description provided for @obs_list_impact_psy_sadness.
  ///
  /// In en, this message translates to:
  /// **'Sadness or despair caused by the persistence of attacks'**
  String get obs_list_impact_psy_sadness;

  /// No description provided for @obs_list_impact_psy_guilt.
  ///
  /// In en, this message translates to:
  /// **'Unjustified guilt, tendency to blame oneself'**
  String get obs_list_impact_psy_guilt;

  /// No description provided for @obs_list_impact_psy_helplessness.
  ///
  /// In en, this message translates to:
  /// **'Feeling unable to stop or prevent the symptoms'**
  String get obs_list_impact_psy_helplessness;

  /// No description provided for @obs_list_impact_psy_hypervigilance.
  ///
  /// In en, this message translates to:
  /// **'Constant monitoring of the environment and one’s own sensations'**
  String get obs_list_impact_psy_hypervigilance;

  /// No description provided for @obs_list_impact_psy_confusion.
  ///
  /// In en, this message translates to:
  /// **'Mental disorientation, altered perception of reality'**
  String get obs_list_impact_psy_confusion;

  /// No description provided for @obs_list_impact_psy_shame.
  ///
  /// In en, this message translates to:
  /// **'Shame related to intimate or visible symptoms'**
  String get obs_list_impact_psy_shame;

  /// No description provided for @obs_list_impact_psy_disgust.
  ///
  /// In en, this message translates to:
  /// **'Disgust toward the situation or the effects endured'**
  String get obs_list_impact_psy_disgust;

  /// No description provided for @obs_list_impact_psy_resignation.
  ///
  /// In en, this message translates to:
  /// **'Progressive resignation in the face of a perceived lack of solution'**
  String get obs_list_impact_psy_resignation;

  /// No description provided for @obs_list_impact_psy_isolation.
  ///
  /// In en, this message translates to:
  /// **'Feeling socially isolated and misunderstood by others'**
  String get obs_list_impact_psy_isolation;

  /// No description provided for @obs_list_impact_psy_other.
  ///
  /// In en, this message translates to:
  /// **'Other emotional or cognitive reaction, to be specified in Remarks'**
  String get obs_list_impact_psy_other;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
