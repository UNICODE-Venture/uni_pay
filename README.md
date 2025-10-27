### Payment Gateway Library Crafted by the **[UNICODE Team](https://www.unicodesolutions.co/)** for Seamless Local, GCC and International Transactions.

##### A unified payment library built for speed and simplicity.

Seamlessly integrate Moyasar (Cards, STC Pay, Apple Pay), Tamara, and Tabby in minutes -> not days. Effortlessly manage transactions, elevate your checkout experience, and simplify payment operations with our robust, flexible, and developer-friendly solution.lution.

# **Features support**

- **Card support (mada, visa, mastercard, amex) - [Docs](https://moyasar.com/docs/api/#api-keys)**
- **Apple Pay - [Integration](https://help.moyasar.com/en/article/moyasar-dashboard-apple-pay-certificate-activation-9l6sd5/) and [Xcode setup](https://help.apple.com/xcode/mac/9.3/#/deva43983eb7?sub=dev44ce8ef13)**
- **Tamara - [Docs](https://docs.tamara.co/introduction/)**
- **Tabby - [Docs](https://api-docs.tabby.ai/)**
- **stcpay - [Docs](https://docs.moyasar.com/guides/stc-pay/basic-integration)**

<img src="https://raw.githubusercontent.com/UNICODE-Venture/uni_pay/main/assets/screenshots/v2/sc_ar.png" width=200, height=400 alt="UniPay by Mohammad Saiful Islam Saif"> 
<img src="https://raw.githubusercontent.com/UNICODE-Venture/uni_pay/main/assets/screenshots/v2/sc_en.png" width=200, height=400 alt="UniPay by Mohammad Saiful Islam Saif">

## Getting started

Please have a look at our [/example](https://pub.dev/packages/uni_pay/example) project for a better understanding of implementations.

```dart
   UniPayData(
      appName = "UniPay",
      locale = UniPayLocale.en,
      customerInfo = UniPayCustomerInfo(
        fullName: "Mohammad Saiful Islam Saif",
        email: "contact@mohammadsaif.dev",
        phoneNumber: "+966555666777",
        address: UniPayAddress(
          addressName: "KAFD Area, Al-Ghadir, Riyadh, Saudi Arabia",
          city: "Riyadh",
        ),
      ),
      themeData = UniPayThemeData(
        uiType: UniPayUIType.modernWithAppBar,
      ),
      environment = UniPayEnvironment.development,
      credentials = UniPayCredentials(
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
      orderInfo = UniPayOrder(
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
      onPaymentSucess = (res) {
        debugPrint("Payment Success ----> ${res.toMap()}");
      },
      onPaymentFailed = (res) {
        debugPrint("Payment Failed ----> ${res.toMap()}");
      },
      metaData = {
        "customer_uid": "ABC_12345",
        "customer_name": "Mohammad Saiful Islam Saif",
      },
    )
```

### Moyasar Features 🚀

- Get the transaction details by id:

```dart
UniPayResponse transaction =
                    await UniPayServices.getMoyasarPaymentByTransactionId(
                  credential: MoyasarCredential(secretKey: "sk_live"),
                  transactionId: "trxn_id",
                );
```

### Tabby Features 🚀

- Get the transaction details:

```dart
  TabbyTransaction transaction =  await UniTabbyServices.getTabbyTransactionDetails(
                      tabbyDto: TabbyDto(
                      transactionId: "trxn_id",
                      credential: TabbyCredential(
                        psKey: "pk_test",
                        secretKey: "sk_test",
                        merchantCode: "your_merchant_code",
                      )));
```

- Capture the order:

```dart
  TabbyTransaction transaction =  await UniTabbyServices.captureTabbyPayment(
                      tabbyDto: TabbyDto(
                      transactionId: "trxn_id",
                      credential: TabbyCredential(
                        psKey: "pk_test",
                        secretKey: "sk_test",
                        merchantCode: "your_merchant_code",
                      ),
                      amount: 950.55,
                    ));
```

- Show the Product page Banner of Tabby:

```dart
              UniTabbyServices.showProductPageTabbySnippet(
                tabbySnippet: TabbySnippet(
                  totalAmountWithVat: 150.50,
                  locale: UniPayLocale.ar,
                ),
              )
```

- Show the Checkout page Banner of Tabby:

```dart
              UniTabbyServices.showTabbyCheckoutSnippet(
                tabbySnippet: TabbySnippet(
                  totalAmountWithVat: 150.50,
                  locale: UniPayLocale.ar,
                ),
              )
```

### Tamara Features 🚀

- Show the Product page Banner of Tamara:

```dart
               UniPayServices.tamaraProductPageSnippet(
                  const TamaraSnippet(
                    psKey: "ps_key",
                    transactionAmount: 150,
                    locale: UniPayLocale.en,
                  ),
                ),
```

- Show the Checkout page Banner of Tamara:

```dart
                UniPayServices.tamaraCheckoutPageSnippet(
                  const TamaraSnippet(
                    psKey: "ps_key",
                    transactionAmount: 150,
                    locale: UniPayLocale.ar,
                  ),
                )
```

#### If you enjoyed it, then give it a star ⭐️ and like 👍🏻 and for more arts & crafts 🎨 from our team kindly visit here [Team UNICODE](https://pub.dev/publishers/unicodesolutions.co/packages). Until next time, keep coding and stay awesome 😉
