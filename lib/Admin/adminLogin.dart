import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:flutter/material.dart';



class AdminSignInScreen extends StatefulWidget {
  static final String id='AdminSignInScreen';

  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen>
{
  bool loading =false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final adminIdControler=new TextEditingController();
  final password=new TextEditingController();
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
    ),
      ),
      body: ListView(children: [
      Center(child:
      Container(
        decoration: BoxDecoration(
            gradient:LinearGradient(
                colors:[Colors.teal,Colors.deepPurple],
                begin:Alignment.bottomRight,
                end: Alignment.center,
                stops:[0.0,1.0]
            )
        ),
        child:Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            loading?circularProgress():Text(''),
            SizedBox(height: 10,),
            Container(
              height: 200,
              width: 200,
              alignment: Alignment.bottomCenter,
              child: Image.asset('images/admin.png'),
            ), SizedBox(height: 18,),

            Form(
              key: _formKey,
              child: Column(children: [
                CustomTextField(
                  controller: adminIdControler,
                  hintText: 'Id',
                  isObsecure: false,
                  data:Icons.person,
                ),

                CustomTextField(
                  controller: password,
                  hintText: 'Password',
                  isObsecure: true,
                  data:Icons.lock,
                ),

                SizedBox(height: 10,),

               Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  height: 50,
                  decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(20)
                  ),
                  child: FlatButton(onPressed:(){

                  adminIdControler.text.isNotEmpty&&password.text.isNotEmpty?getin():showDialog(context:(context),builder: (context){
                  return ErrorAlertDialog(message: "PLease fill up all forms",);
                  });
                  },
                  child:Center(child: Text('Sign Up',
                  style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold),)))
                ),
                SizedBox(height: 30,),
                FlatButton.icon(onPressed:(){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder:(c)=>AuthenticScreen()));
                },icon: Icon(Icons.people_alt_outlined),color: Colors.teal,label:Text('I am n'),),

                SizedBox(height: 180,)

              ],),

            )



          ],) ,
      ),)
    ],),);
  }

  getin() {
    setState(() {
      loading=true;
    });
    Firestore.instance.collection("admin").getDocuments().then((value) =>{
      value.documents.forEach((element) {
        if(element.data['id']!=adminIdControler.text.trim()){
         _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text('your id is noy correct')));
        }else if(element.data['password']!=password.text.trim()){
          _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text('your id is noy correct')));
        }else{
          _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text('your id is  correct')));
          showDialog(context:context,builder:(c){
            return LoadingAlertDialog(message: 'LogIn Process.....',);
          } );
          setState(() {
            loading=false;
            adminIdControler.text='';
            password.text='';
          });

        Navigator.pushReplacement(context, MaterialPageRoute(builder:(c)=>UploadPage()));

        }

      })
    } );

  }
}
