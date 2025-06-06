import 'package:flutter/material.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';

import '../widgets/boxDecorationWidget.dart';
import 'notification_screen.dart';

class MyGeoScreen extends StatelessWidget {
  const MyGeoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Colors based on image
    final Color primaryBlue = Color(0xFF5D6EFF);
    final Color backgroundColor = Color(0xFFF6F7FF);
    final Color lightBlue = Color(0xFF8A97FF);

    return CustomScaffoldWidget(
      appbartitle: "My GEO",
      isDrawerRequired: true,
      body: DecoratedBox(
        decoration: boxDecoration(),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            Container(
              height: screenWidth *
                  0.5, // responsive height (around 200 on 400px wide screen)
              width: screenWidth * 0.9, // 90% of screen width
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff668CFF), Color(0xff3964E5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff3964E5).withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  )
                ],
              ),
              padding: EdgeInsets.all(
                  screenWidth * 0.05), // ~20 padding on 400px width
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: screenWidth * 0.11, // ~44 on 400px width
                        child: Image.asset("assets/prodilepic.png"),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. John C.',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: screenWidth * 0.06, // ~24
                                fontFamily: 'Satoshi',
                              ),
                            ),
                            Text(
                              '(Pediatrician)',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.04, // ~16
                                fontFamily: 'Satoshi',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: screenWidth * 0.1,
                        width: screenWidth * 0.1,
                        decoration: BoxDecoration(
                          color: Color(0xffDBE4FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/editt.png",
                            height: screenWidth * 0.06,
                            width: screenWidth * 0.06,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.03),
                  Container(
                    height: screenWidth * 0.1,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      value: '    Professional',
                      isExpanded: true,
                      underline: SizedBox(),
                      dropdownColor: Colors.white,
                      icon: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Image.asset(
                          "assets/chevron-down.png",
                          height: screenWidth * 0.06,
                          width: screenWidth * 0.06,
                          color: Colors.white,
                        ),
                      ),
                      items: <String>[
                        '    Professional',
                        'Personal',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.042,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 197,
            //   width: 226,
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Color(0xff668CFF), Color(0xff3964E5)],
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //     ),
            //     borderRadius: BorderRadius.circular(24),
            //     boxShadow: [
            //       BoxShadow(
            //         color: primaryBlue.withOpacity(0.3),
            //         blurRadius: 12,
            //         offset: Offset(0, 6),
            //       )
            //     ],
            //   ),
            //   padding: EdgeInsets.all(20),
            //   child: Column(
            //     children: [
            //       Row(
            //         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         // crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(top: 10.0, left: 10),
            //             child: CircleAvatar(
            //               radius: 47,
            //               child: Image.asset("assets/prodilepic.png"),
            //             ),
            //           ),
            //           SizedBox(width: 20),
            //           Column(
            //             children: [
            //               Text(
            //                 'Dr. John C.',
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.w900,
            //                   fontSize: 24,
            //                   fontFamily: 'Satoshi',
            //                 ),
            //               ),
            //               //  SizedBox(height: 2),
            //               Text(
            //                 '(Pediatrician)',
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.w600,
            //                   fontSize: 16,
            //                   fontFamily: 'Satoshi',
            //                 ),
            //               ),
            //             ],
            //           ),
            //           /* Expanded(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   'Dr. John C.',
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.w700,
            //                     fontSize: 18,
            //                   ),
            //                 ),
            //                 SizedBox(height: 4),
            //                 Text(
            //                   '(Pediatrician)',
            //                   style: TextStyle(
            //                     color: Colors.white70,
            //                     fontWeight: FontWeight.w500,
            //                     fontSize: 14,
            //                   ),
            //                 ),
            //                 SizedBox(height: 12),
            //                 // Container(
            //                 //   padding:
            //                 //       EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //                 //   decoration: BoxDecoration(
            //                 //     color: Colors.white.withOpacity(0.3),
            //                 //     borderRadius: BorderRadius.circular(12),
            //                 //   ),
            //                 //   child: DropdownButton<String>(
            //                 //     value: 'Professional',
            //                 //     underline: SizedBox(),
            //                 //     dropdownColor: Colors.white,
            //                 //     icon: Icon(Icons.keyboard_arrow_down,
            //                 //         color: Colors.white),
            //                 //     items: <String>[
            //                 //       'Professional',
            //                 //       'Personal',
            //                 //     ].map((String value) {
            //                 //       return DropdownMenuItem<String>(
            //                 //         value: value,
            //                 //         child: Text(
            //                 //           value,
            //                 //           style: TextStyle(
            //                 //             color: Colors.black87,
            //                 //             fontWeight: FontWeight.w600,
            //                 //           ),
            //                 //         ),
            //                 //       );
            //                 //     }).toList(),
            //                 //     onChanged: (value) {},
            //                 //   ),
            //                 // ),
            //               ],
            //             ),
            //           ),*/

            //           // Edit icon button
            //           SizedBox(
            //             width: 59,
            //           ),
            //           Container(
            //             height: 40,
            //             width: 40,
            //             decoration: BoxDecoration(
            //                 color: Color(0xffDBE4FF),
            //                 borderRadius: BorderRadius.circular(12)),
            //             child: IconButton(
            //                 onPressed: () {},
            //                 icon: Image.asset(
            //                   "assets/editt.png",
            //                   height: 24,
            //                   width: 24,
            //                   color: Colors.black,
            //                 )),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 12,
            //       ),
            //       Container(
            //         height: 40,
            //         width: 400,
            //         //  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
            //         decoration: BoxDecoration(
            //           color: Colors.white.withOpacity(0.3),
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: DropdownButton<String>(
            //           value: '    Professional',
            //           underline: SizedBox(),
            //           dropdownColor: Colors.white,
            //           icon: Padding(
            //               padding: const EdgeInsets.only(left: 200.0),
            //               child: Image.asset(
            //                 "assets/chevron-down.png",
            //                 height: 24,
            //                 width: 24,
            //                 color: Colors.white,
            //               )),
            //           items: <String>[
            //             '    Professional',
            //             'Personal',
            //           ].map((String value) {
            //             return DropdownMenuItem<String>(
            //               value: value,
            //               child: Text(
            //                 value,
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 17,
            //                   fontWeight: FontWeight.w600,
            //                   fontFamily: 'Satoshi',
            //                 ),
            //               ),
            //             );
            //           }).toList(),
            //           onChanged: (value) {},
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            SizedBox(height: 24),

            // Search bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
              ),
            ),

            SizedBox(height: 28),

            // Favorites Section
            Text(
              'Favorites',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.black87,
                fontFamily: 'Satoshi',
              ),
            ),
            SizedBox(height: 16),

            // Favorite Card 1
            _favoriteCard(
              title: 'Biology Basics',
              duration: '2hr 25mins',
              lessons: '8 Lessons',
              progressPercent: 0.75,
              imageUrl:
                  'https://images.unsplash.com/photo-1531058020387-3be344556be6?auto=format&fit=crop&w=400&q=80',
            ),

            SizedBox(height: 16),

            // Favorite Card 2
            _favoriteCard(
              title: 'The Psychological...',
              duration: '10 mins',
              lessons: '',
              subtitle: 'Mental Health',
              progressPercent: 0.0,
              imageUrl:
                  'https://images.unsplash.com/photo-1531058020387-3be344556be6?auto=format&fit=crop&w=400&q=80',
            ),

            SizedBox(height: 28),

            // Groups/Association Section
            Text(
              'Groups/Association',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black87,
                fontFamily: 'Satoshi',
              ),
            ),
            SizedBox(height: 16),

            _groupCard(
              context: context,
              title: 'National Association of General Practitioners',
              memberCount: 22,
            ),
            SizedBox(height: 12),
            _groupCard(
              context: context,
              title: 'Diabetes Management Support Group',
              memberCount: 22,
            ),

            SizedBox(height: 28),

            // Group Contacts Section
            Text(
              'Group Contacts',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.black87,
                fontFamily: 'Satoshi',
              ),
            ),
            SizedBox(height: 16),

            _contactCard(
              name: 'Dr. Imran',
              specialization: 'Pediatrician',
              phone: '+0594 56249 5894',
              imageUrl: 'https://randomuser.me/api/portraits/men/52.jpg',
            ),
            SizedBox(height: 12),
            _contactCard(
              name: 'Dr. Faizan',
              specialization: 'Nutritionist',
              phone: '+0594 56249 5894',
              imageUrl: 'https://randomuser.me/api/portraits/men/31.jpg',
            ),
            SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _favoriteCard({
    required String title,
    String? subtitle,
    required String duration,
    String? lessons,
    required double progressPercent,
    required String imageUrl,
  }) {
    return Container(
      height: 124,
      width: 376,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 6,
              offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              height: 104,
              width: 108,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.black87,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    lessons?.isNotEmpty == true
                        ? '$duration | $lessons'
                        : duration,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progressPercent,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
          Icon(
            Icons.favorite,
            color: Colors.redAccent,
          ),
          SizedBox(width: 12),
          Icon(
            Icons.open_in_new,
            color: Colors.grey.shade400,
            size: 24,
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _groupCard({
    required BuildContext context,
    required String title,
    required int memberCount,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenWidth * 0.35, // ~137 on 390px width
      width: screenWidth * 0.92, // ~376 on 410px width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, // ~20
        vertical: screenWidth * 0.045, // ~18
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: screenWidth * 0.12, // ~48
                width: screenWidth * 0.12,
                decoration: BoxDecoration(
                  color: Color(0xffDBE4FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Image.asset(
                    "assets/users-02.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.04), // ~16
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth * 0.05, // ~20
                    color: Colors.black87,
                    fontFamily: 'Satoshi',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.01),
          Row(
            children: [
              Image.asset(
                "assets/framegroup.png",
                height: screenWidth * 0.1, // ~40
                width: screenWidth * 0.15, // ~60
                fit: BoxFit.contain,
              ),
              SizedBox(width: screenWidth * 0.02), // ~8
              Text(
                '$memberCount other doctors',
                style: TextStyle(
                  fontSize: screenWidth * 0.03, // ~12
                  color: Colors.grey.shade600,
                ),
              ),
              Spacer(),
              Icon(
                Icons.open_in_new,
                color: Colors.grey.shade400,
                size: screenWidth * 0.05, // ~20
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _groupCard({required String title, required int memberCount}) {
  //   return Container(
  //     height: 137,
  //     width: 376,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //       boxShadow: [
  //         BoxShadow(
  //             color: Colors.black12.withOpacity(0.05),
  //             blurRadius: 6,
  //             offset: Offset(0, 3)),
  //       ],
  //     ),
  //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               height: 48,
  //               width: 48,
  //               decoration: BoxDecoration(
  //                 color: Color(0xffDBE4FF),
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //               child: Image.asset(
  //                 "assets/users-02.png",
  //                 height: 26,
  //                 width: 26,
  //               ),
  //             ),
  //             // CircleAvatar(
  //             //   backgroundColor: Colors.blue.shade100,
  //             //   child: Icon(
  //             //     Icons.people_alt_outlined,
  //             //     color: Colors.blue.shade700,
  //             //   ),
  //             // ),
  //             SizedBox(width: 16),
  //             Expanded(
  //               child: Text(
  //                 title,
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w700,
  //                   fontSize: 20,
  //                   color: Colors.black87,
  //                   fontFamily: 'Satoshi',
  //                 ),
  //               ),
  //             ),
  //             // CircleAvatar(
  //             //   radius: 16,
  //             //   backgroundImage: NetworkImage(
  //             //       'https://randomuser.me/api/portraits/men/44.jpg'), // sample
  //             //   // You can create a row of avatars here if needed
  //             // ),
  //             // SizedBox(width: 8),
  //             // Text(
  //             //   '$memberCount other doctors',
  //             //   style: TextStyle(
  //             //     fontSize: 12,
  //             //     color: Colors.grey.shade600,
  //             //   ),
  //             // ),
  //             // SizedBox(width: 12),
  //             // Icon(
  //             //   Icons.open_in_new,
  //             //   color: Colors.grey.shade400,
  //             // ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 2,
  //         ),
  //         Row(
  //           children: [
  //             Image.asset(
  //               "assets/framegroup.png",
  //               height: 40,
  //               width: 60,
  //             ),
  //             // CircleAvatar(
  //             //   radius: 16,
  //             //  child: ,
  //             //   // You can create a row of avatars here if needed
  //             // ),
  //             SizedBox(width: 8),
  //             Text(
  //               '$memberCount other doctors',
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 color: Colors.grey.shade600,
  //               ),
  //             ),
  //             SizedBox(width: 150),
  //             Icon(
  //               Icons.open_in_new,
  //               color: Colors.grey.shade400,
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _contactCard({
    required String name,
    required String specialization,
    required String phone,
    required String imageUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 6,
              offset: Offset(0, 3)),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(imageUrl),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name ($specialization)',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  phone,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.phone,
            color: Colors.blueAccent,
            size: 28,
          ),
        ],
      ),
    );
  }
}
