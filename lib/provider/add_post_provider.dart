import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AddPostProvider with ChangeNotifier {
  File? _selectedPostImage;
  File? _selectedPostVideo;

  File? get selectedPostImage => _selectedPostImage;
  File? get selectedPostVideo => _selectedPostVideo;

  void setPostImage(XFile file) {
    _selectedPostImage = File(file.path);
    notifyListeners();
  }

  void setPostVideo(XFile file) {
    _selectedPostVideo = File(file.path);
    notifyListeners();
  }
}
