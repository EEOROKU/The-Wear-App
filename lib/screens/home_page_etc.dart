import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://as1.ftcdn.net/v2/jpg/03/39/45/96/1000_F_339459697_XAFacNQmwnvJRqe1Fe9VOptPWMUxlZP8.jpg'),
          ),
        ),
        Text(
          'Username',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Text('Bio'),
      ],
    ),
    Text(
      'Add',
      style: optionStyle,
    ),
    Text(
      'Closet',
      style: optionStyle,
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
            icon: Icon(Icons.account_circle),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: PopupMenuButton<String>(
              color: Colors.indigo[300],
              icon: Icon(Icons.border_all_outlined),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
