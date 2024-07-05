import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProductImage(String path, String fileName) async {
    final ref = _storage.ref().child('image/$fileName');
    await ref.putFile(File(path));
    return await ref.getDownloadURL();
  }
}
