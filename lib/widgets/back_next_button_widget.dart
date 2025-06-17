import 'package:flutter/material.dart';

class BackAndNextButton extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  const BackAndNextButton({
    Key? key,
    required this.onBackPressed,
    required this.onNextPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 156,
          height: 50,
          child: ElevatedButton(
            onPressed: onBackPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: const Size(100, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back, color: Color(0xff666F80), size: 24),
                SizedBox(width: 10),
                Text(
                  'Back',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xff666F80),
                    fontFamily: 'Satoshi',
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 156,
          height: 50,
          child: ElevatedButton(
            onPressed: onNextPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4C6FEE),
              minimumSize: const Size(100, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Next',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Satoshi',
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward, color: Colors.white, size: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
