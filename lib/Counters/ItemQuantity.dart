import 'package:flutter/foundation.dart';

class ItemQuantity with ChangeNotifier {

  int _numberofitem=0;
  int get numberofitems=>_numberofitem;


  display(int number){
    _numberofitem= number;
notifyListeners();

  }



}
