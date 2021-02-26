import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;


class UploadPage extends StatefulWidget
{
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage>
{
  TextEditingController description=TextEditingController();
  TextEditingController price=TextEditingController();
  TextEditingController title=TextEditingController();
  TextEditingController short=TextEditingController();
  String productId=DateTime.now().microsecondsSinceEpoch.toString();
  bool uploading=false;
  File image;
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return image!=null?uplodingScreen():display();
  }


  Widget display(){
    return Scaffold(
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
          ),leading: IconButton(icon: Icon(Icons.border_color,color: Colors.grey,),onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>AdminShiftOrders()));
        },),
          actions: [
            FlatButton.icon(onPressed:(){
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>SplashScreen()));
            }, icon:Icon(Icons.exit_to_app), label:Text("Log out",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),))
          ],
        ),body: getScreenAdmin(),

    );
  }

  getScreenAdmin() {
    return Container(
      width:MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient:LinearGradient(
              colors:[Colors.teal,Colors.deepPurple],
              begin:Alignment.bottomRight,
              end: Alignment.center,
              stops:[0.0,1.0]
          )
      ),child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shop_two,size: 200,color: Colors.white,),
        Container(
          padding: EdgeInsets.only(top: 20),
          child: RaisedButton(
            onPressed: (){
              takeIMage(context);
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
            child: Text("Add New Items",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
        )

    ],),
    );
  }

  Future<void> takeIMage(context) async{
    return showDialog(context:context,builder:(context){
      return SimpleDialog(
        title:Text('Item Image',style: TextStyle(color: Colors.green,fontWeight:FontWeight.bold),),
        children: [
          SimpleDialogOption(child: Text('Capture with camera',style: TextStyle(color: Colors.deepPurple),),
          onPressed: (){
            takeCamera();
          },
          ),SimpleDialogOption(child: Text('Select from gallery',style: TextStyle(color: Colors.deepPurple),),
            onPressed: (){
             pickPhoto();
            },
          ),
          SimpleDialogOption(child: Text('Cancel',style: TextStyle(color: Colors.deepPurple),),
            onPressed: (){
            Navigator.pop(context);
            },
          )

        ],
      );
    });
  }

  void takeCamera()async {
    Navigator.pop(context);
   File file= await ImagePicker.pickImage(source:ImageSource.camera,maxHeight:680,maxWidth: 970);
   setState(() {
     image=file;
   });

  }

  void pickPhoto()async {
    Navigator.pop(context);
    File file= await ImagePicker.pickImage(source:ImageSource.gallery);
    setState(() {
      image=file;
    });
  }

 Widget uplodingScreen() {
    return Scaffold(appBar:AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient:LinearGradient(
                colors:[Colors.teal,Colors.deepPurple],
                begin:Alignment.bottomRight,
                end: Alignment.center,
                stops:[0.0,1.0]
            )
        ),
      ),leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
        clearForm();
    },),
      title: Text("New Product",style: TextStyle(color: Colors.white),),centerTitle: true,
      actions: [
        FlatButton(onPressed:(){
          uploading?null:saveitems();
        }, child:Text('Add',style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 16),))
      ],
    ),
      body:Stack(children: [
        ListView(
          children: [

            Container(
              height: 230.0,
              width: MediaQuery.of(context).size.width*0.8,
              child: Center(
                child:AspectRatio(
                  aspectRatio: 16/9,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(image,),fit: BoxFit.cover
                        )
                    ),
                  ),
                )

                ,),),
            Padding(padding: EdgeInsets.only(top: 12)),
            ListTile(
              leading: Icon(Icons.perm_device_information,color:Colors.pink),
              title: Container(
                width: 250,
                child: TextField(
                  style: TextStyle(color: Colors.pink),
                  controller: short,
                  decoration: InputDecoration(
                      hintText: "Short Info",
                      hintStyle: TextStyle(
                          color: Colors.deepPurple
                      ),
                      border: InputBorder.none
                  ),
                ),
              ),
            ),Divider(height: 10,color: Colors.pink,),
            ListTile(
              leading: Icon(Icons.perm_device_information,color:Colors.pink),
              title: Container(
                width: 250,
                child: TextField(
                  style: TextStyle(color: Colors.pink),
                  controller: title,
                  decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                          color: Colors.deepPurple
                      ),
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
            Divider(height: 10,color: Colors.teal,),
            ListTile(
              leading: Icon(Icons.perm_device_information,color:Colors.pink),
              title: Container(
                width: 250,
                child: TextField(
                  style: TextStyle(color: Colors.pink),
                  controller: description,
                  decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: TextStyle(
                          color: Colors.deepPurple
                      ),
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
            Divider(height: 10,color: Colors.teal,),
            ListTile(
              leading: Icon(Icons.perm_device_information,color:Colors.pink),
              title: Container(
                width: 250,
                child: TextField(
                  keyboardType:TextInputType.number ,
                  style: TextStyle(color: Colors.pink),
                  controller: price,
                  decoration: InputDecoration(
                      hintText: "Price",
                      hintStyle: TextStyle(
                          color: Colors.deepPurple
                      ),
                      border: InputBorder.none
                  ),
                ),
              ),
            )
          ],
        ), uploading?circularProgress():Text(''),
      ],) ,
    );
 }

  void clearForm() {
    setState(() {
      description.clear();
      short.clear();
      price.clear();
      title.clear();

    });
  }

  saveitems() async{
    setState(() {
      uploading=true;
    });
  String imageurl=await  uploadImage(image);
      savinfo(imageurl);
  }

  Future<String> uploadImage(File image) async{
    final StorageReference storageReference =FirebaseStorage.instance.ref().child("items");
    StorageUploadTask uploadtask=storageReference.child("product_$productId.jpg").putFile(image);
    StorageTaskSnapshot taskSnapshot=await uploadtask.onComplete;
    String download=await taskSnapshot.ref.getDownloadURL();
    return download;
    // String title;
    // String shortInfo;
    // Timestamp publishedDate;
    // String thumbnailUrl;
    // String longDescription;
    // String status;
    // int price;

  }

  void savinfo(String imageurl) {

    final firestore=Firestore.instance.collection('items');
    firestore.document(productId).setData({
      "shortInfo":short.text.trim(),
      "title":title.text.trim(),
      "price":price.text.trim(),
      "longDescription":description.text.trim(),
      "publishedDate":DateTime.now(),
      "status":"available",
      "thumbnailUrl":imageurl,



    });

    setState(() {
      image=null;
      uploading=false;
      productId=DateTime.now().microsecondsSinceEpoch.toString();
      description.clear();
      short.clear();
      price.clear();
      title.clear();


    });

  }
}
