import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/addAddress.dart';
import 'package:e_shop/Store/Search.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
         children: [
           Container(
             padding: EdgeInsets.only(top: 20,bottom: 10),
             decoration: BoxDecoration(
                 gradient:LinearGradient(
                     colors:[Colors.teal,Colors.deepPurple],
                     begin:Alignment.bottomRight,
                     end: Alignment.center,
                     stops:[0.0,1.0]
                 )
             ),child:Column(children: [
               Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(80)),
                 ),
                 child: Container(
                   height: 160,
                   width: 160,
                   child:CircleAvatar(backgroundImage:NetworkImage(EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl)) ,),
                 ),
               ),
             Text(EcommerceApp.sharedPreferences.getString(EcommerceApp.userName).toString(),style: TextStyle(fontSize:20,color: Colors.greenAccent,fontWeight: FontWeight.w800),)
           ],),
           ),
           SizedBox(height: 12,),
           Container(
             decoration: BoxDecoration(
                 gradient:LinearGradient(
                     colors:[Colors.teal,Colors.deepPurple],
                     begin:Alignment.bottomRight,
                     end: Alignment.center,
                     stops:[0.0,1.0]
                 )
             ),
             child: Column(children: [
               ListTile(
                 leading: Icon(Icons.home,color: Colors.white,),
                 title: Text("Home",style: TextStyle(color: Colors.white),),
                 onTap: (){
                   Navigator.pushNamed(context,StoreHome.id );
                 },
               ),
               Divider(height: 10,color: Colors.white,thickness: 6.0,),
               ListTile(
                 leading: Icon(Icons.reorder,color: Colors.white,),
                 title: Text("MyOrders",style: TextStyle(color: Colors.white),),
                 onTap: (){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(ctx)=>MyOrders()));
                 },
               ),
               Divider(height: 10,color: Colors.white,thickness: 6.0,),
               ListTile(
                 leading: Icon(Icons.shopping_cart,color: Colors.white,),
                 title: Text("My Cart",style: TextStyle(color: Colors.white),),
                 onTap: (){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(ctx)=>CartPage()));
                 },
               ),
               Divider(height: 10,color: Colors.white,thickness: 6.0,),
               ListTile(
                 leading: Icon(Icons.search,color: Colors.white,),
                 title: Text("Search",style: TextStyle(color: Colors.white),),
                 onTap: (){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(ctx)=>SearchProduct()));
                 },
               ),
               Divider(height: 10,color: Colors.white,thickness: 6.0,),
               ListTile(
                 leading: Icon(Icons.add_location_alt,color: Colors.white,),
                 title: Text("Add New Address",style: TextStyle(color: Colors.white),),
                 onTap: (){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder:(ctx)=>AddAddress()));
                 },
               ),
               Divider(height: 10,color: Colors.white,thickness: 6.0,),
               ListTile(
                 leading: Icon(Icons.exit_to_app,color: Colors.white,),
                 title: Text("Log Out",style: TextStyle(color: Colors.white),),
                 onTap: (){
                  EcommerceApp.auth.signOut().then((value) =>{
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(ctx)=>AuthenticScreen()))

                  });
                 },
               ),
               // Divider(height: 10,color: Colors.white,thickness: 6.0,)
             ],),
           )
           

         ],
      ),
    );
  }
}
