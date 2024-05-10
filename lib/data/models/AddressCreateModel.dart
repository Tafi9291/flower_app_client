
class AddressCreateModel {
  final int usersId;
  final String address1;

  AddressCreateModel({required this.usersId, required this.address1});

  Map<String, dynamic> toJson() {
    return {
      'usersId': usersId,
      'address1': address1,
      // Add other properties as needed
    };
  }
}