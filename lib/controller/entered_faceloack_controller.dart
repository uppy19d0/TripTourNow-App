import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EnteredFacelockController extends GetxController{
    File? image;
  final picker = ImagePicker();
  Future chooseFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {}
    update();
  }

  Future chooseFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {}
    update();
  }
}