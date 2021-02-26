import 'package:flutter/cupertino.dart';

class TotalAmount extends ChangeNotifier{

  double _numbero=0;
  double get numberofitems=>_numbero;


  display(double number)async{
    _numbero= number;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1),(){
      notifyListeners();
    });
  }






}