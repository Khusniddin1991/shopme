import 'package:flutter/foundation.dart';
import 'package:e_shop/Config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItemCounter extends ChangeNotifier{


  int _counter=EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length-1;
  int get count =>_counter;

  display()async{
    _counter=EcommerceApp.sharedPreferences.getString(EcommerceApp.userCartList).length-1;

    await Future.delayed(Duration(seconds: 1),(){
      notifyListeners();
    });



  }





}