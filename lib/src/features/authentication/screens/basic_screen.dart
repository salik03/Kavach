//
// class Template extends StatelessWidget {
//   const Template({Key? key}) : super(key: key);
//   static const LinearGradient bgradient = LinearGradient(
//       colors: gradientColors,
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter);
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//         const SystemUiOverlayStyle(
//           statusBarColor: primaryColor,
//           systemNavigationBarColor: dialogueBoxColor,
//           systemNavigationBarIconBrightness: Brightness.dark,
//         ));
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: Theme.of(context).backgroundColor,
//             body: Container(
//                 decoration: BoxDecoration(
//                   gradient: bgradient,
//                   image: backdrop,
//                 )))
//     );
//   }
// }
