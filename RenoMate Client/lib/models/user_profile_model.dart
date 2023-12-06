class UserProfileModel {
  String userName;
  String mobileNumber;

  UserProfileModel({
    required this.userName,
    required this.mobileNumber,
  });
}

// address_model.dart
class AddressModel {
  String block;
  String street;
  String city;
  String state;
  String pinCode;

  AddressModel({
    required this.block,
    required this.street,
    required this.city,
    required this.state,
    required this.pinCode,
  });
}
