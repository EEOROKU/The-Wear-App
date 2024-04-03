import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class _DetailsState extends State<Details> {
  int _selectedIndex = 0;

  final _pageOptions = [
    SingleChildScrollView( child:
    Column(children: [
      Text('Occasion info', textAlign: TextAlign.left,style: TextStyle(fontSize: 20),),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Text('Season'),Row(children: [Text('Spring, ',style: TextStyle(color: Colors.blue),),Text('Summer, ',style: TextStyle(color: Colors.blue),),Text('Fall, ',style: TextStyle(color: Colors.blue),),Text('Winter',style: TextStyle(color: Colors.blue),)],)],),
      Row(children: [Card(child: Text('Spring')),Card(child: Text('Summer'),),Card(child: Text('Fall'),),Card(child: Text('Winter'),) ]),
      Container( height: 100,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.grey),
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Text('Occasions'),Row(children: [Text('Choose the occasion ^',style: TextStyle(color: Colors.grey),),],)],),
            Row(children: [Card(child: Text('Daily')),Card(child: Text('Work'),),Card(child: Text('Date'),),Card(child: Text('Formal'),),Card(child: Text('Travel'),),Card(child: Text('Home'),),Card(child: Text('Party'),),Card(child: Text('Sport'),), ]),
            Row( children: [ Card(child: Text('Special'),),Card(child: Text('School'),),Card(child: Text('ETC'),) ])
          ],)
      ),
      Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),),
        child: Column(children: [
          Text('Item info'),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Text('Category'),Row(children: [Text('Choose the Category ^',style: TextStyle(color: Colors.grey),),],)],),
          Row( children: [ Card(child: Text('Tops'),),Card(child: Text('T-shirts'),),Card(child: Text('Long Sleeve T-shirts'),),Card(child: Text('Sleeveless T-shirts'),),]),
          Row( children: [ Card(child: Text('Polo Shirts'),),Card(child: Text('Tanks & Camis'),),Card(child: Text('Crop Tops'),),Card(child: Text('Blouses'),),Card(child: Text('Shirts'),)]),
          Row( children: [ Card(child: Text('Sweatshirts'),),Card(child: Text('Hoodies'),),Card(child: Text('Sweaters'),),Card(child: Text('Sweater Vests'),)]),
          Row( children: [ Card(child: Text('Sports Tops'),),Card(child: Text('Bodysuits'),),Card(child: Text('ETC'),),Card(child: Text('Cardigan Tops'),)]),
          Row(children: [Text('Category guide', style: TextStyle(color: Colors.cyan,decoration: TextDecoration.underline,decorationColor: Colors.blue,),)],),
        ],        ),      ),
      Container(
        child: Column(children: [
          Row(children: [Text('Color'), Text('^')],)
        ],
        ),
      )
    ]),),
    Text('Welcome to Page 2!'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clothes Details'),
      ),
      body: Column(
        children: [
          Container(
            height: 500, // Set the height you want here
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://shorturl.at/gyEJ5'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 205,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Text('Information'),
                ),
              ),
              Container(
                width: 205,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Text('Outfit'),
                ),
              ),
            ],),

          Expanded(
            child: Center(
              child: _pageOptions[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}
