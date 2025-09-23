import 'package:flutter/material.dart';
import 'package:tabby_flutter_inapp_sdk_fork/tabby_flutter_inapp_sdk_fork.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/utils.dart';
import 'package:uni_pay/uni_pay.dart'
    show
        TabbyCredential,
        TabbyDto,
        TabbySnippet,
        UniPayCustomerInfo,
        UniPayData,
        UniPayOrder,
        UniPayResponse,
        UniPayStatus,
        UniPayPaymentMethods;

import '../../../../core/controllers/uni_pay_controller.dart';
import '../models/tabby_session.dart';
import '../models/tabby_trxn.dart';
import 'tabby_repo.dart';

final _tabbyRepo = TabbyRepo();

/// Include all Tabby related Services to handle Tabby payment gateway,
///
/// Such as: Initiate tabby payment, create session, capture payment, get transaction details, etc.
class UniTabbyServices {
  static final TabbySDK _tabbySdk = TabbySDK();

  /// Check if Tabby SDK is initialized
  static bool get isSdkInitialized {
    try {
      return _tabbySdk.publicKey.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Init Tabby SDK to prepare for payment
  static void initTabbySDK(
    TabbyCredential? credentials, {
    Environment env = Environment.production,
  }) {
    if (credentials != null && !isSdkInitialized) {
      _tabbySdk.setup(withApiKey: credentials.psKey, environment: env);
      uniLog("✔ Tabby SDK initialized successfully");
    } else {
      uniLog("⚠ Tabby credentials not provided or SDK already initialized");
    }
  }

  /// Show Tabby payment snippet
  ///
  /// Please make sure you provided the required data
  static Widget showProductPageTabbySnippet(
      {required TabbySnippet tabbySnippet}) {
    return TabbyProductPageSnippet(
      price: tabbySnippet.totalAmountWithVat.toDouble(),
      currency: tabbySnippet.currency.tabbyCurrency,
      lang: tabbySnippet.locale.tabbyLang,
      merchantCode: tabbySnippet.merchantCode,
      apiKey: tabbySnippet.psKey,
      installmentsCount: tabbySnippet.installmentCount,
      environment: tabbySnippet.environment.tabbyEnv,
    );
    // return TabbyPresentationSnippet(
    //   price: tabbySnippet.totalAmountWithVat.formattedString,
    //   currency: tabbySnippet.currency.tabbyCurrency,
    //   lang: tabbySnippet.locale.tabbyLang,
    //   textColor: tabbySnippet.textColor,
    //   backgroundColor: tabbySnippet.backgroundColor,
    //   borderColor: tabbySnippet.borderColor,
    // );
  }

  /// Please make sure you provided the required data
  static Widget showTabbyCheckoutSnippet({required TabbySnippet tabbySnippet}) {
    return showProductPageTabbySnippet(tabbySnippet: tabbySnippet);
    // return TabbyCheckoutSnippet(
    //   price: tabbySnippet.totalAmountWithVat.formattedString,
    //   currency: tabbySnippet.currency.tabbyCurrency,
    //   lang: tabbySnippet.locale.tabbyLang,
    // );
  }

  /// Create Tabby session to proceed with payment
  static Future<TabbySessionData?> createTabbySession(
      UniPayData uniPayData) async {
    UniPayOrder order = uniPayData.orderInfo;
    UniPayCustomerInfo customer = uniPayData.customerInfo;
    TabbyCredential tabbyCredential = uniPayData.credentials.tabbyCredential!;

    try {
      TabbyCheckoutPayload tabbyCheckoutPayload = TabbyCheckoutPayload(
        merchantCode: tabbyCredential.merchantCode,
        lang: uniPayData.locale.tabbyLang,
        payment: Payment(
          description: order.description,
          meta: uniPayData.metaData,
          amount: order.transactionAmount.totalAmount.toString(),
          currency: order.transactionAmount.currency.tabbyCurrency,
          buyer: Buyer(
            // 'card.success@tabby.ai',
            // '0500000001'
            // 'otp.rejected@tabby.ai',
            // '0500000002'
            email: customer.email,
            phone: customer.phoneNumber,
            name: customer.fullName,
          ),
          buyerHistory: BuyerHistory(
            loyaltyLevel: 0,
            registeredSince: customer.joinedAtDate.toUtc().toIso8601String(),
            wishlistCount: 0,
          ),
          order: Order(
            referenceId: order.orderId,
            items: order.items
                .map(
                  (item) => OrderItem(
                    title: item.name,
                    description: item.itemType.name,
                    quantity: item.quantity,
                    unitPrice: item.totalPrice.formattedString,
                    referenceId: item.sku,
                    category: item.itemType.name,
                  ),
                )
                .toList(),
          ),
          orderHistory: [
            // OrderHistoryItem(
            //   purchasedAt: DateTime.now().toUtc().toIso8601String(),
            //   amount: order.transactionAmount.totalAmount.formattedString,
            //   paymentMethod: OrderHistoryItemPaymentMethod.card,
            //   status: OrderHistoryItemStatus.newOne,
            // )
          ],
          shippingAddress: ShippingAddress(
            city: customer.address.city,
            address: customer.address.addressName,
            zip: customer.address.zipCode,
          ),
        ),
      );
      final sessionResult = await _tabbySdk.createSession(tabbyCheckoutPayload);
      TabbySessionData session = TabbySessionData(
        sessionId: sessionResult.sessionId,
        paymentId: sessionResult.paymentId,
        availableProducts: sessionResult.availableProducts,
        status: SessionStatus.created,
      );
      uniLog("✔ Tabby Session: ${session.toString()}");
      return session;
    } on ServerException catch (e) {
      uniLog("Tabby ServerException: $e");
      return null;
    }
  }

  /// Process the Tabby payment
  static Future processTabbyPayment(
    BuildContext context,
    UniPayStatus status, {
    String? transactionId,
    bool isFromRoot = true,
  }) {
    UniPayResponse response = UniPayResponse(status: status);

    /// If payment is successful, then return the transaction ID
    if (status.isSuccess) {
      response.transactionDetails.type = UniPayPaymentMethods.tabby;
      response.transactionId = transactionId ??
          "TABBY_TRXN_${UniPayControllers.uniPayData.orderInfo.orderId}}";
    }
    return UniPayControllers.handlePaymentsResponseAndCallback(
      context,
      response: response,
      isFromRootView: isFromRoot,
    );
  }

  /// Check the Pre-score result session, before proceeding with payment
  static Future<TabbySessionData?> checkPreScoreSession(
      UniPayData uniPayData) async {
    // Initialize Tabby SDK
    initTabbySDK(uniPayData.credentials.tabbyCredential);
    return createTabbySession(uniPayData);
  }

  /// Get the transaction details from Tabby
  static Future<TabbyTransaction> getTabbyTransactionDetails(
      {required TabbyDto tabbyDto}) {
    return _tabbyRepo.getTransactionDetails(tabbyDto: tabbyDto);
  }

  /// Capture the transaction to Tabby, so that they will complete the payment for your merchant.
  static Future<TabbyTransaction> captureTabbyPayment(
      {required TabbyDto tabbyDto}) {
    return _tabbyRepo.captureTabbyOrder(tabbyDto: tabbyDto);
  }
}
