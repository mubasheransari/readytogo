import 'package:flutter/material.dart';

import '../../Constants/constants.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Icon(Icons.menu, color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Courses",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildCategory("Pediatrics", true),
                _buildCategory("Surgery", false),
                _buildCategory("Drug", false),
                _buildCategory("Pathology", false),
                _buildCategory("Micro", false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                CourseCard(
                  image: 'assets/wellnesswire.png',
                  title: 'AI in Healthcare',
                  duration: '1hr 45mins',
                  lessons: '12 Lessons',
                  progress: 0.1,
                  isFavorite: true,
                ),
                CourseCard(
                  image: 'assets/wellnesswire.png',
                  title: 'Molecular Biology',
                  duration: '1hr 10mins',
                  lessons: '7 Lessons',
                  progress: 0.3,
                  isFavorite: false,
                ),
                CourseCard(
                  image: 'assets/wellnesswire.png',
                  title: 'Biology Basics',
                  duration: '2hr 25mins',
                  lessons: '8 Lessons',
                  progress: 0.4,
                  isFavorite: true,
                ),
                CourseCard(
                  image: 'assets/wellnesswire.png',
                  title: 'Surgery Basics',
                  duration: '1hr 05mins',
                  lessons: '5 Lessons',
                  progress: 0.2,
                  isFavorite: false,
                ),
                CourseCard(
                  image: 'assets/wellnesswire.png',
                  title: 'Electronic Health',
                  duration: '2hr 30mins',
                  lessons: '13 Lessons',
                  progress: 0.5,
                  isFavorite: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String image, title, duration, lessons;
  final double progress;
  final bool isFavorite;

  const CourseCard({
    super.key,
    required this.image,
    required this.title,
    required this.duration,
    required this.lessons,
    required this.progress,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.90,
      height: 120,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: 108,
                  height: 104,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'satoshi'),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Icon(
                        //   isFavorite ? Icons.favorite : Icons.favorite_border,
                        //   color: isFavorite ? Colors.red : Colors.grey,
                        // )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('$duration | $lessons',
                        style: TextStyle(
                            color: Colors.grey[800], fontFamily: 'satoshi')),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[200],
                      color: Constants().themeColor,
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  const Icon(Icons.open_in_new, color: Colors.grey),
                ],
              ),
              // Icon(
              //   isFavorite ? Icons.favorite : Icons.favorite_border,
              //   color: isFavorite ? Colors.red : Colors.grey,
              // ),
              // const Icon(Icons.open_in_new, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
