class User {
  final int id;
  final String name;
  final String? email;
  final String phone;
  final String countryCode;

  const User({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    required this.countryCode,
  });

  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        phone: data['phone'],
        countryCode: data['countryCode'],
      );
}
