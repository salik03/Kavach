//
//
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController _controller = TextEditingController();
//   bool _isPhoneNumberValid = false;
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: primaryColor,
//         systemNavigationBarColor: dialogueBoxColor,
//         systemNavigationBarIconBrightness: Brightness.dark,
//       ),
//     );
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).backgroundColor,
//         appBar: AppBar(
//           title: Text('Phone Authentication'),
//         ),
//         body: ListView( // Use ListView
//           shrinkWrap: true, // Set shrinkWrap to true
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 gradient: bgradient,
//               ),
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     login,
//                     width: 338,
//                     height: 380,
//                     fit: BoxFit.contain,
//                   ),
//                   SizedBox(height: 16),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: dialogueBoxColor,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 4,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // ... (other parts of the code remain the same)
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
