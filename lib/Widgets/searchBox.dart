import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Store/Search.dart';


class SearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent
      ) => InkWell(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(c)=>SearchProduct()));
          },

    child: Container(

      decoration: BoxDecoration(
          gradient:LinearGradient(
              colors:[Colors.teal,Colors.deepPurple],
              begin:Alignment.bottomRight,
              end: Alignment.center,
              stops:[0.0,1.0]
          )
      ),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: InkWell(
        child: Container(
          margin: EdgeInsets.only(left: 10.0,right: 10),
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),

          ),child:Row(children: [
            Padding(padding: EdgeInsets.only(left: 9),child: Icon(Icons.search_outlined,color: Colors.blueGrey,)),
          Padding(padding: EdgeInsets.only(left: 8),child:Text("Search here"))

        ],),
        ),
      ),
    ),
  );



  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}


