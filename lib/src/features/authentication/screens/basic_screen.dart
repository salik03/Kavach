// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:kavach_2/src/features/authentication/screens/login_screen/login_screen.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// // ... (rest of the code remains unchanged)
//
// class PermissionScreen extends StatefulWidget {
//   const PermissionScreen({Key? key}) : super(key: key);
//
//   @override
//   _PermissionScreenState createState() => _PermissionScreenState();
// }
//
// class _PermissionScreenState extends State<PermissionScreen> {
//   // Variable to track whether all permissions are granted or not.
//   bool allPermissionsGranted = false;
//
//   // ... (rest of the code remains unchanged)
//
//   // Update the permission request methods to set the allPermissionsGranted variable.
//   Future<void> _requestLocationPermission() async {
//     final PermissionStatus status = await Permission.location.request();
//     setState(() {
//       allPermissionsGranted = status.isGranted;
//     });
//     // ... (rest of the code remains unchanged)
//   }
//
//   // ... (rest of the permission request methods remain unchanged)
//
//   @override
//   Widget build(BuildContext context) {
//     // ... (rest of the code remains unchanged)
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).backgroundColor,
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: bgradient,
//           ),
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // ... (rest of the code remains unchanged)
//
//               Container(
//                 // ... (rest of the code remains unchanged)
//                 child: ElevatedButton(
//                   onPressed: allPermissionsGranted // Check if all permissions are granted.
//                       ? () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoginScreen(),
//                       ),
//                     );
//                   }
//                       : null, // Set onPressed to null if not all permissions are granted.
//                   child: const Text(
//                     'I Agree',
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     primary: allPermissionsGranted ? Colors.white : buttonColor, // Set the button color based on permissions.
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
