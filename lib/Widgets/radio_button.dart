// import 'package:flutter/material.dart';
//
// class RadioButtonWidget extends StatefulWidget {
//   const RadioButtonWidget({Key? key}) : super(key: key);
//
//   @override
//   State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
// }
//
// class _RadioButtonWidgetState extends State<RadioButtonWidget> {
//   @override
//   Widget build(BuildContext context) {
//     Object? radioItem = '';
//     return Column(
//       children: <Widget>[
//
//         RadioListTile(
//           groupValue: radioItem,
//           title: Text('Radio Button Item 1'),
//           value: 'Item 1',
//           onChanged: (val) {
//             setState(() {
//               radioItem = val;
//             });
//           },
//         ),
//
//         RadioListTile(
//           groupValue: radioItem,
//           title: Text('Radio Button Item 2'),
//           value: 'Item 2',
//           onChanged: (val) {
//             setState(() {
//               radioItem = val;
//             });
//           },
//         ),
//
//         Text('$radioItem', style: TextStyle(fontSize: 23),)
//
//       ],
//     );
//   }
// }
