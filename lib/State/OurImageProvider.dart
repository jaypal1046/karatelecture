import 'package:flutter/cupertino.dart';
import 'package:karate_lecture/enum/OurEnum.dart';

class ImageUploadProvider with ChangeNotifier {
  OurViewState _ourViewState = OurViewState.IDLE;

  OurViewState get getViewState => _ourViewState;

  void setToLoading() {
    _ourViewState = OurViewState.LOADING;
    notifyListeners();
  }

  void setToIdle() {
    _ourViewState = OurViewState.IDLE;
    notifyListeners();
  }
}