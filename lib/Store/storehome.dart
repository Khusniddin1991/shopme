import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';

double width;

class StoreHome extends StatefulWidget {
  static final String id='StoreHome';
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient:LinearGradient(
                  colors:[Colors.teal,Colors.deepPurple],
                  begin:Alignment.bottomRight,
                  end: Alignment.center,
                  stops:[0.0,1.0]
              )
          ),
        ),title: Text('ShopMe',style: TextStyle(fontFamily:"Signatra",fontSize: 22,fontWeight: FontWeight.bold),),centerTitle: true,
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
          ],)],
        ),drawer: MyDrawer(),

        body:CustomScrollView(
          slivers: [
            SliverPersistentHeader(pinned: true,delegate: SearchBoxDelegate()),
            StreamBuilder<QuerySnapshot>(stream: Firestore.instance.collection("items").limit(15).orderBy("publishedDate",descending: true).snapshots()
                ,builder:(context,datasnapshot){
                 return !datasnapshot.hasData?SliverToBoxAdapter(child:Center(child: circularProgress(),) ,):SliverStaggeredGrid.countBuilder(crossAxisCount: 1,itemCount: datasnapshot.data.documents.length,
                     staggeredTileBuilder: (c)=>StaggeredTile.fit(1),
                     itemBuilder: (c,i){
                       ItemModel model =ItemModel.fromJson(datasnapshot.data.documents[i].data);
                       return sourceInfo(model,context);
                     }, );
                })
          ],
        )
      ),
    );
  }
}



Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (c)=>ProductPage(itemModel:model ,)));
    },
    splashColor: Colors.pink,
    child: Padding(padding: EdgeInsets.all(6.0),
      child: Container(
        height: 190,
        width: width,
        child: Row(children: [
          Image.network(model.thumbnailUrl,height: 160,width: 140,),
          SizedBox(width:4.0),
          Expanded(
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
           children: [
             SizedBox(height:15.0),
             Container(child: Row(
               mainAxisSize: MainAxisSize.max,children: [
                 Expanded(child: Text(model.title,style: TextStyle(color: Colors.black,fontSize: 14),))
             ],
             ),),
             SizedBox(height:5.0),
             Container(child: Row(
               mainAxisSize: MainAxisSize.max,children: [
               Expanded(child: Text(model.shortInfo.toString(),style: TextStyle(color: Colors.black54,fontSize: 12),))
             ],
             ),),
             SizedBox(height:20.0),
             Padding(
               padding:EdgeInsets.only(left: 10),
               child: Container(
                 child: Row(
                   children: [
                     Container(decoration: BoxDecoration(
                       shape: BoxShape.rectangle,
                       color: Colors.pink
                     ),
                     alignment: Alignment.topLeft,width: 40,height: 43,
                       child: Center(child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("50%",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),),
                           Text("OFF%",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),)

                       ],),),
                     ),SizedBox(width: 10,),
                     Column(crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(children: [
                         Text('Orignal Price €',style: TextStyle(fontSize: 15,color: Colors.grey,decoration: TextDecoration.lineThrough)),
                         Text((model.price+model.price).toString(),style: TextStyle(fontSize: 15,color: Colors.grey,decoration: TextDecoration.lineThrough  ))
                       ],),
                       Padding(padding: EdgeInsets.only(top: 5),
                         child: Row(children: [
                         Text('New Price',style: TextStyle(fontSize: 15,color: Colors.grey,)),
                           Text('€ ',style: TextStyle(fontSize: 16,color: Colors.red,)),
                         Text((model.price).toString(),style: TextStyle(fontSize: 15,color: Colors.grey,))
                       ],),)
                     ],)

                   ],

                 ),
               ),
             ),
             Flexible(child: Container()),
             Align(
               alignment: Alignment.centerRight,
                 child:removeCartFunction==null?IconButton(icon:Icon(Icons.shopping_cart,color: Colors.pink,),onPressed: (){
                   checkItemInCart(model.shortInfo, context)
                 },):IconButton(icon:Icon(Icons.delete,color: Colors.pink,) ,)
             )

           ],

            ),
          )
        ],),
      ),),
  );
}



Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}



void checkItemInCart(String shortInfo, BuildContext context)
{
  EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).contains()
  
}
