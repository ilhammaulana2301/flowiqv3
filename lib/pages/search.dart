// import 'package:aplikasibaru/pages/detail.dart';
// import 'package:flutter/material.dart';
// import 'package:aplikasibaru/pages/check.dart';

// class SearchPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pencarian'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               // Implement search functionality
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Cari...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.0),
//                 ),
//               ),
//               onChanged: (value) {
//                 // Implement search filter logic
//               },
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 ListTile(
//                   title: Text('Limpok'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => StatusPage(place: 'Limpok')),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   title: Text('Lambaro'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => DetailStatus(place: 'Lambaro')),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
