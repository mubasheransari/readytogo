import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String textWidgetText;
  final String hintText;
  final String labelText;
  final Color borderColor;
  final Color hintTextColor;

  const CustomTextFieldWidget({
    Key? key,
    required this.controller,
    required this.textWidgetText,
    required this.hintText,
    required this.labelText,
    required this.borderColor,
    required this.hintTextColor,
  }) : super(key: key);

  OutlineInputBorder _buildBorder(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            textWidgetText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Satoshi',
              color: Color(0xff323747),
            ),
          ),
        ),
        const SizedBox(height: 7),
        SizedBox(
          width: 376,
          height: 60,
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: 'Satoshi',
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: hintTextColor,
                fontSize: 20,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: Colors.white,
              border: _buildBorder(borderColor, 1.5),
              enabledBorder: _buildBorder(borderColor, 1.5),
              focusedBorder: _buildBorder(borderColor, 2.0),
            ),
          ),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';

// class CustomTextFieldWidget extends StatelessWidget {
//   final TextEditingController controller;
//   final String textWidgetText;
//   final String hintText;
//   final String labelText;
//   final Color borderColor;
//   final Color hintTextColor;

//   const CustomTextFieldWidget({
//     Key? key,
//     required this.controller,
//     required this.textWidgetText,
//     required this.hintText,
//     required this.labelText,
//     required this.borderColor,
//     required this.hintTextColor
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 8.0),
//           child: Text(
//             textWidgetText,
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               fontFamily: 'Satoshi',
//               color: Color(0xff323747),
//             ),
//           ),
//         ),
//         const SizedBox(height: 7),
//         SizedBox(
//           width: 376,
//           height: 60,
//           child: TextField(
//             controller: controller,
//             style: TextStyle(
//               fontSize: 20,
//               color: borderColor,
//               fontFamily: 'Satoshi',
//             ),
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: TextStyle(
//                 color: hintTextColor,
//                 fontSize: 20,
//                 fontFamily: 'Satoshi',
//                 fontWeight: FontWeight.w500,
//               ),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16.0),
//                 borderSide: BorderSide(color: borderColor, width: 1.5),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16.0),
//                 borderSide: BorderSide(color: borderColor, width: 2.0),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
