import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageModel extends ChangeNotifier {
  var rawImageObj;
  var analysedImage;
  var analysedDetail;
  var rawImageString;
  var isImportImage;

  void setIsImportImage(status) {
    isImportImage = status;
    notifyListeners();
  }

  void clearIsImportImage() {
    isImportImage = 0;
    notifyListeners();
  }

  void setRawImageObj(rawImg) {
    rawImageObj = rawImg;
    notifyListeners();
  }

  void clearRawImageObj() {
    rawImageObj = null;
    notifyListeners();
  }

  void setRawImageString(rawImg) {
    rawImageString = rawImg;
    notifyListeners();
  }

  void clearRawImageString() {
    rawImageString = null;
    notifyListeners();
  }

  void setAnalysedImage(analysedImg) {
    analysedImage = analysedImg;
    notifyListeners();
  }

  void clearAnalysedImage() {
    analysedImage = Uint8List(0);
    notifyListeners();
  }

  void setAnalysedDetail(analysiedDt) {
    analysedDetail = analysiedDt;
    notifyListeners();
  }

  void clearAnalysedDetail() {
    analysedDetail = [];
    notifyListeners();
  }
}
