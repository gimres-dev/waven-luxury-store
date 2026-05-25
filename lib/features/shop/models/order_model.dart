import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/shop/models/cart_item_model.dart';
import 'package:t_store/utils/constants/enums.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final List<CartItemModel> items;
  DateTime? deliveryDate;
  String? shippingAddress;

  OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.paymentMethod,
    required this.items,
    this.deliveryDate,
    this.shippingAddress,
  });

  String get formattedStatus {
    switch (status) {
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }

  String get formattedOrderDate =>
      '${orderDate.day.toString().padLeft(2, '0')} '
      '${_monthName(orderDate.month)} ${orderDate.year}';

  String _monthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  String get formattedDeliveryDate => deliveryDate != null
      ? '${deliveryDate!.day.toString().padLeft(2, '0')} '
        '${_monthName(deliveryDate!.month)} ${deliveryDate!.year}'
      : 'N/A';

  Map<String, dynamic> toJson() => {
        'UserId': userId,
        'Status': status.toString(),
        'TotalAmount': totalAmount,
        'OrderDate': Timestamp.fromDate(orderDate),
        'PaymentMethod': paymentMethod,
        'Items': items.map((i) => i.toJson()).toList(),
        'DeliveryDate': deliveryDate != null
            ? Timestamp.fromDate(deliveryDate!)
            : null,
        'ShippingAddress': shippingAddress ?? '',
      };

  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    OrderStatus status = OrderStatus.processing;
    final statusStr = data['Status'] ?? '';
    for (final s in OrderStatus.values) {
      if (s.toString() == statusStr) {
        status = s;
        break;
      }
    }

    return OrderModel(
      id: document.id,
      userId: data['UserId'] ?? '',
      status: status,
      totalAmount: (data['TotalAmount'] ?? 0.0).toDouble(),
      orderDate: (data['OrderDate'] as Timestamp).toDate(),
      paymentMethod: data['PaymentMethod'] ?? '',
      items: (data['Items'] as List? ?? [])
          .map((i) => CartItemModel.fromMap(Map<String, dynamic>.from(i)))
          .toList(),
      deliveryDate: data['DeliveryDate'] != null
          ? (data['DeliveryDate'] as Timestamp).toDate()
          : null,
      shippingAddress: data['ShippingAddress'],
    );
  }
}
