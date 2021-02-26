import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Counters/ItemQuantity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Admin/adminLogin.dart';
import 'Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'Authentication/login.dart';
import 'Counters/cartitemcounter.dart';
import 'Counters/changeAddresss.dart';
import 'Counters/totalMoney.dart';
import 'Store/cart.dart';
import 'Store/storehome.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  EcommerceApp.auth=FirebaseAuth.instance;
  EcommerceApp.sharedPreferences=await SharedPreferences.getInstance();
  EcommerceApp.firestore=Firestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create:(c)=>CartItemCounter()),
      ChangeNotifierProvider(create:(c)=>AddressChanger()),
      ChangeNotifierProvider(create:(c)=>TotalAmount()),
      ChangeNotifierProvider(create:(c)=>ItemQuantity()),




    ],child: MaterialApp(
        title: 'e-Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
        ),routes: {
      StoreHome.id:(ctx)=>StoreHome(),
      Login.id:(ctx)=>Login(),
      AuthenticScreen.id:(ctx)=>AuthenticScreen(),
      AdminSignInScreen.id:(ctx)=>AdminSignInScreen(),
      CartPage.id:(ctx)=>CartPage(),

    },
        home: SplashScreen()
    ),);
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{

  @override
  void initState() {
    super.initState();
    display();
  }


   display(){
    Timer(Duration(seconds: 3),()async{
     await EcommerceApp.auth.currentUser()!=null ?Navigator.pushReplacementNamed(context, StoreHome.id):Navigator.pushReplacementNamed(context, AuthenticScreen.id);
    });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Container(
          decoration: BoxDecoration(
            gradient:LinearGradient(
              colors:[Colors.teal,Colors.deepPurple],
              begin:Alignment.bottomRight,
              end: Alignment.center,
              stops:[0.0,1.0]
            )
          ),
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 200,
                width: 200,
                child: Image.asset('images/welcome.png'),

              ),
              SizedBox(height: 20,),
              Text('We will able to guarantee our production \n furthermore deliver our production on time ',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
            ],
          ),),
        ),
      ),
    );
  }
}
