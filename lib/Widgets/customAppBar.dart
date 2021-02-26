import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'Store/storehome.dart';


class MyAppBar extends StatelessWidget with PreferredSizeWidget
{
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        iconTheme: IconThemeData(
          color: Colors.white
        ),flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient:LinearGradient(
                colors:[Colors.teal,Colors.deepPurple],
                begin:Alignment.bottomRight,
                end: Alignment.center,
                stops:[0.0,1.0]
            )
        ),
      ),centerTitle: true,
          title: Text('ShopMe',style: TextStyle(fontFamily:"Signatra",fontSize: 22,fontWeight: FontWeight.bold),),bottom: bottom,
          actions: [
            Stack(children: [
              IconButton(icon:Icon(Icons.shopping_cart_outlined), onPressed: (){
                Navigator.pushNamed(context, CartPage.id);
              },color: Colors.pink,),

              Positioned(
                  child: Stack(children: [
                    Container(
                      height: 22,
                      width: 20,decoration: BoxDecoration(
                        borderRadius:BorderRadius.all(Radius.circular(15))
                    ),
                      child: Icon(Icons.brightness_1,
                        color: Colors.green,
                        size: 20.0,),
                    ),Positioned(
                        top:3.2,
                        bottom:4.0,
                        right: 2,
                        left: 6.6,
                        child:Consumer<CartItemCounter>(builder:(context,counter,_){
                          return Text(counter.count.toString(),style: TextStyle(color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.w800 ),);
                        } ,)
                    )


                  ],))
            ],)]

      ),
    );

  }


  Size get preferredSize => bottom==null?Size(56,AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}
