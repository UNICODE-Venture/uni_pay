/// A comprehensive library for seamless online payments, integrating Moyasar (Card & Apple pay), Tamara, and Tabby payment gateways. Effortlessly handle transactions, enhance user experience, and streamline your payment processing with our robust and versatile solution.
///
/// Developed, published, and maintained by Mohammad Saiful Islam Saif, and Falcon team members at UNICODE.
///
/// View my [Github](https://github.com/mohammadsaif19) Profile, or
/// visit my [Website](https://mohammadsaif.dev/?utm_source=uni_pay)

library uni_pay;

/// Models used to process the payment
export 'src/core/models/transaction.dart';
export 'src/core/models/uni_credentials.dart';
export 'src/core/models/uni_order.dart';
export 'src/core/models/uni_pay_address.dart';
export 'src/core/models/uni_pay_customer.dart';
export 'src/core/models/uni_pay_data.dart';
export 'src/core/models/uni_pay_res.dart';
export 'src/core/models/uni_pay_item.dart';
export 'src/core/models/widget_data.dart';
export 'src/core/models/uni_customer_history.dart';

// ------------------- Modules or payment gateways used to process the payment ------------------- //

// Tamara - Models
export 'src/modules/tamara/core/models/t_checkout.dart';
export 'src/modules/tamara/core/models/tamara_data.dart';
export 'src/modules/tamara/core/models/capture_order.dart';
export 'src/modules/tamara/core/models/capture_response.dart';
export 'src/modules/tamara/core/models/tamara_snippet.dart';

// Tamara - Services
export 'src/modules/tamara/core/services/uni_tamara.dart';

// Tamara - Views
export 'src/modules/tamara/views/tamara_pay_view.dart';
export 'src/modules/tamara/views/widget/tamara_split_widget.dart';

/// Utils - services, enums, and other utility files
export 'src/utils/uni_enums.dart';
// export 'src/utils/utils.dart';

/// Views - Main view to process the payment with different payment gateways
export 'src/views/uni_pay_view.dart';

/// Uni Apple Pay
export 'src/modules/applepay/uni_apple_pay.dart';

/// Core services used to process the payment
export 'src/core/services/uni_pay_services.dart';

// Tabby - Models
export 'src/modules/tabby/core/models/tabby_credentials.dart';
export 'src/modules/tabby/core/models/tabby_snippet.dart';
export 'src/modules/tabby/core/models/tabby_session.dart';
export 'src/modules/tabby/core/models/tabby_trxn.dart';
export 'src/modules/tabby/core/models/tabby_dto.dart';

// Tabby - Views
export 'src/modules/tabby/views/tabby_pay_view.dart';
export 'src/modules/tabby/views/widgets/tabbly_payment.dart';
export 'src/modules/tabby/core/services/tabby_services.dart';

// Credentials
export 'src/core/models/credentials/uni_coupon_credential.dart';
export 'src/core/models/credentials/uni_moyasar_credential.dart';
export 'src/core/models/credentials/uni_tamara_credential.dart';
export 'src/core/models/credentials//uni_merchant_url.dart';

// Theme
export 'src/core/models/theme/uni_pay_theme_data.dart';

// Coupon Field
export 'src/modules/global/widgets/coupon_field.dart';





/// Controllers used to process the payment
// export 'src/providers/uni_pay_provider.dart';