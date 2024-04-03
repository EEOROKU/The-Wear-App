import 'package:closet_app/locator.dart';
import 'package:closet_app/screens/Auth/change_username.dart';
import 'package:closet_app/screens/Item_screens/add_item.dart';
import 'package:closet_app/view_controller/user_controller.dart';
import 'package:closet_app/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:closet_app/model/model.dart';
import 'package:closet_app/screens/screens.dart';
import 'package:closet_app/widgets/closet.dart';
import 'package:closet_app/widgets/outfit.dart';
import 'package:closet_app/screens/Auth/change_password.dart';

import 'Cloth details.dart';

class ClosetPage extends StatefulWidget {
  const ClosetPage({super.key});

  @override
  _ClosetPageState createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  UserModel? userModel;
  int _selectedIndex = 1;
  int _screenIndex =2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  void initState() {
    super.initState();
    // Fetch user data
    getUserData();
  }

  Future<void> getUserData() async {
    userModel = locator.get<UserController>().currentUser;
    setState(() {});
  }
  void _onItemTapped(int index) {
    setState(() {
      _screenIndex = index;
    });
  }
  Future<void> logout(BuildContext context) async {

    await locator.get<UserController>().signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LandingPage()));
  }
  bool _isAddPopupVisible = false;

  void _toggleAddPopupVisibility() {
    setState(() {
      _isAddPopupVisible = !_isAddPopupVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('WEAR'),
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Container (
          width: 100,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Toggle Dark Mode'),
                onTap: () {
                  // Handle dark mode toggle
                },
              ),
              ListTile(
                title: const Text('Change Password'),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Change Username'),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const ChangeUsernamePage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  logout(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          ),
          Row(
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
                    child: Text('All'),
                  ),
                ),
              ),
            ],),
          Row(
            children: [
              Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Details()),
                      );
                    },
                    child: Image.network(
                      'https://shorturl.at/gyEJ5',
                      height: 200/2,
                      width: 200/2,
                    ),
                  );
                },
              ),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: _isAddPopupVisible ? 60 : -100,
            right: 20,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isAddPopupVisible
                  ? Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddClothesPage()),
                        );
                        // Handle Add Clothes tap
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.woman),
                            SizedBox(width: 10),
                            Text('Add Clothes', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Divider(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle Create Idea tap
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.lightbulb),
                            SizedBox(width: 10),
                            Text('Create Outfit', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ),


        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Icon(Icons.home),
            ),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                _toggleAddPopupVisibility();
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  _isAddPopupVisible ? Icons.close : Icons.add,
                  key: ValueKey<bool>(_isAddPopupVisible),
                  color: Colors.black,
                ),
              ),
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                // Navigate to closet screen
              },
              child: const Icon(Icons.boy_sharp),
            ),
            label: 'Closet',
          ),
        ],
        currentIndex: _screenIndex,
        selectedItemColor: Colors.black,
        onTap: (index) {
          if (index == 1) {
            // Toggle the popup visibility
            _toggleAddPopupVisibility();
          } else {
            setState(() {
              _screenIndex = index;
            });
          }
        },
      ),
    );

  }}