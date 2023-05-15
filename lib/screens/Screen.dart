// import 'package:courtinfo_spark/components/BottomNav.dart';
// import 'package:flutter/material.dart';

// class Screen extends Scaffold {
//   Screen({
//     Key? key,
//     AppBar? appBar,
//     Color? backgroundColor,
//     bool withBottomNavigation = false,
//     bool withDismissKeyboard = false,
//     required Widget body,
//     Color? contentBackgroundColor,
//     bool? safeAreaTop,
//     bool? safeAreaBottom,
//     bool? safeAreaLeft,
//     bool? safeAreaRight,
//   }) : super(
//           key: key,
//           resizeToAvoidBottomInset: false,
//           backgroundColor: backgroundColor ?? Colors.white,
//           appBar: appBar,
//           body: _Page(
//             _Body(
//               body: body,
//               contentBackgroundColor: contentBackgroundColor,
//               safeAreaTop: safeAreaTop,
//               safeAreaLeft: safeAreaLeft,
//               safeAreaRight: safeAreaRight,
//               safeAreaBottom: safeAreaBottom,
//               withBottomNavigation: withBottomNavigation,
//             ),
//             withDismissKeyboard: withDismissKeyboard,
//           ),
//         );
// }

// class _Page extends StatelessWidget {
//   const _Page(
//     this.body, {
//     this.withDismissKeyboard = false,
//   });

//   final Widget body;
//   final bool withDismissKeyboard;

//   @override
//   Widget build(BuildContext context) {
//     if (withDismissKeyboard == true) {
//       return GestureDetector(
//         onTap: () => FocusManager.instance.primaryFocus != null
//             ? FocusManager.instance.primaryFocus!.unfocus()
//             : null,
//         child: body,
//       );
//     }
//     return body;
//   }
// }

// class _Body extends StatelessWidget {
//   const _Body({
//     Key? key,
//     this.body,
//     this.contentBackgroundColor,
//     this.safeAreaTop,
//     this.safeAreaBottom,
//     this.safeAreaLeft,
//     this.safeAreaRight,
//     this.withKeyboardAvoiding,
//     this.withBottomNavigation,
//   }) : super(key: key);

//   final Widget? body;
//   final Color? contentBackgroundColor;
//   final bool? safeAreaTop;
//   final bool? safeAreaBottom;
//   final bool? safeAreaLeft;
//   final bool? safeAreaRight;
//   final bool? withKeyboardAvoiding;
//   final bool? withBottomNavigation;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: safeAreaTop ?? true,
//       left: safeAreaLeft ?? true,
//       right: safeAreaRight ?? true,
//       bottom: safeAreaBottom ?? true,
//       child: Stack(
//         children: <Widget>[body!,  BottomNav()],
//       ),
//     );
//   }
// }
