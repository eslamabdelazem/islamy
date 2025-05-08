// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_compass/flutter_compass.dart';
// import 'package:islamy/core/helpers/helpers.dart';
// import 'package:islamy/core/helpers/location.dart';
// import 'package:islamy/core/navifation/go.dart';
// import 'package:islamy/core/shared/models/location.dart';
// import 'package:vector_math/vector_math.dart' as vector_math;
//
// class QiblaCompassScreen extends StatefulWidget {
//   const QiblaCompassScreen({super.key});
//
//   @override
//   State<QiblaCompassScreen> createState() => _QiblaCompassScreenState();
// }
//
// class _QiblaCompassScreenState extends State<QiblaCompassScreen> with SingleTickerProviderStateMixin {
//
//   StreamSubscription<CompassEvent>? _compassSubscription;
//
// void _startListeningToCompass() {
//   _compassSubscription = FlutterCompass.events?.listen((event) {
//     setState(() {
//       _heading = event.heading ?? 0;
//     });
//   });
// }
//
//
// @override
// void dispose() {
//   _compassSubscription?.cancel();
//   super.dispose();
// }
//
//   // Compass rotation animation controller
//   late AnimationController _animationController;
//
//   // Current device heading (from device compass sensor)
//   double _heading = 0;
//
//   // Qibla direction calculation result
//   double _qiblaDirection = 0;
//
//   Future<void> _getUserLocation() async {
//     try {
//       final LocationModel? model = await Helpers.getLastSavedLocation();
//       if(model == null) {
//         // Go.to(const LocationScreenWithNamed.detectCurrentUserLocation(method: NavigationMethod.pop));
//       }else{
//         double? userLatitude = model.lat!.toDouble();
//         double userLongitude = model.lng!.toDouble();
//         _qiblaDirection = calculateQiblaDirection(userLatitude, userLongitude);
//       }
//     } on Exception {
//       Go.to(const LocationScreenWithNamed.detectCurrentUserLocation(method: NavigationMethod.pop));
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _startListeningToCompass();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//
//     _getUserLocation();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Colors.teal.shade50, Colors.teal.shade100],
//         ),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Information card
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         'Qibla Direction',
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.teal.shade800,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         '${_qiblaDirection.toStringAsFixed(1)}° from North',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.teal.shade600,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         getDirectionDescription(_qiblaDirection),
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 20),
//
//             // Compass
//             Container(
//               height: 320,
//               width: 320,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   // Outer circle and bezel
//                   Container(
//                     width: 310,
//                     height: 310,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 15,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                       border: Border.all(
//                         color: Colors.teal.shade800,
//                         width: 4,
//                       ),
//                     ),
//                   ),
//
//                   // Rotating compass face
//                   Transform.rotate(
//                     angle: vector_math.radians(-_heading),
//                     child: Container(
//                       width: 280,
//                       height: 280,
//                       child: CustomPaint(
//                         painter: CompassFacePainter(),
//                       ),
//                     ),
//                   ),
//
//                   // Center cap
//                   Container(
//                     width: 30,
//                     height: 30,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                       border: Border.all(
//                         color: Colors.teal.shade900,
//                         width: 2,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 4,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Container(
//                         width: 5,
//                         height: 5,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.teal.shade900,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Qibla indicator (fixed at correct direction)
//                   Transform.rotate(
//                     angle: vector_math.radians(_qiblaDirection - _heading),
//                     child: Container(
//                       height: 275,
//                       width: 275,
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           // Qibla needle
//                           Positioned(
//                             top: 0,
//                             child: Container(
//                               height: 140,
//                               width: 22,
//                               child: CustomPaint(
//                                 painter: QiblaNeedlePainter(),
//                               ),
//                             ),
//                           ),
//
//                           // Kaaba icon
//                           Positioned(
//                             top: 20,
//                             child: Container(
//                               padding: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.location_on,
//                                 color: Colors.green.shade800,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 40),
//
//             // Calibration instructions
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               decoration: BoxDecoration(
//                 color: Colors.teal.shade50,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.teal.shade200),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.info_outline, color: Colors.teal.shade700),
//                   SizedBox(width: 12),
//                   Text(
//                     'Move in a figure 8 pattern to calibrate',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.teal.shade700,
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
//
//   // Convert degrees to a cardinal direction description
//   String getDirectionDescription(double angle) {
//     const List<String> directions = [
//       'North', 'North-Northeast', 'Northeast', 'East-Northeast',
//       'East', 'East-Southeast', 'Southeast', 'South-Southeast',
//       'South', 'South-Southwest', 'Southwest', 'West-Southwest',
//       'West', 'West-Northwest', 'Northwest', 'North-Northwest'
//     ];
//
//     int index = ((angle + 11.25) % 360 / 22.5).floor();
//     return directions[index];
//   }
//
//   // Calculate Qibla direction from user location
//   double calculateQiblaDirection(double latitude, double longitude) {
//     // Convert degrees to radians
//     double latRad = _toRadians(latitude);
//     double longRad = _toRadians(longitude);
//
//     // Kaaba coordinates (Mecca)
//     double meccaLatRad = _toRadians(21.4225);
//     double meccaLongRad = _toRadians(39.8262);
//
//     // Calculate the angle
//     double longitudeDiff = meccaLongRad - longRad;
//
//     double y = sin(longitudeDiff);
//     double x = cos(latRad) * tan(meccaLatRad) - sin(latRad) * cos(longitudeDiff);
//
//     // Calculate the angle in radians and convert to degrees
//     double qiblaRadians = atan2(y, x);
//     double qiblaDegrees = _toDegrees(qiblaRadians);
//
//     // Normalize to 0-360 degrees
//     if (qiblaDegrees < 0) {
//       qiblaDegrees += 360;
//     }
//
//     return qiblaDegrees;
//   }
//
//   double _toRadians(double degrees) => degrees * (pi / 180.0);
//   double _toDegrees(double radians) => radians * (180.0 / pi);
// }
//
// // Custom painter for the compass face with degree markers and labels
// class CompassFacePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;
//
//     // Paint for the thin degree markers
//     final degreeMarkerPaint = Paint()
//       ..color = Colors.grey.shade600
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0;
//
//     // Paint for the thicker 10-degree markers
//     final tenDegreeMarkerPaint = Paint()
//       ..color = Colors.grey.shade800
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;
//
//     // Paint for cardinal directions
//     final cardinalPaint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3.0;
//
//     // Paint for the face background
//     final bgPaint = Paint()
//       ..color = Colors.white.withOpacity(0.8)
//       ..style = PaintingStyle.fill;
//
//     // Draw the face background
//     canvas.drawCircle(center, radius - 2, bgPaint);
//
//     // Draw degree markers
//     for (int i = 0; i < 360; i++) {
//       final angle = vector_math.radians(i.toDouble());
//
//       if (i % 90 == 0) {
//         // Cardinal directions (thicker and longer)
//         final outerPoint = Offset(
//           center.dx + cos(angle) * (radius - 25),
//           center.dy + sin(angle) * (radius - 25),
//         );
//         final innerPoint = Offset(
//           center.dx + cos(angle) * (radius - 45),
//           center.dy + sin(angle) * (radius - 45),
//         );
//         canvas.drawLine(outerPoint, innerPoint, cardinalPaint);
//       } else if (i % 10 == 0) {
//         // Every 10 degrees (thicker)
//         final outerPoint = Offset(
//           center.dx + cos(angle) * (radius - 30),
//           center.dy + sin(angle) * (radius - 30),
//         );
//         final innerPoint = Offset(
//           center.dx + cos(angle) * (radius - 40),
//           center.dy + sin(angle) * (radius - 40),
//         );
//         canvas.drawLine(outerPoint, innerPoint, tenDegreeMarkerPaint);
//       } else {
//         // Every degree (thin)
//         final outerPoint = Offset(
//           center.dx + cos(angle) * (radius - 35),
//           center.dy + sin(angle) * (radius - 35),
//         );
//         final innerPoint = Offset(
//           center.dx + cos(angle) * (radius - 40),
//           center.dy + sin(angle) * (radius - 40),
//         );
//         canvas.drawLine(outerPoint, innerPoint, degreeMarkerPaint);
//       }
//     }
//
//     // Add text for cardinal directions
//     _drawCardinalDirection(canvas, center, radius, 0, "N", Colors.red);
//     _drawCardinalDirection(canvas, center, radius, 90, "E", Colors.black87);
//     _drawCardinalDirection(canvas, center, radius, 180, "S", Colors.black87);
//     _drawCardinalDirection(canvas, center, radius, 270, "W", Colors.black87);
//
//     // Add text for intercardinal directions
//     _drawCardinalDirection(canvas, center, radius, 45, "NE", Colors.grey.shade800);
//     _drawCardinalDirection(canvas, center, radius, 135, "SE", Colors.grey.shade800);
//     _drawCardinalDirection(canvas, center, radius, 225, "SW", Colors.grey.shade800);
//     _drawCardinalDirection(canvas, center, radius, 315, "NW", Colors.grey.shade800);
//
//     // Add numbering for every 30 degrees
//     for (int i = 0; i < 360; i += 30) {
//       if (i % 90 != 0) {  // Skip cardinal directions as we've already labeled them
//         _drawDegreeNumber(canvas, center, radius, i);
//       }
//     }
//   }
//
//   void _drawCardinalDirection(Canvas canvas, Offset center, double radius,
//       double angle, String text, Color color) {
//     final textSpan = TextSpan(
//       text: text,
//       style: TextStyle(
//         color: color,
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//
//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//     );
//
//     textPainter.layout();
//
//     final angleRad = vector_math.radians(angle);
//     final x = center.dx + cos(angleRad) * (radius - 65) - textPainter.width / 2;
//     final y = center.dy + sin(angleRad) * (radius - 65) - textPainter.height / 2;
//
//     textPainter.paint(canvas, Offset(x, y));
//   }
//
//   void _drawDegreeNumber(Canvas canvas, Offset center, double radius, int degrees) {
//     final textSpan = TextSpan(
//       text: '$degrees°',
//       style: TextStyle(
//         color: Colors.grey.shade700,
//         fontSize: 12,
//       ),
//     );
//
//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//     );
//
//     textPainter.layout();
//
//     final angleRad = vector_math.radians(degrees.toDouble());
//     final x = center.dx + cos(angleRad) * (radius - 90) - textPainter.width / 2;
//     final y = center.dy + sin(angleRad) * (radius - 90) - textPainter.height / 2;
//
//     textPainter.paint(canvas, Offset(x, y));
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// // Custom painter for the Qibla needle
// class QiblaNeedlePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final width = size.width;
//     final height = size.height;
//     final center = Offset(width / 2, height);
//
//     // Create path for arrow
//     final path = Path();
//
//     // Arrow point
//     path.moveTo(width / 2, 0);
//
//     // Arrow right side
//     path.lineTo(width * 0.65, height * 0.2);
//     path.lineTo(width * 0.55, height * 0.2);
//     path.lineTo(width * 0.55, height * 0.8);
//
//     // Arrow base
//     path.lineTo(width * 0.45, height * 0.8);
//
//     // Arrow left side
//     path.lineTo(width * 0.45, height * 0.2);
//     path.lineTo(width * 0.35, height * 0.2);
//
//     // Back to start
//     path.close();
//
//     // Green gradient for arrow
//     final gradient = LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [
//         Colors.green.shade800,
//         Colors.green.shade600,
//       ],
//     );
//
//     final paint = Paint()
//       ..shader = gradient.createShader(Rect.fromLTWH(0, 0, width, height))
//       ..style = PaintingStyle.fill;
//
//     // Shadow
//     canvas.drawShadow(path, Colors.black, 4, true);
//
//     // Arrow
//     canvas.drawPath(path, paint);
//
//     // Outline
//     final outlinePaint = Paint()
//       ..color = Colors.black54
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0;
//
//     canvas.drawPath(path, outlinePaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// // In a real app, you would use these packages:
// //
// // dependencies:
// //   flutter:
// //     sdk: flutter
// //   vector_math: ^2.1.0
// //   flutter_compass: ^0.7.0  # For device compass heading
// //   geolocator: ^9.0.0       # For getting user's location
// //   permission_handler: ^10.0.0  # For requesting location permissions
// //
// // Implementation note:
// // In your main app, you would subscribe to actual compass readings:
// //
// // StreamSubscription<CompassEvent>? _compassSubscription;
// //
// // void _startListeningToCompass() {
// //   _compassSubscription = FlutterCompass.events?.listen((event) {
// //     setState(() {
// //       _heading = event.heading ?? 0;
// //     });
// //   });
// // }
// //
// // Don't forget to dispose of the subscription when done:
// //
// // @override
// // void dispose() {
// //   _compassSubscription?.cancel();
// //   super.dispose();
// // }