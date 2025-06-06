import 'package:flutter/material.dart';

import '../widgets/boxDecorationWidget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  // Notification data model
  final List<NotificationItem> todayNotifications = const [
    NotificationItem(
      title: "Upcoming Appointment",
      description:
          "Don't forget your consultation with Dr. Ahmed at 10:30 AM tomorrow.",
      timeAgo: "2 mins ago",
      color: Color(0xFF4A90E2),
    ),
    NotificationItem(
      title: "Time to Take Your Medicine",
      description: "It's time to take your 5mg Blood Pressure tablet.",
      timeAgo: "2 mins ago",
      color: Color(0xFF4A90E2),
    ),
  ];

  final List<NotificationItem> thisWeekNotifications = const [
    NotificationItem(
      title: "You're All Set!",
      description:
          "Your appointment with Dr. Khan has been successfully booked for April 16 at 2:00 PM.",
      timeAgo: "2 days ago",
      color: Color(0xFF7ED6A8),
    ),
    NotificationItem(
      title: "Don't Miss Your Appointment!",
      description:
          "You have a consultation with Dr. Ahmed tomorrow at 9:00 AM.",
      timeAgo: "3 days ago",
      color: Color(0xFFE05656),
    ),
    NotificationItem(
      title: "Lab Report Downloaded",
      description:
          "You've successfully downloaded your latest blood test results.",
      timeAgo: "5 days ago",
      color: Color(0xFF7ED6A8),
    ),
  ];

  final List<NotificationItem> thisMonthNotifications = const [
    NotificationItem(
      title: "Schedule Your Visit",
      description: "It's time to book a follow-up for your recent check-up.",
      timeAgo: "21 days ago",
      color: Color(0xFF4A90E2),
    ),
    NotificationItem(
      title: "You're Doing Great!",
      description: "You've logged your meals for 7 days in a row—keep it up!",
      timeAgo: "25 days ago",
      color: Color(0xFF4A90E2),
    ),
    NotificationItem(
      title: "Lab Results Delayed",
      description:
          "There's a delay in your lab report. We'll notify you once it's available.",
      timeAgo: "28 days ago",
      color: Color(0xFFE05656),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFEFF2FF),
      body: DecoratedBox(
      decoration: boxDecoration(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xff323747),
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Satoshi',
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationScreen()));
                        },
                        child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white,
                            child: Image.asset("assets/settings.png")),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Today Section
                  const Text(
                    "Today",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E2022),
                      fontFamily: 'Satoshi',
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...todayNotifications
                      .map((notif) => NotificationCard(item: notif))
                      .toList(),

                  const SizedBox(height: 20),
                  // This Week Section
                  const Text(
                    "This Week",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E2022),
                      fontFamily: 'Satoshi',
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...thisWeekNotifications
                      .map((notif) => NotificationCard(item: notif))
                      .toList(),

                  const SizedBox(height: 20),
                  // This Month Section
                  const Text(
                    "This Month",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E2022),
                      fontFamily: 'Satoshi',
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...thisMonthNotifications
                      .map((notif) => NotificationCard(item: notif))
                      .toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Icon(
        icon,
        color: const Color(0xFF1E2022),
        size: 20,
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem item;

  const NotificationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Colored indicator bar
          Container(
            width: 6,
            height: 54,
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E2022),
                    fontFamily: 'Satoshi',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF5C5C5C),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Time ago
          Text(
            item.timeAgo,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: Color(0xFF8A8A8A),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String description;
  final String timeAgo;
  final Color color;

  const NotificationItem({
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.color,
  });
}
