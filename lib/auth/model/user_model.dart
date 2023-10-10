class UserModel {
  String? emailAddress;
  String? password;
  String? confirmPassword;
  String? firstName;
  String? lastName;

  UserModel({
    this.emailAddress,
    this.password,
    this.confirmPassword,
    this.firstName,
    this.lastName,
  });

  // Factory method to create a UserModel object from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      emailAddress: map['emailAddress'],
      password: map['password'],
      confirmPassword: map['confirmPassword'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  // Method to convert UserModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'emailAddress': emailAddress,
      'password': password,
      'confirmPassword': confirmPassword,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
