### Payment Gateway Library Crafted by the **[UNICODE Team](https://www.unicodesolutions.co/)** for Seamless Transactions

A comprehensive library for seamless online payments, integrating Moyasar (Card & Apple pay), Tamara, and Tabby payment gateways. Effortlessly handle transactions, enhance user experience, and streamline your payment processing with our robust and versatile solution.

# **Features support**

- **Card support (mada, visa, mastercard, amex) - [Docs](https://moyasar.com/docs/api/#api-keys)**
- **Apple Pay - [Integration](https://help.moyasar.com/en/article/moyasar-dashboard-apple-pay-certificate-activation-9l6sd5/) and [Xcode setup](https://help.apple.com/xcode/mac/9.3/#/deva43983eb7?sub=dev44ce8ef13)**
- **Tamara - [Docs](https://docs.tamara.co/introduction/)**
- **Tabby - [Docs](https://api-docs.tabby.ai/)**

<img src="https://raw.githubusercontent.com/UNICODE-Venture/uni_pay/main/assets/screenshots/sc_ar.png" width=200, height=400 alt="UniPay Arabic by Saif"> 
<img src="https://raw.githubusercontent.com/UNICODE-Venture/uni_pay/main/assets/screenshots/sc_en.png" width=200, height=400 alt="UniPay English by Saif">

## Getting started

Please have a look at our [/example](https://pub.dev/packages/uni_pay/example) project for a better understanding of implementations.

```dart
   UniPay(
      uniPayData: UniPayData(
        appName: "UniPay",
        locale: UniPayLocale.ar,
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
          applePayMerchantIdentifier: "merchant.com.mystore.sa",
          paymentMethods: [
            UniPayPaymentMethods.card,
            UniPayPaymentMethods.applepay,
            UniPayPaymentMethods.tamara,
            UniPayPaymentMethods.tabby,

          ],
          moyasarCredential:
              MoyasarCredential(publishableKey: "pk_key", secretKey: "sk_key"),
          tamaraCredential: TamaraCredential(
            installment:4
            token: "Tamara_Token",
            merchantUrl:
                MerchantUrl(notification: "https://my-app.com/webhook"),
          ),
          tabbyCredential: TabbyCredential(psKey: "tabby_api_key"),
        ),
        orderInfo: UniPayOrder(
          transactionAmount: TransactionAmount(totalAmount: 150.55),
          orderId: DateTime.now().millisecondsSinceEpoch.toString(),
          description: "Test Order Description",
          items: [
            UniPayItem(
                id: "Product_ID", name: "Product name", quantity: 1, price: 50)
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
          "customerName": "Saif",
        }
      ),
    )
```

### Tabby Features

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

### Tamara Features

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
