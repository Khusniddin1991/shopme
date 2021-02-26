import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}



class _RegisterState extends State<Register> {
  final _email=new TextEditingController();
  final _name=new TextEditingController();
  final _password=new TextEditingController();
  final _confirmPassword=new TextEditingController();
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  String userImageFile='';
  File userImage;



  @override
  Widget build(BuildContext context) {
    double screnSize=MediaQuery.of(context).size.height;
    double screnWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body:ListView(children: [
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
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  _imagePicker();
                },
                child: CircleAvatar(
                    radius: screnSize*0.08,
                    backgroundColor:Colors.white ,
                    backgroundImage: userImage==null?null:FileImage(userImage),
                    child: userImage==null?Icon(Icons.add_photo_alternate,size:screnSize*0.15 ,color: Colors.grey,):null),
              ),
              SizedBox(height: 10,),
              Form(
                key: _formKey,
                child: Column(children: [
                  CustomTextField(
                    controller: _name,
                    hintText: 'Name',
                    isObsecure: false,
                    data:Icons.person,
                  ),
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
                  CustomTextField(
                    controller: _confirmPassword,
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
                        uploadImage();
                      },
                          child:Center(child: Text('Sign Up',
                            style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold),)))),
                  SizedBox(height: 10,),

                  SizedBox(height: 70,)

                ],),

              )



            ],) ,
        ),)
      ],),


    );
  }
 Future<void> _imagePicker()async{

   userImage  = await ImagePicker.pickImage(source: ImageSource.gallery);
  }
  Future<void> uploadImage(){
    if(userImage==null){
      showDialog(context:context,
        builder: (ctx){
        return ErrorAlertDialog(message: 'Please select image file',);
        }
      );
    }else{
      _password.text==_confirmPassword.text?_email.text.isNotEmpty&&_confirmPassword.text.isNotEmpty&&
          _password.text.isNotEmpty&& _name.text.isNotEmpty? uploadStorage():displayDialog(msg: 'fill up all of form'):passwordDialog(msg: 'correct password');
    }

  }
  displayDialog({String msg}){
    showDialog(context:context,builder: (ctx){
      return ErrorAlertDialog(message: msg);
    });
    
  }
  passwordDialog({String msg}){
   showDialog(context:context,builder: (ctx){
      return ErrorAlertDialog(message: msg,);
    });

  }
  Future<void> uploadStorage()async{
    showDialog(context:context,builder: (ctx){
      return LoadingAlertDialog(message: 'please wait.....');

    }


    );
    String userImageName=DateTime.now().microsecondsSinceEpoch.toString();

    StorageReference storageReference=FirebaseStorage.instance.ref().child(userImageName);
    StorageUploadTask storageUploadTask=storageReference.putFile(userImage);
    StorageTaskSnapshot takeSnapshot=await storageUploadTask.onComplete;

    await takeSnapshot.ref.getDownloadURL().then((firebaseImageUrl) => {
      userImageFile=firebaseImageUrl,
      _signUp()

    });

  }
   FirebaseAuth _auth =FirebaseAuth.instance;
  FirebaseUser firebaseuser;
  _signUp()async{

   await _auth.createUserWithEmailAndPassword(email:_email.text.trim().toString(), password: _password.text.trim().toString()).then((fire) =>{
     firebaseuser=fire.user
   }).catchError((eror){
     Navigator.pop(context);
     showDialog(context:context,builder: (ctx){
       return ErrorAlertDialog(message:eror.toString());
     });
   });

   if(firebaseuser!=null){
     saveUser(firebaseuser).then((value) => {
       Navigator.pop(context),
       Navigator.pushNamed(context, StoreHome.id)
     });
   }


  }

 Future  saveUser(FirebaseUser fire)async{
    Firestore.instance.collection("user").document(fire.uid).setData({
      "userid":fire.uid,
      "email":fire.email,
      "name":_name.text.trim(),
      "url":userImageFile,
      EcommerceApp.userCartList :["garbageList"]

    });
    
   await EcommerceApp.sharedPreferences.setString(EcommerceApp.userUID, fire.uid);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail, fire.email);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName, _name.text.trim());
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl, userImageFile);
    await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList,  ["garbageList"]);

 }

} 

