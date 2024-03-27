import 'package:t_store/data/models/Users.dart';

class Address {
  int? addressId;
  int? usersId;
  String? address1;
  Users? users;

  Address({this.addressId, this.usersId, this.address1, this.users});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressId: json['AddressId'],
      usersId: json['UsersId'],
      address1: json['Address1'],
      users: json['Users'] != null ? Users.fromJson(json['Users']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'AddressId': addressId,
    'UsersId': usersId,
    'Address1': address1,
    'Users': users?.toJson(),
  };
}