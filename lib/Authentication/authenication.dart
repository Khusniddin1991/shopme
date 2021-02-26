import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'package:e_shop/Config/config.dart';


class AuthenticScreen extends StatefulWidget {
  static final String id='AuthenticScreen';
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient:LinearGradient(
                    colors:[Colors.teal,Colors.deepPurple],
                    begin:Alignment.bottomRight,
                    end: Alignment.center,
                    stops:[0.0,1.0]
                )
            ),
          ),title: Text('ShopMe',style: TextStyle(fontFamily: 'Signatra',fontSize: 25,fontWeight: FontWeight.bold),),centerTitle:true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon:Icon(Icons.lock),
                text: 'Sign In'),
              Tab(
                  icon:Icon(Icons.person),
                  text: 'Sign Up'),

            ],
            indicatorColor: Colors.yellowAccent,
            indicatorWeight: 5.0,
          ),
        ),

        body:Center(
          child: Container(
            decoration: BoxDecoration(
                gradient:LinearGradient(
                    colors:[Colors.teal,Colors.deepPurple],
                    begin:Alignment.bottomRight,
                    end: Alignment.center,
                    stops:[0.0,1.0]
                )
            ),
      child: TabBarView(
            children: [
              Login(),
              Register()
            ],
          ),
          ),
        ),
      ));
  }
}
