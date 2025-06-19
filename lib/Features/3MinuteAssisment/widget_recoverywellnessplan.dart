import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';

class BackHeader extends StatelessWidget {
  final void Function(BuildContext context) onTap;
  final String title;
  final int questionNumber;
  final int totalQuestions;


  const BackHeader({
    Key? key,
    required this.onTap,
    this.title = 'Recovery Wellness Plan',
    this.questionNumber = 1,
    this.totalQuestions = 13,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 10),
            InkWell(
              onTap: () => onTap(context),
              child: const CircleAvatar(
                radius: 19,
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back, color: Colors.black, size: 19),
              ),
            ),
            const SizedBox(width: 17),
            Text(
              title,
              style: const TextStyle(
                fontSize: 21,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontFamily: 'Satoshi',
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question $questionNumber/$totalQuestions',
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              LinearProgressIndicator(
                backgroundColor: Colors.white,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
                value: questionNumber / totalQuestions,
                valueColor: AlwaysStoppedAnimation(Constants().themeColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
