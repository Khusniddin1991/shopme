
import 'package:flutter/foundation.dart';

class AddressChanger extends ChangeNotifier{
  int _numb=0;
  int get number=>_numb;


  display(int number){
    _numb= number;
    notifyListeners();

  }


}