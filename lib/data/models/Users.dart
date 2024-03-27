
class Users {
  int usersId;
  String firstName;
  String lastName;
  String nickName;
  String email;
  String password;
  String? phoneNumber;
  DateTime? birthDay;
  String? imageUrl;
  String? gender;
  DateTime? createAt;
  DateTime? updateAt;
  int? rolesId;
  // List<Address> addresses;
  // List<Cart> carts;
  // List<Notification> notifications;
  // List<Order> orders;
  // Role? roles;
  // List<Product> products;

  Users({
    required this.usersId,
    required this.firstName,
    required this.lastName,
    required this.nickName,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.birthDay,
    this.imageUrl,
    this.gender,
    this.createAt,
    this.updateAt,
    this.rolesId,
    // this.addresses = const [],
    // this.carts = const [],
    // this.notifications = const [],
    // this.orders = const [],
    // this.roles,
    // this.products = const [],
  });

    factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      usersId: json['UsersId'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      nickName: json['NickName'],
      email: json['Email'],
      password: json['Password'],
      phoneNumber: json['PhoneNumber'],
      birthDay: json['BirthDay'] != null ? DateTime.parse(json['BirthDay']) : null,
      imageUrl: json['ImageUrl'],
      gender: json['Gender'],
      createAt: json['CreateAt'] != null ? DateTime.parse(json['CreateAt']) : null,
      updateAt: json['UpdateAt'] != null ? DateTime.parse(json['UpdateAt']) : null,
      rolesId: json['RolesId'],
      // Bạn cần xử lý các danh sách và đối tượng Roles ở đây nếu cần
    );
  }

  Map<String, dynamic> toJson() => {
    "UsersId": usersId,
    "FirstName": firstName,
    "LastName": lastName,
    "NickName": nickName,
    "Email": email,
    "Password": password,
    "PhoneNumber": phoneNumber,
    "BirthDay": birthDay?.toIso8601String(), // Chuyển đổi DateTime sang chuỗi ISO 8601
    "ImageUrl": imageUrl,
    "Gender": gender,
    "CreateAt": createAt?.toIso8601String(), // Chuyển đổi DateTime sang chuỗi ISO 8601
    "UpdateAt": updateAt?.toIso8601String(), // Chuyển đổi DateTime sang chuỗi ISO 8601
    "RolesId": rolesId,
    // Bạn cũng cần xử lý các danh sách và đối tượng Roles ở đây nếu cần
  };
}
