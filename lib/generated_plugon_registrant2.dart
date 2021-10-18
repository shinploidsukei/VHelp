import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:firebase_storage_web/firebase_storage_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugin(Registrar registrar) {
  FilePickerWeb.registerWith(registrar);
  FirebaseCoreWeb.registerWith(registrar);
  FirebaseStorageWeb.registerWith(registrar);
  registrar.registerMessageHandler();
}
