import 'package:tabby_flutter_inapp_sdk_fork/tabby_flutter_inapp_sdk_fork.dart';

class TabbySessionData extends TabbySession {
  TabbySessionData({
    required super.sessionId,
    required super.paymentId,
    required super.availableProducts,
    super.status = SessionStatus.created,
    super.rejectionReason,
  });

  Map<String, dynamic> toJson() {
    final installment = availableProducts.installments;
    return {
      'sessionId': sessionId,
      'paymentId': paymentId,
      'installment': installment != null
          ? {
              'type': installment.type.name,
              'months': installment.webUrl,
            }
          : null,
    };
  }

  @override
  String toString() =>
      'TabbySessionData(sessionId: $sessionId, paymentId: $paymentId, isPreScoresPaassed: $isPreScorePassed, availableProducts: (type: ${availableProducts.installments?.type.name}, webUrl: ${availableProducts.installments?.webUrl}))';

  /// Check is Pre-score is passed
  bool get isPreScorePassed {
    final installment = availableProducts.installments;
    return installment != null && installment.webUrl.isNotEmpty;
    // && installment.type == TabbyPurchaseType.installments ;
  }
}
