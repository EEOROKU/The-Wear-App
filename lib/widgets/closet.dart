import 'package:flutter/material.dart';

class ClosetScreen extends StatelessWidget {
  const ClosetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 190,
              width: 190,
              child: Row(
                children: [
                  Column(
                    children: [
                      Image.network('https://shorturl.at/gyEJ5', height: 190/2, width: 190/2,),
                      Image.network('https://shorturl.at/gyEJ5', height: 190/2, width: 190/2,),
                    ],
                  ),
                  Column(
                    children: [
                      Image.network('https://shorturl.at/gyEJ5', height: 190/2, width: 190/2,),
                      Image.network('https://shorturl.at/gyEJ5', height: 190/2, width: 190/2,),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 190,
              width: 190,
              child: Card(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.door_sliding_outlined,
                      size: 90.0,
                    ),
                    Text('Create a closet'),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Row(
          children: [
            Column(
              children: [
                Text('All clothes'),
                Text('1'),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.archive_outlined,
                    color: Colors.black,
                  ),
                  Text(
                    'Archive',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}