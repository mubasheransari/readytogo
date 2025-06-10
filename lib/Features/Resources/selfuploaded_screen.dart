import 'package:flutter/material.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';

class SelfUploadScreen extends StatelessWidget {
  const SelfUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: "Self Uploaded",
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 102,
              width: MediaQuery.of(context).size.width * 0.90,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF3366FF), Color(0xFF6A8DFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dr. John C.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'satoshi',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'JohnCarlos54@gmail.com',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'satoshi',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Upcoming Seminars
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Upcoming Seminars',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('view all', style: TextStyle(color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 12),
            SeminarCard(title: 'General Health & Wellness'),
            const SizedBox(height: 12),
            SeminarCard(title: 'Women’s Wellness Summit'),
            const SizedBox(height: 24),

            // Videos Uploaded
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Videos Uploaded',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('view all', style: TextStyle(color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 12),
            VideoCard(
              title: 'The Immune System Explained',
              image: 'assets/media.png',
              duration: '25 mins',
            ),
            const SizedBox(height: 12),
            VideoCard(
              title: 'Healthy Eating for a Stronger Body',
              image: 'assets/media.png',
              duration: '20 mins',
            ),
          ],
        ),
      ),
    );
  }
}

class SeminarCard extends StatelessWidget {
  final String title;
  const SeminarCard({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // InkWell(
              //   onTap: () {},
              //   child: Container(
              //       width: 42,
              //       height: 42,
              //       decoration: BoxDecoration(
              //           color: Colors.blue[100],
              //           borderRadius: BorderRadius.circular(10)),
              // child: Image.asset(
              //   "assets/graduation-hat-02.png",
              //   height: 15,
              //   width: 15,
              // )),
              // ),
              Image.asset(
                "assets/graduation-hat-02.png",
                height: 28,
                width: 28,
              ),

              //  Icon(Icons.school, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'General Health & Wellness',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Lorem Ipsum is simply dummy text for design'),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.timer, size: 16),
              SizedBox(width: 4),
              Text('15 - 120 mins'),
              SizedBox(width: 16),
              Icon(Icons.calendar_today, size: 16),
              SizedBox(width: 4),
              Text('15 - 120 mins'),
              Spacer(),
              Text('copy link', style: TextStyle(color: Colors.blue)),
            ],
          )
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String title;
  final String image;
  final String duration;

  const VideoCard({
    required this.title,
    required this.image,
    required this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(image, height: 60, width: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('John Dustin'),
                Text(duration),
              ],
            ),
          ),
          // Text(duration),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Text(duration),

              // const SizedBox(height: 4),
              const Icon(Icons.favorite_border, size: 19),
              //  const SizedBox(height: 4),
              const Icon(
                Icons.open_in_new,
                size: 19,
              ),
            ],
          ),
          // const SizedBox(width: 8),
          // const Icon(Icons.favorite_border),
        ],
      ),
    );
  }
}
