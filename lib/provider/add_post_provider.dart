import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AddPostProvider with ChangeNotifier {
  File? _setVideoFile;
  File? get videoFile => _setVideoFile;

  void setVideoFile(XFile file) {
    _setVideoFile = File(file.path);
    notifyListeners();
  }

  void clearImage(){
    _setVideoFile = null;
    notifyListeners();
  }
 
}
