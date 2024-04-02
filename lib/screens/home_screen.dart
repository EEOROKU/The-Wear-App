import 'package:closet_app/locator.dart';
import 'package:closet_app/screens/Auth/change_username.dart';
import 'package:closet_app/screens/Item_screens/add_item.dart';
import 'package:closet_app/view_controller/user_controller.dart';
import 'package:closet_app/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:closet_app/model/model.dart';
import 'package:closet_app/screens/screens.dart';
import '../widgets/closet.dart';
import '../widgets/outfit.dart';
import 'Auth/change_password.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? userModel;
  int _selectedIndex = 1;
  int _screenIndex =0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          // Top Section
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Avatar(),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel!.userName!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_pin),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        // Handle location click action
                      },
                      child: const Text(
                        'Current Location',
                        style: TextStyle(
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        // Handle OOTD calendar click action
                      },
                      child: const Text(
                        'OOTD Calendar>',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Horizontal Scrollable Section
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                3,
                    (index) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 280,
                    height: 80,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                                children:[
                                  Row(
                                    children: [
                                      Text('Today'),
                                      SizedBox(width: 2),
                                      Card(
                                        color: Colors.pink,
                                        child: Text('Today'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text('3/-1 C'),
                                      SizedBox(width: 5),
                                      Icon(Icons.cloud_outlined),
                                    ],
                                  ),
                                ]),
                            Spacer(),
                            SizedBox(
                              width: 65,
                              height: 65,
                              child: Card(
                                child: Icon(Icons.edit_calendar),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Middle Section
          Expanded(
            child: Container(
              child: Column(
                children: [
                  // Middle Section Widgets
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Expanded(
                        child: InkWell(

                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: _selectedIndex == 1 ? Colors.black : Colors.transparent,
                                  width: 2.0, // Thickness of the bottom border
                                ),
                              ),
                            ),
                            child: Text(
                              'Outfit',
                              style: TextStyle(
                                fontSize: _selectedIndex == 1 ? 20 : 18,
                                fontWeight: _selectedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                                color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 0.5, thickness: 1), // Add a thick divider
                  IndexedStack(
                    index: _selectedIndex,
                    children: const [
                      ClosetScreen(),
                      OutfitScreen(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Bottom Navigation Bar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: _isAddPopupVisible ? 60 : -100,
            right: 20,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isAddPopupVisible
                  ? Container(
                margin: const EdgeInsets.only(bottom: 10),
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
                            Text('Create Idea', style: TextStyle(color: Colors.white)),
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
          BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
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
        ],
      ),
    );

  }}