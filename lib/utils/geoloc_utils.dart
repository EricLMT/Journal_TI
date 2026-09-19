import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'package:journal_ti/utils/permissions_utils.dart';
//import 'package:journal_ti/utils/locale_language.dart';
import '/l10n/app_localizations.dart';


final logger = Logger();
late AppLocalizations tr;

  Future<bool> demanderPermissionGeoloc() async {
    final status = await PermissionHelper.requestLocationPermission();
    if (!status) {
      logger.i("Permission refusée. Aller dans les paramètres.");
      //openAppSettings(); // Ouvre les paramètres Android automatiquement
      return false;
    }
    return true;
  }

  Future<bool> demanderPermissionsStockage() async {
    final status = await PermissionHelper.requestStoragePermission();
    if (!status) {
      logger.i("Permission refusée. Aller dans les paramètres.");
      //openAppSettings(); // Ouvre les paramètres Android automatiquement
      return false;
    }
    return true;
  }

  String nettoyerRue(String? street) {
    if (street == null) return '';

    return street
    // numéro au début : "16 Rue ..."
        .replaceFirst(RegExp(r'^\d+[A-Za-z]?\s*'), '')

    // numéro à la fin : "Rue ... 16", "16A", "16-18",
    // "16/2", "16 bte 2", "16 boîte 2"
        .replaceFirst(
      RegExp(
        r'\s+\d+[A-Za-z]?'
        r'(?:-\d+)?'
        r'(?:/\d+)?'
        r'(?:\s*(?:bte|bo[iî]te|bus)\s*\d+)?$',
        caseSensitive: false,
      ),
      '',
    )
        .trim();
  }

  Future<void> detecterAdresse(GlobalKey<FormBuilderState> formKey) async {
    final status = await PermissionHelper.requestLocationPermission();
    final result = await PermissionHelper.requestStoragePermission();

    if (!status || !result) {
        return;
    } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        final placemark = placemarks.first;
        // Supprimer les numéros au début ou à la fin de la chaîne
        final rueadresse = placemark.thoroughfare?.trim().isNotEmpty == true
            ? placemark.thoroughfare!.trim()
            : nettoyerRue(placemark.street);

        //final rueadresse = placemark.street
        //    ?.replaceAll(RegExp(r'^\d+\s*'), '') // Numéro en début
        //    .replaceAll(RegExp(r'\s*\d+$'), '') // Numéro en fin
        //    .trim() ?? '';

        String adresse = placemarks.isNotEmpty
            ? "$rueadresse, ${placemarks.first.postalCode} ${placemarks.first
            .locality}, ${placemarks.first.country}"
            : tr.db_page_lieu_unknow;


        formKey.currentState?.patchValue({'localisation': adresse});
    }
  }
  