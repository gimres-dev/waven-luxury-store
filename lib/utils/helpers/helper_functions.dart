import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THelperFunctions {
  static Color? getColor(String value) {
    switch (value.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'red':
        return Colors.red;
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      case 'indigo':
        return Colors.indigo;
      case 'orange':
        return Colors.orange;
      case 'brown':
        return Colors.brown;
      case 'teal':
        return Colors.teal;
      case 'amber':
        return Colors.amber;
      default:
        return null;
    }
  }
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }
  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }
  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }
  static String getFormattedDate(DateTime date, {String format = 'dd MMM yyyy'}) {
    return date.toString(); 
  }
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}