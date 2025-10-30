class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? address;


  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
  });

  factory UserModel.fromMap(String id, Map<String, dynamic> data) {
    return UserModel(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
    );
  }
}
