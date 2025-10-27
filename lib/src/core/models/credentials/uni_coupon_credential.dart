//* Coupon related credentials
import 'package:flutter/foundation.dart';

class CouponCredential {
  /// Whether the coupon field is open by default, default is `false`
  late bool isCouponFieldDefaultOpen;

  /// Min length of the coupon code
  late int minCouponLength;

  /// Hint text for coupon field
  late String? hintText;

  /// When entered coupon
  /// ```dart
  /// onCouponApplied: (couponCode) async {
  ///   // Validate coupon code
  ///   return Future.value(true); // Return true if valid, false otherwise
  /// }
  /// ```
  late Future<bool> Function(String)? onCouponApplied;

  /// When coupon letter changed
  late ValueChanged<String>? onCouponValChanged;

  CouponCredential({
    this.isCouponFieldDefaultOpen = false,
    this.minCouponLength = 5,
    this.hintText,
    this.onCouponApplied,
    this.onCouponValChanged,
  });
}
