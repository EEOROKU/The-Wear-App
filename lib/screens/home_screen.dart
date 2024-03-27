import 'package:closet_app/helper/helper_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:closet_app/model/model.dart';
import 'package:closet_app/screens/screens.dart';

import '../services/fire_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";
  String email = "";
  final AuthService authService = AuthService();

  User? user = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    super.initState();
    gettingUserData();
  }
  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePages(),
    );
  }
  

Future<void> logout(BuildContext context) async {

  authService.signOut();
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LandingPage()));
}
}

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePageState();
}

class _HomePageState extends State<HomePages> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    Column(children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  'https://as1.ftcdn.net/v2/jpg/03/39/45/96/1000_F_339459697_XAFacNQmwnvJRqe1Fe9VOptPWMUxlZP8.jpg'),
            ),
          ),
          Column(children: [
            Text(
              'Username',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text('See public profile'),
          ]),
        ],
      ),
      Row(
        children: [Icon(Icons.location_pin), Text('Charlottetown'), Text('                                         OOTD calendar>',style: TextStyle(color: Colors.blue),)],
      ),
      Row(
        children: [
          SizedBox(
              width: 350,  // Set the width as per your requirement
              height: 80, // Set the height as per your requirement
              child: Card(
                  color: Colors.grey,
                  child: Padding(
                      padding: EdgeInsets.all(8.5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                children: [
                                  Row(children: [Text("Wed Mar 20"),Card(color: Colors.pink,child:Text('Today', ))]),
                                  Row(children: [Text('3/-1 C    '), Icon(Icons.cloud_outlined)],)
                                ]
                            ),
                            SizedBox( width:60, height:60,child: Card(child:Icon(Icons.edit_calendar)),),
                          ]
                      )
                  )
              )
          )
        ],
      ),
      Row(  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              // Handle button press
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Closet'),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              // Handle button press
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Outfit'),
              ),
            ),
          ),
        ],),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox( height:190,width: 190,child: Row(children: [Column(children: [Image.network('https://shorturl.at/gyEJ5',height: 190/2,width: 190/2,),Image.network('https://shorturl.at/gyEJ5',height: 190/2,width: 190/2,)]),
            Column(children: [Image.network('https://shorturl.at/gyEJ5',height: 190/2,width: 190/2,),Image.network('https://shorturl.at/gyEJ5',height: 190/2,width: 190/2,)])],),),
          SizedBox(height:190,width: 190, child: Card(color: Colors.white,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.door_sliding_outlined, size: 90.0,),Text('Create a closet')],),),)
        ],
      ),
      Row(children: [Column(children: [Text('   All clothes'),Text('1')],),],),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: (){},
            child: Row(children: [Icon(Icons.archive_outlined,color: Colors.black,),Text('Archive', style: TextStyle(color: Colors.black),),],),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
          ),
        ],
      )

    ]),
    Text(
      'Add',
      style: optionStyle,
    ),

    Column(children: [
      Text('Closet',style: optionStyle,),
      Row(
        children: <Widget>[
          Icon(Icons.filter_list),
          SizedBox(width: 10),  // Optional: to give some spacing
          Expanded(  // Use Expanded to make sure TextField takes the remaining space
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      )

    ],
    ),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WEAR'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Show Snackbar',
            onPressed: () {
              // Should navigate to settings
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: PopupMenuButton<String>(
              color: Colors.grey[300],
              icon: Icon(Icons.border_all_outlined),
              itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Item1',
                  child: Text('Add Clothes'),
                ),
                const PopupMenuItem<String>(
                  value: 'Item2',
                  child: Text('Create Idea'),
                ),
                const PopupMenuItem<String>(
                  value: 'Item2',
                  child: Text('Schedule outfit'),
                ),
              ],
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.boy_sharp),
            label: 'Closet',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
