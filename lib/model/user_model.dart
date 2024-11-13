class UserModel {
  final String id;
  final String nama;
  final String email;

  UserModel({
    required this.id,
    required this.nama,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      nama: map['nama'] ?? '',
      email: map['email'] ?? '',
    );
  }
}