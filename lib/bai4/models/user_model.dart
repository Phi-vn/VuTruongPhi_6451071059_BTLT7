class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'website': website,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? website,
  }) {
    return UserModel(
      id: this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
    );
  }
}
