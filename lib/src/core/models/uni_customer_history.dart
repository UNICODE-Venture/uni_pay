import 'package:uni_pay/uni_pay.dart';

class UniCustomerHistory {
  /// Amount of transaction
  late num totalAmount;

  /// Order Status
  late UniPayOrderStatus orderStatus;

  /// Date of the order placement
  late DateTime orderDate;

  /// Payment method used in the order
  late UniPayPaymentMethods paymentMethod;

  /// Items of the order
  late List<UniPayItem> items;

  UniCustomerHistory({
    this.totalAmount = 0,
    this.orderStatus = UniPayOrderStatus.pending,
    DateTime? orderDate,
    this.paymentMethod = UniPayPaymentMethods.card,
    this.items = const [],
  }) : orderDate = orderDate ?? DateTime.now();
}
