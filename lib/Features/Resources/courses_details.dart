import 'package:flutter/material.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: "Courses",
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/coursesdetails.png',
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                // Positioned(
                //   top: 16,
                //   left: 16,
                //   child: CircleAvatar(
                //     backgroundColor: Colors.white,
                //     child: Icon(Icons.arrow_back, color: Colors.black),
                //   ),
                // ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.share, color: Colors.black),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text("1hr 45mins | 12 Lessons",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                ),
                Positioned(
                  top: 170,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite_border, color: Colors.black),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Molecular Biology: Genomes, Genes & Beyond Scene",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "At the heart of life lies the language of molecules. Our Molecular Biology department is dedicated to exploring the structure, function.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Lessons",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  LessonTile(
                    title: 'DNA Replication & Repair',
                    duration: '25 min',
                    subLessons: [
                      SubLesson(
                          title: 'Mechanisms of DNA Replication',
                          duration: '13 min'),
                      SubLesson(
                          title: 'Mechanisms of DNA Replication',
                          duration: '12 min'),
                    ],
                  ),
                  SizedBox(height: 10),
                  LessonTile(
                    title: 'Recombinant Technology',
                    duration: '12 min',
                    subLessons: [],
                  ),
                  SizedBox(height: 10),
                  LessonTile(
                    title: 'Cell Signaling Pathways',
                    duration: '23 min',
                    subLessons: [],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LessonTile extends StatefulWidget {
  final String title;
  final String duration;
  final List<SubLesson> subLessons;

  const LessonTile({
    super.key,
    required this.title,
    required this.duration,
    required this.subLessons,
  });

  @override
  State<LessonTile> createState() => _LessonTileState();
}

class _LessonTileState extends State<LessonTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: EdgeInsets.only(left: 24, bottom: 10),
        onExpansionChanged: (val) => setState(() => isExpanded = val),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.play_circle_fill, color: Colors.blueAccent),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Text(widget.duration,
                style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
        children: widget.subLessons
            .map((e) => Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: Colors.grey),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(e.title,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87)),
                      ),
                      Text(e.duration,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.grey)),
                      SizedBox(width: 16),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class SubLesson {
  final String title;
  final String duration;

  const SubLesson({required this.title, required this.duration});
}
