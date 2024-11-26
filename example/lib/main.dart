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
    //! Initialize UniPay can be now also be done by calling this method
    // UniPayServices.initUniPay(uniPayData: uniPayData, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return UniPay(
      context: context,
      uniPayData: uniPayData,
    );
    // return _applePayOnlyView();
  }

  // To show the Apple Pay only view
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

/// UniPayData to be used for payment request
UniPayData uniPayData = UniPayData(
  appName: "UniPay",
  locale: UniPayLocale.en,
  customerInfo: UniPayCustomerInfo(
    fullName: "Mohammad Saif",
    email: "example@mail.com",
    phoneNumber: "+966555666777",
    address: UniPayAddress(
      addressName: "Olaya street, Al Ghadir",
      city: "Riyadh",
    ),
  ),
  environment: UniPayEnvironment.development,
  credentials: UniPayCredentials(
    applePayMerchantIdentifier: "merchant.com.myapp.sa",
    paymentMethods: [
      UniPayPaymentMethods.card,
      UniPayPaymentMethods.applePay,
      UniPayPaymentMethods.tamara,
      UniPayPaymentMethods.tabby,
    ],
    moyasarCredential: MoyasarCredential(
      publishableKey: "pk_test",
      secretKey: "sk_test",
    ),
    tamaraCredential: TamaraCredential(
      installment: 3,
      token: "Bearer test",
      merchantUrl: MerchantUrl(notification: "https://my-app.com/webhook"),
    ),
    tabbyCredential: TabbyCredential(
      psKey: "pk_test",
      secretKey: "sk_test",
      merchantCode: "your_merchant_code",
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
    "customerId": "ABC_12345",
    "customerName": "Mohammad Saif",
  },
);
