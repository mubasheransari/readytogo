import 'package:flutter/material.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';

class ReadingMaterialsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> blogs = [
    {
      "category": "Health & Wellness",
      "title": "Wellness Wire",
      "author": "John Dustin",
      "time": "30 mins",
      "image": "assets/wellnesswire.png",
      "liked": false,
    },
    {
      "category": "Medical Innovations",
      "title": "Medical Pulse",
      "author": "John Dustin",
      "time": "20 mins",
      "image": "assets/wellnesswire.png",
      "liked": true,
    },
  ];

  final List<Map<String, dynamic>> caseStudies = [
    {
      "category": "Neurology",
      "title": "Rehabilitation O...",
      "author": "John Dustin",
      "time": "20 mins",
      "image": "assets/wellnesswire.png",
      "liked": true,
    },
    {
      "category": "Public Health",
      "title": "Telemedicine Im...",
      "author": "John Dustin",
      "time": "25 mins",
      "image": "assets/wellnesswire.png",
      "liked": false,
    },
  ];

  final List<Map<String, dynamic>> researchPapers = [
    {
      "category": "Mental Health",
      "title": "The Psychologic...",
      "author": "John Dustin",
      "time": "25 mins",
      "image": "assets/wellnesswire.png",
      "liked": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: 'Reading Materials',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionHeader("Blogs"),
              ...blogs.map((item) => ContentCard(item)),

              // Section: Case Studies
              sectionHeader("Case Studies"),
              ...caseStudies.map((item) => ContentCard(item)),

              // Section: Research Papers
              sectionHeader("Research Papers"),
              ...researchPapers.map((item) => ContentCard(item)),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text("view all", style: TextStyle(color: Colors.blue, fontSize: 14)),
        ],
      ),
    );
  }
}

class ContentCard extends StatelessWidget {
  final Map<String, dynamic> data;

  ContentCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(data['image'],
                width: 80, height: 80, fit: BoxFit.cover),
          ),
          SizedBox(width: 12),

          // Text Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['category'],
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  SizedBox(height: 4),
                  Text(data['title'],
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(data['author'], style: TextStyle(fontSize: 12)),
                      SizedBox(width: 6),
                      Text("•", style: TextStyle(fontSize: 12)),
                      SizedBox(width: 6),
                      Text(data['time'], style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Icons
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(data['liked'] ? Icons.favorite : Icons.favorite_border,
                  color: data['liked'] ? Colors.red : Colors.grey),
              SizedBox(height: 10),
              Icon(Icons.open_in_new_rounded,
                  color: Color(0xFF4A60A1), size: 20),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
