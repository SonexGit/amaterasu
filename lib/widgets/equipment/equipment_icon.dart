// import 'package:flutter/material.dart';

// class EquipmentIcon extends StatefulWidget {
//   @override
//   _EquipmentIconState createState() => _EquipmentIconState();
// }

// class _EquipmentIconState extends State<EquipmentIcon> {
//   bool _isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) {
//         setState(() {
//           _isPressed = true;
//         });
//       },
//       onTapUp: (_) {
//         setState(() {
//           _isPressed = false;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.all(10),
//         child: Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             Icon(Icons.equipment),
//             _isPressed
//                 ? Positioned(
//                     bottom: 30,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 1,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Text(
//                         "Description de l'équipement",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }
