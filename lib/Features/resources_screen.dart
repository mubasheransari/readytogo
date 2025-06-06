import 'package:flutter/material.dart';
import 'package:readytogo/Features/search_screen.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';

import '../widgets/boxDecorationWidget.dart';
import 'navdrawer.dart';
import 'notification_screen.dart';

class ResourcesScreen extends StatefulWidget {
  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {


  final List<_ResourceItem> items = [
    _ResourceItem('Reading Materials', 'assets/phone.png'),
    _ResourceItem('Courses', 'assets/Character.png'),
    _ResourceItem('Education', 'assets/education.png'),
    _ResourceItem('Youtube', 'assets/Comment.png'),
    _ResourceItem('Self Uploaded', 'assets/selfuploaded.png'),
  ];

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      isDrawerRequired: true,
      appbartitle: 'Rescources',
      body: DecoratedBox(
        decoration: boxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        // Open drawer here
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: Image.asset("assets/menu-02.png"),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Resources',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff323747),
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: Image.asset("assets/notification.png"),
                      ),
                    ),
                  ],
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 140,
                      width: 376,
                      child: _ResourceCard(item: items[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ResourcesScreen extends StatefulWidget {
//   @override
//   State<ResourcesScreen> createState() => _ResourcesScreenState();
// }

// class _ResourcesScreenState extends State<ResourcesScreen> {
//   final List<_ResourceItem> items = [
//     _ResourceItem('Reading Materials', 'assets/phone.png'),
//     _ResourceItem('Courses', 'assets/Character.png'),
//     _ResourceItem('Education', 'assets/education.png'),
//     _ResourceItem('Youtube', 'assets/Comment.png'),
//     _ResourceItem('Self Uploaded', 'assets/selfuploaded.png'),
//   ];
//   int selectedIndex = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: CustomNavDrawer(),
//       extendBody: true,
//       backgroundColor: Colors.transparent,
//       body: DecoratedBox(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFE6DCFD),
//               Color(0xFFD8E7FF),
//             ],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 80.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: CircleAvatar(
//                           radius: 22,
//                           backgroundColor: Colors.white,
//                           child: Image.asset("assets/menu-02.png")),
//                     ),
//                     SizedBox(
//                       width: 8,
//                     ),
//                     const Text(
//                       'Resources',
//                       style: TextStyle(
//                         fontSize: 24,
//                         color: Color(0xff323747),
//                         fontWeight: FontWeight.w900,
//                         fontFamily: 'Satoshi',
//                       ),
//                     ),
//                     SizedBox(
//                       width: 8,
//                     ),

//                     InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => NotificationScreen()));
//                       },
//                       child: CircleAvatar(
//                           radius: 22,
//                           backgroundColor: Colors.white,
//                           child: Image.asset("assets/notification.png")),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   padding: EdgeInsets.all(16),
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     return SizedBox(
//                         height: 140,
//                         width: 376,
//                         child: _ResourceCard(item: items[index]));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class _ResourceItem {
  final String title;
  final String imagePath;

  _ResourceItem(this.title, this.imagePath);
}

class _ResourceCard extends StatelessWidget {
  final _ResourceItem item;

  const _ResourceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Image.asset(item.imagePath, width: 90, height: 130),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 0),
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing.',
                      style: TextStyle(
                        color: Color(0XFF323747),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Image.asset("assets/arrow-up-right.png"))
          ],
        ),
      ),
    );
  }
}

class BottomNavBarExact extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBarExact({
    Key? key,
    this.currentIndex = 1,
    required this.onTap,
  }) : super(key: key);

  @override
  _BottomNavBarExactState createState() => _BottomNavBarExactState();
}

class _BottomNavBarExactState extends State<BottomNavBarExact> {
  final List<_NavItem> items = [
    _NavItem('My Geo', "assets/globe-04.png"),
    _NavItem('Resources', "assets/bookbottomNavbar1.png"),
    _NavItem('Search', "assets/search.png"),
    _NavItem('Profile', "assets/user.png"),
  ];

  // Function to navigate to the appropriate screen
  // void _navigateToScreen(int index) {
  //   // Example: Navigate based on index
  //   if (index == 2) {
  //     // Search screen
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const FindProvidersScreen()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isSelected = index == widget.currentIndex;
            final item = items[index];
            final color = isSelected ? Color(0xFF3B68FF) : Color(0xFF47474F);

            return GestureDetector(
              onTap: () {
                widget.onTap(index); // Update selected index
              //  _navigateToScreen(index); // Navigate to corresponding screen
              },
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon
                  Image.asset(
                    item.imageicon,
                    width: 27,
                    height: 27,
                    color: color, // Apply dynamic color based on selection
                  ),
                  SizedBox(height: 4),
                  // Text label
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: color,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                  SizedBox(height: 4),
                  // Active indicator (small circle)
                  if (isSelected)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Color(0xFF3B68FF),
                        shape: BoxShape.circle,
                      ),
                    )
                  else
                    SizedBox(height: 6),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String imageicon;

  _NavItem(this.label, this.imageicon);
}

class RoundedCornerCurve extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const RoundedCornerCurve({
    this.size = 40,
    this.color = Colors.grey,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _RoundedCornerPainter(color, strokeWidth),
    );
  }
}

class _RoundedCornerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _RoundedCornerPainter(this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Draw a quarter circle arc (rounded corner)
    final radius = size.width / 2;
    path.arcTo(
      Rect.fromLTWH(0, 0, size.width, size.height),
      3 * 3.1415926535897932 / 2, // Start at 270 degrees
      3.1415926535897932 / 2, // Sweep 90 degrees
      false,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RoundedCornerPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
