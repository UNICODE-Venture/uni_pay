class UniPayText {
  static bool isEnglish = true;

  static String get payWithCard =>
      isEnglish ? "Pay By Card" : "ادفع عبر بطاقتك المصرفية";

  static String get somethingWentWrong => isEnglish
      ? "Something went wrong, please try again later"
      : "حدث خطأ ما ، يرجى المحاولة مرة أخرى في وقت لاحق";

  static String get payByTamara => isEnglish
      ? "Tamara: Split your bill into 3 interest-free installments."
      : "تمارا: قسم فاتورتك على 3 دفعات بدون فوائد";

  static String get payNow => isEnglish ? "Pay Now" : "ادفع الآن";

  static String get checkout => isEnglish ? "Checkout" : "الدفع";
  static String get paymentStatus =>
      isEnglish ? "Payment Status" : "حالة الدفع";

  static String get checkoutByTamara =>
      isEnglish ? "Checkout by Tamara" : "الدفع عبر تمارا";

  static String get checkoutByTabby =>
      isEnglish ? "Checkout by Tabby" : "الدفع عبر تابي";

  static String get tabbyErrorMsg => isEnglish
      ? "Your payment request has been declined by Tabby, kindly try again later."
      : "تم رفض طلب الدفع الخاص بك من قبل تابي ، يرجى المحاولة مرة أخرى في وقت لاحق.";

  static String pleaseProvideCredentials =
      "Please provide payment gateway secret credentials to proceed the payment";
  static String pleaseProvideTamaraCredentails =
      "Please provide Tamara secret credentials to proceed the payment";

  static String pleaseProvideTabbyCredentails =
      "Please provide Tabby secret credentials to proceed the payment";

  static String pleaseProvideMoyasarCredentails =
      "Please provide Moyasar secret credentials to proceed the payment";
  static String noGatewayProvided =
      "No payment gateway provided, please provide one of the following gateways: [UniPayPaymentMethods.card]";

  static String get paymentFailed => isEnglish
      ? "Sorry, your payment was failed, make sure you have the enough balance on your card or the online payment is enabled for your card."
      : "عذرًا ، فشل الدفع الخاص بك ، تأكد من أن لديك رصيدًا كافيًا في بطاقتك أو تم تمكين الدفع عبر الإنترنت لبطاقتك.";

  ///* Tamara ----------
  static String get tamaraSplitBill => isEnglish
      ? "Tamara: Split in 3, interest-free"
      : "تمارا: قسم فاتورتك على 3 دفعات بدون فوائد";

  static String get tamaraSplitBillSubTitle => isEnglish
      ? "Pay a fraction of your total now and the rest over time, No hidden fees, no interest!"
      : "ادفع جزء من المبلغ الآن والباقي على حسب خطة الدفع, بدون فوائد ورسوم خفية!";

  ///* Tabby ----------
  static String get tabbySplitBill =>
      isEnglish ? "Tabby: Pay in 4 installments" : "تابي: ادفع على 4 دفعات";

  ///* Card

  static String get payByCardSubTitle => isEnglish
      ? "We accept mada, visa, mastercard, and american express."
      : "نقبل مدى وفيزا وماستركارد وأمريكان إكسبريس";

  static String get learnMore => isEnglish ? "Learn More!" : "اعرف أكثر!";

  static String get applePayMerchantIdentifierError => isEnglish
      ? "Please provide apple pay merchant identifier to proceed the payment"
      : "يرجى تقديم معرف تاجر Apple Pay لمتابعة الدفع";

  static String noTransactionFound =
      "No transaction found for the provided metadata!";

  // Tamara Campaign
  static String get tamaraCampaign1 => isEnglish
      ? "Or split in 3 payments of"
      : "أو قسم فاتورتك على 3 دفعات بقيمة";

  static String get tamaraCampaign2 => isEnglish
      ? "- No late fees, Sharia compliant!"
      : "بدون رسوم تأخير، متوافقة مع الشريعة الإسلامية";

  static String sar(amount) => isEnglish ? " SAR $amount " : " $amount ر.س ";

  static String get tamaraCheckoutTitle => isEnglish
      ? "Split in 3 payments - No late fees, Sharia compliant"
      : "قسمها على 3 دفعات - بدون رسوم تأخير، متوافقة مع الشريعة الإسلامية";

  static String get paymentCancelled => isEnglish
      ? "You aborted the payment. Please retry or choose another payment method."
      : "لقد ألغيت الدفعة. فضلاً حاول مجددًا أو اختر طريقة دفع أخرى.";

  static String get paymentFailedByTabby => isEnglish
      ? "Sorry, Tabby is unable to approve this purchase. Please use an alternative payment method for your order."
      : "نأسف، تابي غير قادرة على الموافقة على هذه العملية. الرجاء استخدام طريقة دفع أخرى.";

  static String get paymentFailedByTamara => isEnglish
      ? "Sorry, Tamara is unable to approve this purchase. Please use an alternative payment method for your order."
      : "نأسف، تمارا غير قادرة على الموافقة على هذه العملية. الرجاء استخدام طريقة دفع أخرى.";

  static String get paymentWasFailed => isEnglish
      ? "Sorry, your payment was failed, make sure you have the enough balance on your card or the online payment is enabled for your card."
      : "عذرًا ، فشل الدفع الخاص بك ، تأكد من أن لديك رصيدًا كافيًا في بطاقتك أو تم تمكين الدفع عبر الإنترنت لبطاقتك.";

  //  ---------- Below are new updates v2 realted texts ---------- //
  static String get yourPaymentMethod =>
      isEnglish ? "Payment Methods" : "طريقة دفعك";

  static String get selectYourPaymentMethod => isEnglish
      ? "Select your preferred payment method"
      : "حدد طريقة الدفع الافتراضية";

  static String get creditCards =>
      isEnglish ? "Credit or Debit Cards" : "بطاقة ائتمانية";

  static String get applePay => isEnglish ? "Apple Pay" : "آبل باي";

  static String get cardDataSecured => isEnglish
      ? "Card data will not be stored, and 100% secured."
      : "لن يتم الاحتفاظ ببيانات البطاقة ، آمنة بنسبة 100٪";
  static String get doYouHaveCoupon =>
      isEnglish ? "Do you have any coupon?" : "هل لديك كوبون خصم؟";
  static String get enterCouponCodeHere =>
      isEnglish ? "Enter the coupon code here..." : "اكتب كود الخصم هنا...";
  static String get startToPay => isEnglish ? "Pay now" : "بدء الدفع الآن";

  static String get payByStcPay => isEnglish
      ? "STC Pay: Fast and secure digital wallet"
      : "STC Pay: محفظة رقمية سريعة وآمنة";
  static String get notSpecified => isEnglish ? "Not Specified" : "غير محدد";
  static String get apply => isEnglish ? "Apply" : "تطبيق";
}
