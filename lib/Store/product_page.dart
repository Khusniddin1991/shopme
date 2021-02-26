import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Store/storehome.dart';


class ProductPage extends StatefulWidget {
  final ItemModel itemModel;

  ProductPage({this.itemModel});

  @override
  _ProductPageState createState() => _ProductPageState();
}



class _ProductPageState extends State<ProductPage> {
  int itemofQuantity=1;


  @override
  Widget build(BuildContext context)
  {
    Size screenSize=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar:MyAppBar() ,
        drawer: MyDrawer(),
    body: ListView(
    children: [
      Container(
    padding: EdgeInsets.all(8.0),
    width: MediaQuery.of(context).size.width,
    color: Colors.white,
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
        Stack(children: [
          Center(child:Image.network(widget.itemModel.thumbnailUrl),),
          Container(
            color: Colors.grey[400],
            child: SizedBox(height: 1,),
            width: double.infinity,
          )
        ],),
    Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.itemModel.title.toString(),
              style: boldTextStyle,
            ),
            SizedBox(height: 10,),
            Text(widget.itemModel.longDescription.toString(),),
            SizedBox(height: 10,),
            Text('€'+ widget.itemModel.price.toString(),
              style: boldTextStyle,),
            SizedBox(height: 10,),
          ]),
      ),
    ),
    Container(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: InkWell(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(
                gradient:LinearGradient(
                    colors:[Colors.teal,Colors.deepPurple],
                    begin:Alignment.bottomRight,
                    end: Alignment.center,
                    stops:[0.0,1.0]
                )
            ),
            width: MediaQuery.of(context).size.width-40,
            height: 50,
            child: Center(
              child: Text(
                "Add to cart",style: TextStyle(),
              ),
            ),
          ),
        ),
      ),

    )

  ],
  ),
  )
    ],
    ),
    ));
  }

}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
