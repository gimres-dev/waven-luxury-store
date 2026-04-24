class TPricingCalculator {
  /// Calculate total price (product + tax + shipping)
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  /// Calculate shipping cost (formatted)
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  /// Calculate tax (formatted)
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  /// Get tax rate based on location
  static double getTaxRateForLocation(String location) {

    switch (location.toLowerCase()) {
      case 'us':
        return 0.08;
      case 'uk':
        return 0.20;
      case 'lk': // Sri Lanka
        return 0.15;
      default:
        return 0.10; 
    }
  }

  /// Get shipping cost based on location
  static double getShippingCost(String location) {
    // TODO: Replace with real API logic

    switch (location.toLowerCase()) {
      case 'us':
        return 5.00;
      case 'uk':
        return 7.50;
      case 'lk':
        return 3.00;
      default:
        return 5.00;
    }
  }
}
