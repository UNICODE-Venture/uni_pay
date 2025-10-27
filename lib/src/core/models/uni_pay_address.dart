import 'package:tabby_flutter_inapp_sdk_fork/tabby_flutter_inapp_sdk_fork.dart';

import '../../utils/uni_enums.dart';

class UniPayAddress {
  ///* Customer address name e.g: Olaya street, Al Ghadir
  late String addressName;

  ///* Address city
  late String city;

  ///* Customer country
  late UniPayCountry country;

  ///* Address zip code default is `12211 -> Riyadh`
  late String zipCode;

  UniPayAddress({
    required this.addressName,
    required this.city,
    this.country = UniPayCountry.sa,
    this.zipCode = "12211",
  });

  UniPayAddress.fromJson(Map<String, dynamic> data) {
    addressName = data['address_name'];
    city = data['city'];
    country = UniPayCountry.values[data['country']];
    zipCode = data['zip_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address_name'] = addressName;
    data['city'] = city;
    data['country'] = country.index;
    data['zip_code'] = zipCode;
    return data;
  }

  @override
  String toString() {
    return 'UniPayAddress(addressName: $addressName, city: $city, country: ${country.countryCode}, zipCode: $zipCode)';
  }

  /// Tabby shipping address
  ShippingAddress get tabbyShippingAddress => ShippingAddress(
        city: city,
        address: addressName,
        zip: zipCode,
      );
}
