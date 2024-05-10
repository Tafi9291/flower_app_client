import 'package:t_store/data/models/Users.dart';

class Address {
  int? addressId;
  int? usersId;
  String? address1;

  Address({this.addressId, this.usersId, this.address1});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressId: json['addressId'],
      usersId: json['usersId'],
      address1: json['address1'],
    );
  }

  Map<String, dynamic> toJson() => {
    'addressId': addressId,
    'usersId': usersId,
    'address1': address1,
  };
}
