import 'package:intl/intl.dart';

class TFormatter {
  
  /// -- Format Date
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date); // Example: 11-May-2026
  }

  /// -- Format Currency (Optional for store)
  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  /// -- Format Phone Number (The part he referenced)
  static String formatPhoneNumber(String phoneNumber) {
    // Assuming 10 digits: (071) 234-5678
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7)}';
    }
    // Return original if format is unknown
    return phoneNumber;
  }

  /// -- International Phone Formatting (Extra credit)
  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Remove all non-digits
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract the country code
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // Build the remaining number
    final formattedNumber = StringBuffer();
    formattedNumber.write(' ($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && digitsOnly.length == 11) {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }
    return formattedNumber.toString();
  }
}