import 'package:flutter/material.dart';
import 'package:uni_pay/uni_pay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniPay Example',
      home: PaymentView(),
    );
  }
}

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  void initState() {
    super.initState();
    //! Initialize UniPay can be now also be done by calling this method, if you require to use `Apple Pay` only.
    // UniPayServices.initUniPay(uniPayData: uniPayData, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return UniPay(
      context: context,
      uniPayData: uniPayData,
    );

    // ----- Standalone Apple Pay view ----- //
    // return _applePayOnlyView();
  }

  // To show the Apple Pay only view
  // ignore: unused_element
  Widget _applePayOnlyView() {
    return Scaffold(
      appBar: AppBar(title: const Text("UniPay Example")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          UniApplePay(context: context),
        ],
      ),
    );
  }
}

/// UniPayData to be used for payment request, make sure to fill all the required fields properly.
UniPayData uniPayData = UniPayData(
  appName: "UniPay",
  locale: UniPayLocale.ar,
  customerInfo: UniPayCustomerInfo(
    fullName: "Mohammad Saiful Islam Saif",
    email: "contact@mohammadsaif.dev",
    phoneNumber: "+966555666777",
    address: UniPayAddress(
      addressName: "KAFD Area, Al-Ghadir, Riyadh, Saudi Arabia",
      city: "Riyadh",
    ),
  ),
  themeData: UniPayThemeData(
    uiType: UniPayUIType.modernWithAppBar,
  ),
  environment: UniPayEnvironment.development,
  credentials: UniPayCredentials(
    applePayMerchantIdentifier: "merchant.com.myapp.sa",
    paymentMethods: [
      UniPayPaymentMethods.card,
      UniPayPaymentMethods.applepay,
      UniPayPaymentMethods.tamara,
      UniPayPaymentMethods.tabby,
    ],
    moyasarCredential: MoyasarCredential(
      publishableKey: "pk_test",
      secretKey: "sk_live",
    ),
    tamaraCredential: TamaraCredential(
      token: "Bearer test_12345",
      merchantUrl: MerchantUrl(notification: "https://my-app.com/webhook"),
    ),
    tabbyCredential: TabbyCredential(
      psKey: "pk_test",
      secretKey: "sk_test",
      merchantCode: "your_merchant_code",
      merchantUrl: MerchantUrl(notification: "https://my-app.com/webhook"),
    ),
    couponCredential: CouponCredential(
      onCouponApplied: (coupon) async {
        debugPrint("Coupon Applied: $coupon");

        // Simulate a network call or coupon validation
        await Future.delayed(const Duration(seconds: 3));

        /// Return true if coupon is valid and applied successfully
        return Future.value(true);
      },
    ),
  ),
  orderInfo: UniPayOrder(
    transactionAmount: TransactionAmount(totalAmount: 150.55),
    orderId: DateTime.now().millisecondsSinceEpoch.toString(),
    description: "Test Order Description",
    items: [
      UniPayItem(
        id: "Product_ID",
        name: "Product name",
        quantity: 1,
        price: 50,
      )
    ],
  ),
  onPaymentSucess: (res) {
    debugPrint("Payment Success ----> ${res.toMap()}");
  },
  onPaymentFailed: (res) {
    debugPrint("Payment Failed ----> ${res.toMap()}");
  },
  metaData: {
    "customer_uid": "ABC_12345",
    "customer_name": "Mohammad Saif",
  },
);
