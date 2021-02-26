import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminLogin.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';


class Login extends StatefulWidget {
  static final String id='Login';
  @override
  _LoginState createState() => _LoginState();
}





class _LoginState extends State<Login>
{
  final _password=new TextEditingController();
  final _email=new TextEditingController();
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screnSize=MediaQuery.of(context).size.height;
    double screnWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Colors.deepPurple ,
      body: ListView(children: [
        Center(child: Container(
          decoration: BoxDecoration(
              gradient:LinearGradient(
                  colors:[Colors.teal,Colors.deepPurple],
                  begin:Alignment.bottomRight,
                  end: Alignment.center,
                  stops:[0.0,1.0]
              )
          ),
        ),),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Image.asset('images/login.png',
              height: 240,
              width: 240,),),
              Padding(padding: EdgeInsets.all(10),child: Text('Login  to your account',style: TextStyle(color: Colors.white),),),
              Form(
                key: _formKey,
                child: Column(children: [

                  CustomTextField(
                    controller: _email,
                    hintText: 'Email',
                    isObsecure: false,
                    data:Icons.email,
                  ),
                  CustomTextField(
                    controller: _password,
                    hintText: 'Password',
                    isObsecure: true,
                    data:Icons.lock,
                  ),

                  SizedBox(height: 10,),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: FlatButton(onPressed:(){
                        _password.text.trim().isNotEmpty&&_email.text.trim().isNotEmpty?_logIn():showDialog(context:context,
                            builder: (context)=>ErrorAlertDialog(message: 'Please fill up all of forms',));
                      },
                          child:Center(child: Text('Sign In',
                            style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold),))))
                ]
              )
              ),SizedBox(height: 10,),

              FlatButton.icon(onPressed:(){
                Navigator.pushNamed(context,AdminSignInScreen.id );
              },icon: (Icon(Icons.people,color: Colors.pink,)),
                label: Text("i'm admin",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),),
              )


            ],),)
      ],),


    );
  }

  FirebaseAuth _auth=FirebaseAuth.instance;

  _logIn() async{
    showDialog(context:context,builder:(c){
      return LoadingAlertDialog(message: 'LogIn Process.....',);
    } );
    FirebaseUser firebase;
    await _auth.signInWithEmailAndPassword(email: _email.text.trim(), password: _password.text.trim()).then((aut) =>{
      firebase=aut.user
    }).catchError((eror){
      Navigator.pop(context);
      showDialog(context:context,
        builder:(ctx){
        return ErrorAlertDialog(message: eror.toString(),);
        }
      );

    });
    if(firebase!=null){
      result(firebase).then((value) => {
        Navigator.pop(context),
        Navigator.pushNamed(context, StoreHome.id)
      });;
    }

  }
 Future<void> result(FirebaseUser user)async{
    Firestore.instance.collection("user").document(user.uid).get().then((snapshotdata)async {

    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userUID,snapshotdata.data[EcommerceApp.userUID]);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail, snapshotdata.data[EcommerceApp.userEmail]);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName,snapshotdata.data[EcommerceApp.userName]);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl,snapshotdata.data[EcommerceApp.userAvatarUrl]);
    List<String> cartList=snapshotdata.data[EcommerceApp.userCartList].cast<String>();
    await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, cartList);

    });

  }
}

