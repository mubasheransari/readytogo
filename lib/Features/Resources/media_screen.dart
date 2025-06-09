import 'package:flutter/material.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';

import 'media_details_screen.dart';

class MediaScreen extends StatelessWidget {
  final List<Map<String, String>> mediaItems = [
    {
      'title': 'Understanding Chronic Illnesses',
      'author': 'John Dustin',
      'duration': '35 mins',
      'image': 'assets/media.png',
    },
    {
      'title': 'The Immune System Explained',
      'author': 'John Dustin',
      'duration': '25 mins',
      'image': 'assets/media.png',
    },
    {
      'title': 'Healthy Eating for a Stronger Body',
      'author': 'John Dustin',
      'duration': '20 mins',
      'image': 'assets/media.png',
    },
    {
      'title': 'How AI is Changing Healthcare',
      'author': 'John Dustin',
      'duration': '35 mins',
      'image': 'assets/media.png',
    },
    {
      'title': 'Daily Habits for a Healthy Heart',
      'author': 'John Dustin',
      'duration': '12 mins',
      'image': 'assets/media.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScaffoldWidget(
          appbartitle: 'Media',
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'satoshi'),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: mediaItems.length,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    final item = mediaItems[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoDetailPage()));
                      },
                      child: Container(
                        // height: 104,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey.shade100,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                item['image']!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'satoshi'),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    item['author']!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'satoshi'),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    item['duration']!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'satoshi'),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Icon(Icons.favorite_border),
                                SizedBox(height: 20),
                                Image.asset("assets/playicon.png")
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
